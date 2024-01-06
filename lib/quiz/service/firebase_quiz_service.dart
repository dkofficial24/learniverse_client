import 'package:firebase_database/firebase_database.dart';

class FirebaseQuizService {
  Stream<DatabaseEvent> getQuiz(String chapterId) {
    final ref = FirebaseDatabase.instance.ref('quiz/$chapterId');
    return ref.onValue;
  }
}
