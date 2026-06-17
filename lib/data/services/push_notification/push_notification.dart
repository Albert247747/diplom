import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final pushNotification = PushNotification(
  localNotifications: FlutterLocalNotificationsPlugin(),
);

final class PushNotification {
  /// Плагин локальных уведомлений
  final FlutterLocalNotificationsPlugin _localNotifications;

  /// Канал для уведомлений Android
  static const AndroidNotificationChannel _defaultChannel =
  AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );

  PushNotification({
    required FlutterLocalNotificationsPlugin localNotifications,
  }) : _localNotifications = localNotifications;

  Future<void> init() async {
    try {
      const androidInit = AndroidInitializationSettings('icon_app');
      const darwinInit = DarwinInitializationSettings();

      const initSettings = InitializationSettings(
        android: androidInit,
        iOS: darwinInit,
        macOS: darwinInit,
      );

      await _localNotifications.initialize(settings: initSettings);

      final androidPlugin = _localNotifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      if (androidPlugin != null) {
        await androidPlugin.createNotificationChannel(_defaultChannel);
        await androidPlugin.requestNotificationsPermission();
      }

      final iosPlugin = _localNotifications
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >();
      await iosPlugin?.requestPermissions(alert: true, badge: true, sound: true);

      final macOsPlugin = _localNotifications
          .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin
          >();
      await macOsPlugin?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    } on Exception catch (error) {
      debugPrint('Не удалось инициализировать локальные уведомления: $error');
    }
  }

  Future<void> showShiftRegistrationStarted({
    required String eventId,
    required String title,
    required String body,
  }) async {
    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        channelDescription: 'This channel is used for important notifications.',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
      macOS: DarwinNotificationDetails(),
    );

    await _localNotifications.show(
      id: eventId.hashCode & 0x7fffffff,
      title: title,
      body: body,
      notificationDetails: notificationDetails,
    );
  }
}
