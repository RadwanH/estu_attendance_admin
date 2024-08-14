import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_repository/src/attendance_repo.dart';
import 'package:course_repository/src/models/attendance.dart';

import 'entities/entities.dart';

class FirebaseAttendanceRepo implements AttendanceRepo {
  final attendanceCollection =
      FirebaseFirestore.instance.collection('attendances');

  @override
  Future<Attendance> addAttendance(Attendance courseAttendance) {
    try {
      return attendanceCollection
          .add(courseAttendance.toEntity().toDocument())
          .then((doc) => courseAttendance);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Attendance> getAttendance(String id) async {
    try {
      return await attendanceCollection.doc(id).get().then((doc) =>
          Attendance.fromEntity(AttendanceEntity.fromDocument(doc.data()!)));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Attendance>> getAttendances() async {
    try {
      return await attendanceCollection.get().then((snapshot) => snapshot.docs
          .map((doc) =>
              Attendance.fromEntity(AttendanceEntity.fromDocument(doc.data())))
          .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> deleteCourseAttendance(String id) {
    try {
      return attendanceCollection.doc(id).delete();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Attendance> updateAttendance(Attendance courseAttendance) {
    try {
      return attendanceCollection
          .doc(courseAttendance.id)
          .update(courseAttendance.toEntity().toDocument())
          .then((_) => courseAttendance);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
