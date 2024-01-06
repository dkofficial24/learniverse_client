class Chapter {
  String? id;
  String? courseId;
  String title;
  String content;
  bool isQuiz;

  Chapter({
    this.id,
    this.courseId,
    required this.title,
    required this.content,
    this.isQuiz = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'courseId': courseId,
        'title': title,
        'content': content,
        'isQuiz': isQuiz,
      };

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        id: json['id'],
        courseId: json['courseId'],
        title: json['title'],
        content: json['content'],
        isQuiz: json['isQuiz'] ?? false,
      );
}
