import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:learniverse_client/chapter/chapter.dart';
import 'package:learniverse_client/core/core.dart';
import 'package:learniverse_client/util/extensions/string_extension.dart';
import 'package:provider/provider.dart';

class ListChapterScreen extends StatefulWidget {
  const ListChapterScreen({Key? key, required this.courseId}) : super(key: key);
  final String courseId;

  @override
  State<ListChapterScreen> createState() => _ListChapterScreenState();
}

class _ListChapterScreenState extends State<ListChapterScreen> {
  bool isWideScreen = false;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ChapterProvider>(context, listen: false)
          .subscribeChapterEvents(widget.courseId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        isWideScreen = constraints.maxWidth > 600;

        return Consumer<ChapterProvider>(builder: (context, provider, child) {
          return Scaffold(
            body: isWideScreen
                ? _buildWideScreenLayout(provider)
                : _buildMobileScreenLayout(provider),
          );
        });
      },
    );
  }

  Widget _buildWideScreenLayout(ChapterProvider provider) {
    return Row(
      children: [
        // Left side - Chapter List
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.separated(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    provider.onChapterSelect(index);
                  },
                  child: ListTile(
                    title: Text(
                      provider.chapterList[index].title,
                      textAlign: TextAlign.start,
                    ),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: provider.chapterList.length,
            ),
          ),
        ),

        // Right side - Chapter Details
        Expanded(
          flex: 6,
          child: Container(
              padding: const EdgeInsets.all(16),
              child: provider.selectedChapter != null
                  ? ChapterScreen(
                      chapter: provider.selectedChapter!,
                    )
                  : const SizedBox()),
        ),
      ],
    );
  }

  Widget _buildMobileScreenLayout(ChapterProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              context.go(
                RoutesName.chapterScreen.toPath,
                extra: provider.selectedChapter!,
              );
            },
            child: ListTile(
              title: Text(
                provider.chapterList[index].title,
                textAlign: TextAlign.start,
              ),
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: provider.chapterList.length,
      ),
    );
  }
}
