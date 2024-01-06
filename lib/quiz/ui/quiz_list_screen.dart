import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:learniverse_client/core/core.dart';
import 'package:learniverse_client/quiz/quiz.dart';
import 'package:provider/provider.dart';

class QuizListScreen extends StatefulWidget {
  const QuizListScreen({Key? key, required this.chapterId}) : super(key: key);
  final String chapterId;

  @override
  State<QuizListScreen> createState() => _QuizListScreenState();
}

class _QuizListScreenState extends State<QuizListScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      loadQuizQuestions();
    });
    super.initState();
  }

  void loadQuizQuestions() {
    Provider.of<QuizProvider>(context, listen: false)
        .loadQuizQuestions(widget.chapterId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('Quiz'),
      ),

      body: Consumer<QuizProvider>(
        builder: (BuildContext context, QuizProvider provider, Widget? child) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
                itemCount: provider.quizQuestions.length,
                itemBuilder: (context, index) {
                  return QuestionWidget(
                   // chapterId: widget.chapterId,
                    //quizQuestion: provider.quizQuestions[index],
                  );
                }),
          );
        },
      ),
    );
  }
}
