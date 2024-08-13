part of 'create_course_cubit.dart';

sealed class CreateCourseState extends Equatable {
  const CreateCourseState();

  @override
  List<Object> get props => [];
}

final class CreateCourseInitial extends CreateCourseState {}

final class CreateCourseLoading extends CreateCourseState {}

final class CreateCourseSuccess extends CreateCourseState {
  final Course course;

  const CreateCourseSuccess(this.course);

  @override
  List<Object> get props => [course];
}

final class CreateCourseFailure extends CreateCourseState {
  final String message;

  const CreateCourseFailure({required this.message});

  @override
  List<Object> get props => [message];
}
