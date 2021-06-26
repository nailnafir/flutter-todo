import 'package:flutter/material.dart';

class TaskCounter extends StatelessWidget {
  TaskCounter({Key? key}) : super(key: key);

  static int taskCount = 0;
  static bool isFirstTask = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Tugas Hari Ini",
          style: TextStyle(fontSize: 18),
        ),
        taskCount < 1
            ? !isFirstTask
                ? Text("")
                : Text(
                    "Tugas selesai",
                    style: TextStyle(fontSize: 12, color: Color(0xFF133EFF)),
                  )
            : Text(
                "Sisa $taskCount lagi",
                style: TextStyle(fontSize: 12, color: Colors.red),
              ),
      ],
    );
  }
}
