import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:course_repository/course_repository.dart';
import 'package:equatable/equatable.dart';

part 'current_attendance_state.dart';

class CurrentAttendanceCubit extends Cubit<CurrentAttendanceState> {
  final AttendanceRepo attendanceRepo;
  CurrentAttendanceCubit(this.attendanceRepo)
      : super(CurrentAttendanceInitial());

  void startAttendanceSession(Attendance attendance) {
    final generatedCode = attendance.generatedCode;
    emit(CurrentAttendanceInProgress(
        attendance, generatedCode, attendance.timer));
    _startTimer(attendance.timer);
  }

  void _startTimer(int initialTimerDuration) {
    int remainingTime = initialTimerDuration * 60;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        remainingTime--;
        if (state is CurrentAttendanceInProgress) {
          final currentState = state as CurrentAttendanceInProgress;
          emit(
            CurrentAttendanceInProgress(
              currentState.attendance,
              currentState.generatedCode,
              remainingTime,
            ),
          );
        } else {
          timer.cancel();
        }
      } else {
        timer.cancel();
        if (state is CurrentAttendanceInProgress) {
          final currentState = state as CurrentAttendanceInProgress;
          _deactivateAttendance(currentState.attendance);
          emit(CurrentAttendanceSessionEnded(
            currentState.attendance,
          ));
        }
      }
    });
  }

  void _deactivateAttendance(Attendance attendance) {
    try {
      attendanceRepo.updateAttendance(attendance.copyWith(isActive: false));
    } catch (e) {
      emit(CurrentAttendanceFailure(
          "Failed to deactivate attendance! ${e.toString()}"));
    }
  }

  void submitCode(String code, String studentId) {
    if (state is CurrentAttendanceInProgress) {
      final currentState = state as CurrentAttendanceInProgress;
      if (code == currentState.generatedCode &&
          currentState.remainingTime > 0) {
        final updatedAttendees =
            List<String>.from(currentState.attendance.attendeesIds ?? []);
        updatedAttendees.add(studentId);
        final updatedAttendance =
            currentState.attendance.copyWith(attendeesIds: updatedAttendees);
        emit(CurrentAttendanceInProgress(updatedAttendance,
            currentState.generatedCode, currentState.remainingTime));
        emit(CurrentAttendanceSuccess(
            updatedAttendance, "Attendance recorded for $studentId!"));
      } else {
        emit(CurrentAttendanceFailure("Incorrect code or session expired!"));
      }
    }
  }
}
