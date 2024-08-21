part of 'current_attendance_cubit.dart';

sealed class CurrentAttendanceState extends Equatable {
  const CurrentAttendanceState();

  @override
  List<Object> get props => [];
}

final class CurrentAttendanceInitial extends CurrentAttendanceState {}

class CurrentAttendanceInProgress extends CurrentAttendanceState {
  final Attendance attendance;
  final String generatedCode;
  final int remainingTime;

  CurrentAttendanceInProgress(
      this.attendance, this.generatedCode, this.remainingTime);

  @override
  List<Object> get props => [attendance, generatedCode, remainingTime];
}

class CurrentAttendanceSessionEnded extends CurrentAttendanceState {
  final Attendance attendance;

  CurrentAttendanceSessionEnded(this.attendance);

  @override
  List<Object> get props => [attendance];
}

class CurrentAttendanceSuccess extends CurrentAttendanceState {
  final Attendance attendance;
  final String message;

  CurrentAttendanceSuccess(this.attendance, this.message);

  @override
  List<Object> get props => [attendance, message];
}

class CurrentAttendanceFailure extends CurrentAttendanceState {
  final String message;

  CurrentAttendanceFailure(this.message);

  @override
  List<Object> get props => [message];
}


