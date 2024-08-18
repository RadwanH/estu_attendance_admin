part of 'get_attendances_bloc.dart';

sealed class GetAttendancesState extends Equatable {
  const GetAttendancesState();

  @override
  List<Object> get props => [];
}

final class GetAttendancesInitial extends GetAttendancesState {}

final class GetAttendancesLoading extends GetAttendancesState {}

final class GetAttendancesSuccess extends GetAttendancesState {
  final List<Attendance> attendances;

  const GetAttendancesSuccess({required this.attendances});

  @override
  List<Object> get props => [attendances];
}

final class GetAttendancesFailure extends GetAttendancesState {
  final String message;

  const GetAttendancesFailure({required this.message});

  @override
  List<Object> get props => [message];
}
