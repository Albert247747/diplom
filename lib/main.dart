import 'package:diplom/data/services/push_notification/push_notification.dart';
import 'package:diplom/ui/app.dart';
import 'package:diplom/utils/translations.g.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await pushNotification.init();

  runApp(TranslationProvider(child: const App()));
}
