import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:learniverse_client/core/core.dart';
import 'package:learniverse_client/course/course.dart';

class CourseProvider extends ChangeNotifier {
  CourseProvider(this.courseFirebaseService);

  CourseFirebaseService courseFirebaseService;

  StreamSubscription<DatabaseEvent>? _courseSubscription;

  bool isLoading = false;
  String? error;

  List<Course> courseList = [];

  Future<void> fetchAllCourses() async {
    try {
      setLoadingState(true);

      _courseSubscription =
          courseFirebaseService.listenAllCourses().listen((event) {
        DataSnapshot snapshot = event.snapshot;

        if (snapshot.exists) {
          updateCourseList(Map<String, dynamic>.from(snapshot.value as Map));
        } else {
          throw 'Course does not exist';
        }
      });
    } catch (e) {
      setErrorState(e.toString());
    } finally {
      setLoadingState(false);
    }
  }

  void setLoadingState(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  void setErrorState(String errorMessage) {
    error = errorMessage;
    notifyListeners();
  }

  void updateCourseList(Map<String, dynamic> data) {
    List<Course> courses = [];
    data.forEach((key, value) {
      courses.add(
        Course.fromJson(
          Map<String, dynamic>.from(value as Map),
        ),
      );
    });
    courseList = courses;
    notifyListeners();
  }

  void closeStream() {
    _courseSubscription?.cancel();
  }
}
