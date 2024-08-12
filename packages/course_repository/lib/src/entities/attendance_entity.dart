import 'package:user_repository/user_repository.dart';

class AttendanceEntity {
  final String id;
  final String lecturerId;
  final String courseId;
  final int week;
  final DateTime? date;
  final int timer;
  final String generatedCode;
  final List<String> attendeesIds;
  final List<int> forHours;

  AttendanceEntity({
    required this.id,
    required this.lecturerId,
    required this.courseId,
    required this.week,
    DateTime? date,
    required this.timer,
    required this.generatedCode,
    required this.attendeesIds,
    required this.forHours,
  }) : this.date = date ?? DateTime.now();

  static final empty = AttendanceEntity(
    id: '',
    lecturerId: '',
    courseId: '',
    week: 0,
    date: DateTime.now(),
    timer: 0,
    generatedCode: '',
    attendeesIds: [],
    forHours: [],
  );

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'lecturerId': lecturerId,
      'courseId': courseId,
      'week': week,
      'date': date,
      'timer': timer,
      'generatedCode': generatedCode,
      'attendeesIds': attendeesIds,
      'forHours': forHours,
    };
  }

  static AttendanceEntity fromDocument(Map<String, Object?> doc) {
    return AttendanceEntity(
      id: doc['id'] as String,
      lecturerId: doc['lecturerId'] as String,
      courseId: doc['courseId'] as String,
      week: doc['week'] as int,
      date: doc['date'] as DateTime,
      timer: doc['timer'] as int,
      generatedCode: doc['generatedCode'] as String,
      attendeesIds: doc['attendeesIds'] as List<String>,
      forHours: doc['forHours'] as List<int>,
    );
  }
}
