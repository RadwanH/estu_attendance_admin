part of 'get_attendees_cubit.dart';

sealed class GetAttendeesState extends Equatable {
  const GetAttendeesState();

  @override
  List<Object> get props => [];
}

final class GetAttendeesInitial extends GetAttendeesState {}
