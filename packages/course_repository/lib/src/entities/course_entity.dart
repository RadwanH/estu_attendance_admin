class CourseEntity {
  final String courseId;
  final String name;
  final String code;
  final String imageUrl;
  final int hours;
  final String classroom;
  final String lecturerId;
  final List<String>? attendancesIds;
  final int weeks;

  CourseEntity({
    required this.courseId,
    required this.name,
    required this.code,
    required this.imageUrl,
    required this.hours,
    required this.classroom,
    required this.lecturerId,
    this.attendancesIds,
    this.weeks = 14,
  });

  static final empty = CourseEntity(
    courseId: '',
    name: '',
    code: '',
    hours: 0,
    classroom: '',
    lecturerId: '',
    imageUrl: '',
  );

  Map<String, Object?> toDocument() {
    return {
      'courseId': courseId,
      'name': name,
      'code': code,
      'imageUrl': imageUrl,
      'hours': hours,
      'classroom': classroom,
      'lecturerId': lecturerId,
      'attendancesIds': attendancesIds,
      'weeks': weeks,
    };
  }

  static CourseEntity fromDocument(Map<String, Object?> doc) {
    return CourseEntity(
      courseId: doc['courseId'] as String,
      name: doc['name'] as String,
      code: doc['code'] as String,
      imageUrl: doc['imageUrl'] as String,
      hours: doc['hours'] as int,
      classroom: doc['classroom'] as String,
      lecturerId: doc['lecturerId'] as String,
      attendancesIds:
          (doc['attendancesIds'] as List?)?.map((e) => e as String).toList(),
      // attendances: (doc['attendances'] as List?)
      //     ?.map((e) => Attendance.fromEntity(
      //         AttendanceEntity.fromDocument(e as Map<String, Object?>)))
      //     .toList(),
      weeks: doc['weeks'] as int,
    );
  }
}
