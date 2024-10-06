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
      // Create a copy of attendeesIds to avoid mutating the original list
      final updatedAttendeesIds =
          List<String>.from(attendance.attendeesIds ?? []);

      // Update the attendeesIds based on presence or absence
      if (isPresent && !updatedAttendeesIds.contains(studentId)) {
        updatedAttendeesIds.add(studentId);
      } else if (!isPresent && updatedAttendeesIds.contains(studentId)) {
        updatedAttendeesIds.remove(studentId);
      }

      // Create a new Attendance object with updated attendeesIds
      final updatedAttendance = attendance.copyWith(
        attendeesIds: updatedAttendeesIds,
      );

      // Update the attendance record in the repository
      await attendanceRepo.updateAttendance(updatedAttendance);

      // Emit the success state with the updated Attendance object
      emit(EditStudentAttendanceStatusSuccess(updatedAttendance));
    } catch (e) {
      emit(EditStudentAttendanceStatusFailure(e.toString()));
    }
  }
}
