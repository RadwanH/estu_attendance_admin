import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:course_repository/course_repository.dart';
import 'package:equatable/equatable.dart';

part 'upload_picture_event.dart';
part 'upload_picture_state.dart';

class UploadPictureBloc extends Bloc<UploadPictureEvent, UploadPictureState> {
  final CourseRepo _courseRepo;

  UploadPictureBloc(this._courseRepo) : super(UploadPictureLoading()) {
    on<UploadPicture>((event, emit) async {
      try {
        String imgUrl =
            await _courseRepo.uploadImage(event.file, event.className);

        emit(UploadPictureSuccess(imgUrl));
      } catch (e) {
        emit(UploadPictureFailure(e.toString()));
      }
    });
  }
}
