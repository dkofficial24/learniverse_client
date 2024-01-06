import 'package:learniverse_client/chapter/chapter.dart';
import 'package:learniverse_client/course/course.dart';
import 'package:learniverse_client/quiz/quiz.dart';

class DI {
  static late CourseFirebaseService _courseFirebaseService;
  static late ChapterFirebaseService _chapterFirebaseService;
  static late FirebaseQuizService _quizFirebaseService;

  static void init() {
    _courseFirebaseService = CourseFirebaseService();
    _chapterFirebaseService = ChapterFirebaseService();
    _quizFirebaseService = FirebaseQuizService();
  }

  static CourseFirebaseService getCourseFirebaseService() =>
      _courseFirebaseService;

  static ChapterFirebaseService getChapterFirebaseService() =>
      _chapterFirebaseService;

  static FirebaseQuizService getQuizFirebaseService() => _quizFirebaseService;
}
