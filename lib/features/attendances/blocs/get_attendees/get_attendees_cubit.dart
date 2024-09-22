import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_attendees_state.dart';

class GetAttendeesCubit extends Cubit<GetAttendeesState> {
  GetAttendeesCubit() : super(GetAttendeesInitial());
}
