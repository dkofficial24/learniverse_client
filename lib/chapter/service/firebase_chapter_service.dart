import 'package:firebase_database/firebase_database.dart';
import 'package:learniverse_client/chapter/chapter.dart';

class ChapterFirebaseService {

  Stream<DatabaseEvent> getAllChapters(String courseId) {
    return FirebaseDatabase.instance.ref('chapter').child(courseId).onValue;
  }
}
