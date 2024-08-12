part of 'upload_picture_bloc.dart';

sealed class UploadPictureState extends Equatable {
  const UploadPictureState();

  @override
  List<Object> get props => [];
}

final class UploadPictureInitial extends UploadPictureState {}

final class UploadPictureLoading extends UploadPictureState {}

final class UploadPictureSuccess extends UploadPictureState {
  final String imgUrl;

  const UploadPictureSuccess(this.imgUrl);

  @override
  List<Object> get props => [imgUrl];
}

final class UploadPictureFailure extends UploadPictureState {
  final String message;

  const UploadPictureFailure(this.message);

  @override
  List<Object> get props => [message];
}
