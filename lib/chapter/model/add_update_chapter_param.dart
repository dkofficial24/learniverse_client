
import 'package:learniverse_client/chapter/chapter.dart';

class AddEditChapterParam {
  final String courseId;
  Chapter? chapter;

  AddEditChapterParam({
    required this.courseId,
    this.chapter,
  });
}
