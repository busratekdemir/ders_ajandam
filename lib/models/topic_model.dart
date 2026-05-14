class TopicModel {
  final String title;
  final String formula;
  final String lesson;
  final String grade;
  bool done;

  TopicModel({
    required this.title,
    required this.formula,
    required this.lesson,
    required this.grade,
    this.done = false,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    return TopicModel(
      title: json['title'] ?? '',
      formula: json['formula'] ?? '',
      lesson: json['lesson'] ?? '',
      grade: json['grade'] ?? '',
      done: json['done'] ?? false,
    );
  }
}
