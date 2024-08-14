import 'models/models.dart';

abstract class AttendanceRepo {
  Future<Attendance> addAttendance(Attendance attendance);
  Future<List<Attendance>> getAttendances();

  Future<Attendance> getAttendance(String id);

  Future<Attendance> updateAttendance(Attendance attendance);
  Future<void> deleteCourseAttendance(String id);
}