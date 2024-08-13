part of 'get_lecturer_courses_bloc.dart';

sealed class GetLecturerCoursesEvent extends Equatable {
  const GetLecturerCoursesEvent();

  @override
  List<Object> get props => [];
}

class GetLecturerCourses extends GetLecturerCoursesEvent {
  final String lecturerId;

  GetLecturerCourses(this.lecturerId);

  @override
  List<Object> get props => [lecturerId];
}
