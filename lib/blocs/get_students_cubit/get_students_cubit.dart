import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'get_students_state.dart';

class GetStudentsCubit extends Cubit<GetStudentsState> {
  final UserRepository userRepository;
  GetStudentsCubit(this.userRepository) : super(GetStudentsInitial());

  Future<void> getStudents(List<String> studentsIds) async {
    try {
      emit(GetStudentsLoading());

      print('given studentsIds: $studentsIds');
      final students = await Future.wait(
        studentsIds.map((id) => userRepository.getUserById(id)).toList(),
      );

      print('students found : $students');

      emit(GetStudentsSuccess(students));
    } catch (e) {
      emit(GetStudentsFailure('Failed to load students ${e.toString()} '));
    }
  }
}
