part of 'get_students_cubit.dart';

sealed class GetStudentsState extends Equatable {
  const GetStudentsState();

  @override
  List<Object> get props => [];
}

final class GetStudentsInitial extends GetStudentsState {}
final class GetStudentsLoading extends GetStudentsState {}
final class GetStudentsSuccess extends GetStudentsState {
   final List<MyUser> students;

  const GetStudentsSuccess(this.students);
  @override
  List<Object> get props => [students];
}

final class GetStudentsFailure extends GetStudentsState {
  final String message;

  const GetStudentsFailure(this.message);

  @override
  List<Object> get props => [message];
}