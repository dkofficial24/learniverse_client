import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:learniverse_client/chapter/chapter.dart';

class ChapterProvider extends ChangeNotifier {
  ChapterProvider(this.chapterService);

  ChapterFirebaseService chapterService;
  bool isLoading = true;
  String? error;
  Chapter? selectedChapter;

  List<Chapter> chapterList = [];

  void onChapterSelect(int index) {
    selectedChapter = chapterList[index];
    notifyListeners();
  }

  void subscribeChapterEvents(String courseId) {
    try {
      chapterList.clear(); //todo fix it
      _setLoadingState(true);
      chapterService.getAllChapters(courseId).listen((event) {
        DataSnapshot snapshot = event.snapshot;
        if (!snapshot.exists) return;
        updateChapterList(snapshot.value as Map);
        selectedChapter ??= chapterList.isNotEmpty ? chapterList[0] : null;
        notifyListeners();
      });
    } catch (e) {
      _setErrorState(e.toString());
    }
    _setLoadingState(false);
  }

  void updateChapterList(Map data) {
    List<Chapter> chapterList = [];
    data.forEach((key, value) {
      chapterList
          .add(Chapter.fromJson(Map<String, dynamic>.from(value as Map)));
    });
    this.chapterList = chapterList;
  }

  void _setLoadingState(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  void _setErrorState(String errorMessage) {
    error = errorMessage;
    notifyListeners();
  }
}
