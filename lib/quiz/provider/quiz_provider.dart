import 'package:flutter/cupertino.dart';
import 'package:learniverse_client/quiz/quiz.dart';

class QuizProvider extends ChangeNotifier {
  QuizProvider(this.firebaseQuizService);

  bool isLoading = false;
  List<QuizQuestion> quizQuestions = [];
  FirebaseQuizService firebaseQuizService;
  String? error;

  Future loadQuizQuestions(String chapterId) async {
    try {
      quizQuestions.clear();
      isLoading = true;
      error = null;
      notifyListeners();
      firebaseQuizService.getQuiz(chapterId).listen((event) {
        final snapshot = event.snapshot;
        if (snapshot.exists) {
          final map = snapshot.value as Map<String, dynamic>;
          List<QuizQuestion> list = [];
          map.forEach((key, value) {
            list.add(QuizQuestion.fromJson(value));
          });
          quizQuestions = list;
          notifyListeners();
        }
      });
    } catch (e) {
      error = e.toString();
    }
    isLoading = true;
    notifyListeners();
  }
}
