class TodoModel {
  String title;
  bool isDone;

  static int taskCount = 0;

  TodoModel({
    required this.title,
    required this.isDone,
  });
}
