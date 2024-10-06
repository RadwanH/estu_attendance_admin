import 'package:bloc/bloc.dart';
import 'package:course_repository/course_repository.dart';
import 'package:equatable/equatable.dart';

part 'edit_student_attendance_status_state.dart';

class EditStudentAttendanceStatusCubit extends Cubit<EditStudentAttendanceStatusState> {
  final AttendanceRepo attendanceRepo;


  EditStudentAttendanceStatusCubit(this.attendanceRepo) : super(EditStudentAttendanceStatusInitial());


  Future<void> editStudentAttendance({
    required Attendance attendance,
    required String studentId,
    required bool isPresent,
  }) async {
    emit(EditStudentAttendanceStatusLoading());

    try {
      // Check if the student's ID is already in the attendeesIds list
      final updatedAttendeesIds = List<String>.from(attendance.attendeesIds ?? []);

      if (isPresent && !updatedAttendeesIds.contains(studentId)) {
        // Mark as present by adding the student's ID
        updatedAttendeesIds.add(studentId);
      } else if (!isPresent && updatedAttendeesIds.contains(studentId)) {
        // Mark as absent by removing the student's ID
        updatedAttendeesIds.remove(studentId);
      }

      // Create an updated attendance object
      final updatedAttendance = attendance.copyWith(attendeesIds: updatedAttendeesIds);

      // Call repository to update the attendance in the backend
      await attendanceRepo.updateAttendance(updatedAttendance);

      emit(EditStudentAttendanceStatusSuccess(updatedAttendance));
    } catch (e) {
      emit(EditStudentAttendanceStatusFailure(e.toString()));
    }
  }
}
