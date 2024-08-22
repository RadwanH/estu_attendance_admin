import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_repository/src/attendance_repo.dart';
import 'package:course_repository/src/models/attendance.dart';

import 'entities/entities.dart';

class FirebaseAttendanceRepo implements AttendanceRepo {
  final attendanceCollection =
      FirebaseFirestore.instance.collection('attendances');

  @override
  Future<Attendance> addAttendance(Attendance courseAttendance) async {
    try {
      final docRef = await attendanceCollection
          .add(courseAttendance.toEntity().toDocument());

      final generatedId = docRef.id;

      // Update the Firestore document with the generated ID
      await docRef.update({'id': generatedId});

      // Return the attendance with the generated ID
      return courseAttendance.copyWith(id: generatedId);
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
  Future<Attendance> updateAttendance(Attendance courseAttendance) async {
    try {
      final docRef = attendanceCollection.doc(courseAttendance.id);
      final data = courseAttendance.toEntity().toDocument();

      log('Updating document at ${docRef.path} with data: $data');

      final docSnapshot = await docRef.get();
      if (!docSnapshot.exists) {
        log('Attempting to update document with ID: ${courseAttendance.id}');
        throw Exception('Document does not exist.');
      }

      await docRef.update(data);
      return courseAttendance;
    } catch (e, stackTrace) {
      log('Error updating attendance: ${e.toString()}');
      log('Stack trace: ${stackTrace.toString()}');
      rethrow;
    }
  }

  @override
  Future<List<Attendance>> getCourseAttendances(String courseId) {
    try {
      return attendanceCollection
          .where('courseId', isEqualTo: courseId)
          .get()
          .then((snapshot) => snapshot.docs
              .map((doc) => Attendance.fromEntity(
                  AttendanceEntity.fromDocument(doc.data())))
              .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
