import 'package:bloc/bloc.dart';
import 'package:course_repository/course_repository.dart';
import 'package:equatable/equatable.dart';

part 'get_lecturer_courses_event.dart';
part 'get_lecturer_courses_state.dart';

class GetLecturerCoursesBloc
    extends Bloc<GetLecturerCoursesEvent, GetLecturerCoursesState> {
  final CourseRepo _courseRepo;

  GetLecturerCoursesBloc(this._courseRepo)
      : super(GetLecturerCoursesInitial()) {
    on<GetLecturerCourses>((event, emit) async {
      emit(GetLecturerCoursesLoading());
      try {
        final courses = await _courseRepo.getCourses();

        final List<Course> lecturerCourses = courses
            .where((course) => course.lecturerId == event.lecturerId)
            .toList();

        emit(GetLecturerCoursesSuccess(lecturerCourses));
      } catch (e) {
        emit(GetLecturerCoursesFailure(e.toString()));
      }
    });
  }
}
