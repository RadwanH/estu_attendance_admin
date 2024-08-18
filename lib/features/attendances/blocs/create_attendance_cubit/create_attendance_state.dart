part of 'create_attendance_cubit.dart';

sealed class CreateAttendanceState extends Equatable {
  const CreateAttendanceState();

  @override
  List<Object> get props => [];
}

final class CreateAttendanceInitial extends CreateAttendanceState {}

final class CreateAttendanceLoading extends CreateAttendanceState {}

final class CreateAttendanceSuccess extends CreateAttendanceState {
  final Attendance attendance;

  const CreateAttendanceSuccess(this.attendance);

  @override
  List<Object> get props => [attendance];
}

final class CreateAttendanceFailure extends CreateAttendanceState {
  final String message;

  const CreateAttendanceFailure({required this.message});

  @override
  List<Object> get props => [message];
}
