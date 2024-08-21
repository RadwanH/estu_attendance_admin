import 'dart:math';

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
      final generatedCode = _generateRandomCode();

      final updatedAttendance =
          attendance.copyWith(generatedCode: generatedCode);
      Attendance addedAttendance =
          await attendanceRepo.addAttendance(updatedAttendance);
      emit(CreateAttendanceSuccess(addedAttendance));
    } catch (e) {
      emit(CreateAttendanceFailure(
        message: e.toString(),
      ));
    }
  }

  String _generateRandomCode() {
    const length = 6;
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(
      length,
      (_) => characters.codeUnitAt(random.nextInt(characters.length)),
    ));
  }
}
