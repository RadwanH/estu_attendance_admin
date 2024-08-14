import 'package:bloc/bloc.dart';
import 'package:course_repository/course_repository.dart';
import 'package:equatable/equatable.dart';

part 'create_attendance_state.dart';

class CreateAttendanceCubit extends Cubit<CreateAttendanceState> {
  final AttendanceRepo attendanceRepo;

  CreateAttendanceCubit({required this.attendanceRepo})
      : super(CreateAttendanceInitial());

  void createAttendance(Attendance attendance) async {
    emit(CreateAttendanceLoading());

    try {
      Attendance addedAttendance =
          await attendanceRepo.addAttendance(attendance);
      emit(CreateAttendanceSuccess(addedAttendance));
    } catch (e) {
      emit(CreateAttendanceFailure(
        message: e.toString(),
      ));
    }
  }
}
