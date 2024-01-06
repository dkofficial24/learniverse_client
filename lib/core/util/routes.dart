import 'package:go_router/go_router.dart';
import 'package:learniverse_client/chapter/chapter.dart';
import 'package:learniverse_client/core/core.dart';
import 'package:learniverse_client/course/ui/list_course_screen.dart';
import 'package:learniverse_client/quiz/quiz.dart';

GoRouter getRouter() => _router;

final _router = GoRouter(
  initialLocation: RoutesName.homeScreen,
  routes: [
    GoRoute(
        path: RoutesName.homeScreen,
        builder: (context, state) => const ListCourseScreen(),
        routes: [
          GoRoute(
            path: RoutesName.listChapterScreen,
            builder: (context, state) => ListChapterScreen(
              courseId: state.extra as String,
            ),
          ),
          GoRoute(
            path: RoutesName.chapterScreen,
            builder: (context, state) => ChapterScreen(
              chapter: state.extra as Chapter,
            ),
          ),
          GoRoute(
            path: RoutesName.quizScreen,
            builder: (context, state) => QuizListScreen(
              chapterId: state.extra as String,
            ),
          ),
        ]),
  ],
);
