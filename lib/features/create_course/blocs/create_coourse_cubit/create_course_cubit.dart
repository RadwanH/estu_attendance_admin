import 'package:bloc/bloc.dart';
import 'package:course_repository/course_repository.dart';
import 'package:equatable/equatable.dart';

part 'create_course_state.dart';

class CreateCourseCubit extends Cubit<CreateCourseState> {
  final CourseRepo courseRepo;
  CreateCourseCubit({required this.courseRepo}) : super(CreateCourseInitial());

  void createCourse(Course course) async {
    emit(CreateCourseLoading());

    try {
      Course addedCourse = await courseRepo.addCourse(course);
      emit(CreateCourseSuccess(addedCourse));
    } catch (e) {
      emit(CreateCourseFailure(
        message: e.toString(),
      ));
    }
  }
}
