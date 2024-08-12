import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_repository/course_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class FirebaseCourseRepo implements CourseRepo {
  final courseCollection = FirebaseFirestore.instance.collection('courses');
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<List<Course>> getCourses() async {
    try {
      return await courseCollection.get().then((snapshot) => snapshot.docs
          .map(
              (doc) => Course.fromEntity(CourseEntity.fromDocument(doc.data())))
          .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Course> getCourse(String id) async {
    try {
      return await courseCollection.doc(id).get().then(
          (doc) => Course.fromEntity(CourseEntity.fromDocument(doc.data()!)));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Course> addCourse(Course course) {
    try {
      return courseCollection
          .add(course.toEntity().toDocument())
          .then((doc) => course);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> deleteCourse(String id) {
    try {
      return courseCollection.doc(id).delete();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Course> updateCourse(Course course) {
    try {
      return courseCollection
          .doc(course.courseId)
          .update(course.toEntity().toDocument())
          .then((_) => course);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<String> uploadImage(Uint8List file, String childName) async {
    try {
      // Creating a unique id for the image
      final imgId = const Uuid().v1();

      //creating location to our firebase storage
      Reference ref = _storage
          .ref()
          .child(childName)
          .child(_auth.currentUser!.uid)
          .child(imgId);

      UploadTask uploadTask =
          ref.putData(file, SettableMetadata(contentType: 'image/jpeg'));

      TaskSnapshot snap = await uploadTask;
      String downloadUrl = await snap.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
