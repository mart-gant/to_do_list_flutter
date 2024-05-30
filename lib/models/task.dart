class Task {
  String title;
  bool isDone;
  String category;
  DateTime dueDate;

  Task({required this.title, this.isDone = false, required this.category, required this.dueDate});

  void toggleDone() {
    isDone = !isDone;
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isDone': isDone,
      'category': category,
      'dueDate': dueDate.toIso8601String(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      isDone: map['isDone'],
      category: map['category'],
      dueDate: DateTime.parse(map['dueDate']),
    );
  }
}
