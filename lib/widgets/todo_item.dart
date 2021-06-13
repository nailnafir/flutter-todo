import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12, bottom: 4),
      child: Card(
        elevation: 4,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: ListTile(
          title: Text("Minum susu pink"),
          trailing: Icon(
            Icons.check,
            color: Color(0xFF133EFF),
          ),
        ),
      ),
    );
  }
}
