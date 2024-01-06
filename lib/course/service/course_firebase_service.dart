import 'package:firebase_database/firebase_database.dart';

class CourseFirebaseService {
  Stream<DatabaseEvent> listenAllCourses() {
    final databaseRef = FirebaseDatabase.instance.ref();
    return databaseRef.child('courses').onValue;
  }
}
