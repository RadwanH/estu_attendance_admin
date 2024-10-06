part of 'edit_student_attendance_status_cubit.dart';

sealed class EditStudentAttendanceStatusState extends Equatable {
  const EditStudentAttendanceStatusState();

  @override
  List<Object> get props => [];
}

final class EditStudentAttendanceStatusInitial extends EditStudentAttendanceStatusState {}

final class EditStudentAttendanceStatusLoading extends EditStudentAttendanceStatusState {}

final class EditStudentAttendanceStatusSuccess extends EditStudentAttendanceStatusState {
  final Attendance attendance;

  const EditStudentAttendanceStatusSuccess(this.attendance);

  @override
  List<Object> get props => [attendance];
}

final class EditStudentAttendanceStatusFailure extends EditStudentAttendanceStatusState {
  final String error;

  const EditStudentAttendanceStatusFailure(this.error);

  @override
  List<Object> get props => [error];
}


