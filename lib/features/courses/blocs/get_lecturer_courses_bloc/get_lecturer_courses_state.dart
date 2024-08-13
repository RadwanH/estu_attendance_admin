part of 'get_lecturer_courses_bloc.dart';

sealed class GetLecturerCoursesState extends Equatable {
  const GetLecturerCoursesState();

  @override
  List<Object> get props => [];
}

final class GetLecturerCoursesInitial extends GetLecturerCoursesState {}

final class GetLecturerCoursesLoading extends GetLecturerCoursesState {}

final class GetLecturerCoursesSuccess extends GetLecturerCoursesState {
  final List<Course> courses;

  GetLecturerCoursesSuccess(this.courses);

  @override
  List<Object> get props => [courses];
}

final class GetLecturerCoursesFailure extends GetLecturerCoursesState {
  final String message;

  const GetLecturerCoursesFailure(this.message);

  @override
  List<Object> get props => [message];
}
