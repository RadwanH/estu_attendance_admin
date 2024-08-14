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
      forHours: [],
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
      forHours: [],
    );
  }
}
