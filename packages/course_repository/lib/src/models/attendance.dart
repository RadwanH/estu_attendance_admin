// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:user_repository/user_repository.dart';
import 'package:uuid/uuid.dart';

import '../entities/entities.dart';

class Attendance {
  final String id;
  final String lecturerId;
  final String courseId;
  final int week;
  final DateTime? date;
  final int timer;
  final List<String>? attendeesIds;
  final List<int> forHours;

  Attendance({
    required this.id,
    required this.lecturerId,
    required this.courseId,
    required this.week,
    DateTime? date,
    required this.timer,
    this.attendeesIds,
    required this.forHours,
  }) : this.date = date ?? DateTime.now();

  static final empty = Attendance(
    id: const Uuid().v1(),
    lecturerId: '',
    courseId: '',
    week: 0,
    date: DateTime.now(),
    timer: 0,
    attendeesIds: [],
    forHours: [],
  );

  AttendanceEntity toEntity() {
    return AttendanceEntity(
      id: id,
      lecturerId: lecturerId,
      courseId: courseId,
      week: week,
      date: date,
      timer: timer,
      attendeesIds: attendeesIds!,
      forHours: forHours,
    );
  }

  static Attendance fromEntity(AttendanceEntity entity) {
    return Attendance(
      id: entity.id,
      lecturerId: entity.lecturerId,
      courseId: entity.courseId,
      week: entity.week,
      date: entity.date,
      timer: entity.timer,
      attendeesIds: entity.attendeesIds,
      forHours: entity.forHours,
    );
  }

  Attendance copyWith({
    String? id,
    String? lecturerId,
    String? courseId,
    int? week,
    DateTime? date,
    int? timer,
    List<String>? attendeesIds,
    List<int>? forHours,
  }) {
    return Attendance(
      id: id ?? this.id,
      lecturerId: lecturerId ?? this.lecturerId,
      courseId: courseId ?? this.courseId,
      week: week ?? this.week,
      date: date ?? this.date,
      timer: timer ?? this.timer,
      attendeesIds: attendeesIds ?? this.attendeesIds,
      forHours: forHours ?? this.forHours,
    );
  }

  @override
  String toString() {
    return '''Attendance(
    id: $id, 
    lecturerId: $lecturerId, 
    courseId: $courseId, 
    week: $week, 
    date: $date, 
    timer: $timer, 
    attendeesIds: $attendeesIds, 
    forHours: $forHours)''';
  }
}
