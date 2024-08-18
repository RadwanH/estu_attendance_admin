part of 'get_attendances_bloc.dart';

sealed class GetAttendancesEvent extends Equatable {
  const GetAttendancesEvent();

  @override
  List<Object> get props => [];
}

class GetAttendances extends GetAttendancesEvent {
  final String courseId;

  const GetAttendances({required this.courseId});

  @override
  List<Object> get props => [courseId];
}
