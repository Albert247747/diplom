import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  const EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    required this.startAt,
    required this.endAt,
    required this.role,
    required this.workerCount,
    required this.salary,
    required this.status,
    required this.assignedWorkerIds,
    required this.assignedWorkers,
  });

  final String id;
  final String title;
  final String description;
  final String location;
  final DateTime date;
  final DateTime startAt;
  final DateTime endAt;
  final String role;
  final int workerCount;
  final int salary;
  final String status;
  final List<String> assignedWorkerIds;
  final List<Map<String, dynamic>> assignedWorkers;

  factory EventModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();

    if (data == null) {
      return EventModel(
        id: doc.id,
        title: '',
        description: '',
        location: '',
        date: DateTime.now(),
        startAt: DateTime.now(),
        endAt: DateTime.now(),
        role: '',
        workerCount: 0,
        salary: 0,
        status: 'open',
        assignedWorkerIds: const [],
        assignedWorkers: const [],
      );
    }

    final assignedWorkers =
        (data['assignedWorkers'] as List?)
            ?.whereType<Map>()
            .map((item) => Map<String, dynamic>.from(item))
            .toList() ??
        <Map<String, dynamic>>[];

    final assignedWorkerIds =
        {
          ...(data['assignedWorkerIds'] as List?)?.map((id) => id.toString()) ??
              <String>[],
          ...assignedWorkers
              .map((worker) => worker['uid']?.toString() ?? '')
              .where((uid) => uid.isNotEmpty),
        }.toList();

    return EventModel(
      id: doc.id,
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      location: data['location'] as String? ?? '',
      date: _readDate(data['date']),
      startAt: _readDate(data['startAt']),
      endAt: _readDate(data['endAt']),
      role: data['role'] as String? ?? '',
      workerCount: (data['workerCount'] as num?)?.toInt() ?? 0,
      salary: (data['salary'] as num?)?.toInt() ?? 0,
      status: data['status'] as String? ?? 'open',
      assignedWorkerIds: assignedWorkerIds,
      assignedWorkers: assignedWorkers,
    );
  }

  int get assignedCount => assignedWorkerIds.toSet().length;

  bool get isFull => workerCount > 0 && assignedCount >= workerCount;

  bool isBookedBy(String uid) => assignedWorkerIds.contains(uid);

  String get roleTitle => roleTitleFromRole(role);

  static String roleTitleFromRole(String role) {
    switch (role) {
      case 'bartender':
        return 'Бармен';
      case 'waiter':
        return 'Официант';
      case 'cook':
        return 'Повар';
      default:
        return role;
    }
  }

  String get formattedDate {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day.$month.${date.year}';
  }

  String get formattedTime => '${_formatTime(startAt)} - ${_formatTime(endAt)}';

  static DateTime _readDate(Object? value) {
    if (value is Timestamp) {
      return value.toDate();
    }

    if (value is DateTime) {
      return value;
    }

    return DateTime.now();
  }

  static String _formatTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
