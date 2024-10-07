import 'package:cloud_firestore/cloud_firestore.dart';
class AttendanceEntity {
  final String id;
  final String lecturerId;
  final String courseId;
  final int week;
  final DateTime? date;
  final int timer;
  final List<String>? attendeesIds;
  final List<int> forHours;
  final bool isActive;
  final String generatedCode;

  AttendanceEntity({
    required this.id,
    required this.lecturerId,
    required this.courseId,
    required this.week,
    DateTime? date,
    required this.timer,
    this.attendeesIds,
    required this.forHours,
    required this.isActive,
    required this.generatedCode,
  }) : this.date = date ?? DateTime.now();

  static final empty = AttendanceEntity(
    id: '',
    lecturerId: '',
    courseId: '',
    week: 0,
    date: DateTime.now(),
    timer: 0,
    forHours: [],
    generatedCode: '',
    isActive: false,
  );

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'lecturerId': lecturerId,
      'courseId': courseId,
      'week': week,
      'date': date,
      'timer': timer,
      'attendeesIds': attendeesIds,
      'forHours': forHours,
      'isActive': isActive,
      'generatedCode': generatedCode,
    };
  }

  static AttendanceEntity fromDocument(Map<String, Object?> doc) {
    return AttendanceEntity(
      id: doc['id'] as String,
      lecturerId: doc['lecturerId'] as String,
      courseId: doc['courseId'] as String,
      week: doc['week'] as int,
      date: doc['date'] != null ? (doc['date'] as Timestamp).toDate() : null,
      timer: doc['timer'] as int,
      attendeesIds: (doc['attendeesIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      forHours:
          (doc['forHours'] as List<dynamic>?)?.map((e) => e as int).toList() ??
              [],
      isActive: doc['isActive'] as bool,
      generatedCode: doc['generatedCode'] as String,
    );
  }
}
