import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:go_router/go_router.dart';
import 'package:learniverse_client/chapter/chapter.dart';
import 'package:learniverse_client/core/core.dart';
import 'package:learniverse_client/util/extensions/string_extension.dart';

class ChapterScreen extends StatefulWidget {
  const ChapterScreen({Key? key, required this.chapter}) : super(key: key);

  final Chapter chapter;

  @override
  State<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  late QuillController _controller;
  bool isWideScreen = false;

  @override
  void initState() {
    _controller = QuillController(
        document: Document.fromJson(jsonDecode(widget.chapter.content)),
        selection: const TextSelection.collapsed(offset: 0));
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ChapterScreen oldWidget) {
    if (oldWidget.chapter.content != widget.chapter.content) {
      _controller.document =
          Document.fromJson(jsonDecode(widget.chapter.content));
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        isWideScreen = constraints.maxWidth > 600;
        return Scaffold(
          appBar: CustomAppBar(
            actions: [
              if (widget.chapter.isQuiz)
                IconButton(
                    onPressed: () {
                      context.go(
                        RoutesName.quizScreen.toPath,
                        extra: widget.chapter.id,
                      );
                    },
                    icon: const Icon(
                      Icons.quiz,
                    ))
            ],
          ),
          body: webUI(),
        );
      },
    );
  }

  Widget webUI() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            child: Text(
              widget.chapter.title,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Expanded(child: buildEditor(widget.chapter.content)),
        ],
      ),
    );
  }

  Widget buildEditor(String contents) {
    return QuillProvider(
      configurations: QuillConfigurations(
        controller: _controller,
        sharedConfigurations: const QuillSharedConfigurations(
          locale: Locale('en'),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: QuillEditor.basic(
              configurations: const QuillEditorConfigurations(
                readOnly: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}
