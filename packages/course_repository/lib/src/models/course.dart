// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:uuid/uuid.dart';

import '../entities/entities.dart';

class Course {
  String courseId;
  String name;
  String code;
  String imageUrl;
  int hours;
  String classroom;
  String lecturerId;
  List<String>? attendancesIds;
  List<String>? studentsIds;
  int weeks;

  Course({
    required this.courseId,
    required this.name,
    required this.code,
    required this.imageUrl,
    required this.hours,
    required this.classroom,
    required this.lecturerId,
    this.attendancesIds,
    this.studentsIds,
    this.weeks = 14,
  });

  static final empty = Course(
    courseId: const Uuid().v1(),
    name: '',
    code: '',
    hours: 0,
    classroom: '',
    lecturerId: '',
    imageUrl: '',
  );

  CourseEntity toEntity() {
    return CourseEntity(
      courseId: courseId,
      name: name,
      code: code,
      imageUrl: imageUrl,
      hours: hours,
      classroom: classroom,
      lecturerId: lecturerId,
      weeks: weeks,
      attendancesIds: attendancesIds,
      
    );
  }

  static Course fromEntity(CourseEntity entity) {
    return Course(
      courseId: entity.courseId,
      name: entity.name,
      code: entity.code,
      imageUrl: entity.imageUrl,
      hours: entity.hours,
      classroom: entity.classroom,
      lecturerId: entity.lecturerId,
      attendancesIds: entity.attendancesIds,
      // attendances: entity.attendances,
      weeks: entity.weeks,
    );
  }

  @override
  String toString() {
    return '''Course {
     courseId: $courseId, 
     name: $name, 
     code: $code, 
     imageUrl: $imageUrl, 
     hours: $hours, 
     classroom: $classroom, 
     lecturerId: $lecturerId, 
     attendancesIds: $attendancesIds, 
     weeks: $weeks }''';
  }

  
 

  Course copyWith({
    String? courseId,
    String? name,
    String? code,
    String? imageUrl,
    int? hours,
    String? classroom,
    String? lecturerId,
    List<String>? attendancesIds,
    int? weeks,
  }) {
    return Course(
      courseId: courseId ?? this.courseId,
      name: name ?? this.name,
      code: code ?? this.code,
      imageUrl: imageUrl ?? this.imageUrl,
      hours: hours ?? this.hours,
      classroom: classroom ?? this.classroom,
      lecturerId: lecturerId ?? this.lecturerId,
      attendancesIds: attendancesIds ?? this.attendancesIds,
      weeks: weeks ?? this.weeks,
    );
  }
}
