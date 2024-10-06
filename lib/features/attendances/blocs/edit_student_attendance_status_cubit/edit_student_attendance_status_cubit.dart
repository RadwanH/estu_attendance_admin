import 'package:bloc/bloc.dart';
import 'package:course_repository/course_repository.dart';
import 'package:equatable/equatable.dart';

part 'edit_student_attendance_status_state.dart';

class EditStudentAttendanceStatusCubit
    extends Cubit<EditStudentAttendanceStatusState> {
  final AttendanceRepo attendanceRepo;

  EditStudentAttendanceStatusCubit(this.attendanceRepo)
      : super(EditStudentAttendanceStatusInitial());

  Future<void> editStudentAttendance({
    required Attendance attendance,
    required String studentId,
    required bool isPresent,
  }) async {
    emit(EditStudentAttendanceStatusLoading());

    try {
      final updatedAttendeesIds =
          List<String>.from(attendance.attendeesIds ?? []);

      if (isPresent && !updatedAttendeesIds.contains(studentId)) {
        updatedAttendeesIds.add(studentId);
      } else if (!isPresent && updatedAttendeesIds.contains(studentId)) {
        updatedAttendeesIds.remove(studentId);
      }

      final updatedAttendance = attendance.copyWith(
        attendeesIds: updatedAttendeesIds,
      );

      await attendanceRepo.updateAttendance(updatedAttendance);

      emit(EditStudentAttendanceStatusSuccess(updatedAttendance));
    } catch (e) {
      emit(EditStudentAttendanceStatusFailure(e.toString()));
    }
  }
}
