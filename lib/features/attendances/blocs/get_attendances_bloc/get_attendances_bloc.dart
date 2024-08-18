import 'package:bloc/bloc.dart';
import 'package:course_repository/course_repository.dart';
import 'package:equatable/equatable.dart';

part 'get_attendances_event.dart';
part 'get_attendances_state.dart';

class GetAttendancesBloc
    extends Bloc<GetAttendancesEvent, GetAttendancesState> {
  final AttendanceRepo _attendanceRepo;

  GetAttendancesBloc(this._attendanceRepo) : super(GetAttendancesInitial()) {
    on<GetAttendances>((event, emit) async {
      emit(GetAttendancesLoading());
      try {
        final attendances =
            await _attendanceRepo.getCourseAttendances(event.courseId);

        print('attendances from the bloc: ${attendances.toString()}');

        emit(GetAttendancesSuccess(attendances: attendances));
      } catch (e) {
        emit(GetAttendancesFailure(message: e.toString()));
      }
    });
  }
}
