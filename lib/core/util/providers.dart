
import 'package:learniverse_client/chapter/chapter.dart';
import 'package:learniverse_client/core/core.dart';
import 'package:learniverse_client/quiz/quiz.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../course/course.dart';

List<SingleChildWidget> initProviders = [
  ChangeNotifierProvider<CourseProvider>(
    create: (_) => CourseProvider(
      DI.getCourseFirebaseService(),
    ),
  ),
  ChangeNotifierProvider<ChapterProvider>(
    create: (_) => ChapterProvider(
      DI.getChapterFirebaseService(),
    ),
  ),
  ChangeNotifierProvider<QuizProvider>(
    create: (_) => QuizProvider(
      DI.getQuizFirebaseService(),
    ),
  ),
];
