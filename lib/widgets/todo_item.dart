import 'package:flutter/material.dart';
import 'package:flutter_todo/widgets/task_counter.dart';

class TodoItem extends StatefulWidget {
  final String title;

  TodoItem({Key? key, required this.title}) : super(key: key);

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isDone = !isDone;
          if (isDone) {
            TaskCounter.taskCount--;
          } else {
            TaskCounter.taskCount++;
          }
        });
      },
      child: Card(
        elevation: 4,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: ListTile(
          title: Text(
            widget.title,
            style: TextStyle(
              color: isDone ? Colors.grey : Colors.black,
              decoration: isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: isDone
              ? Icon(
                  Icons.check,
                  color: Color(0xFF133EFF),
                )
              : SizedBox(),
        ),
      ),
    );
  }
}
