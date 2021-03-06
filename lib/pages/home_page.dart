import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_todo/models/todo_model.dart';
import 'package:flutter_todo/pages/personal_page.dart';
import 'package:flutter_todo/pages/work_page.dart';
import 'package:flutter_todo/widgets/menu_item.dart';
import 'package:flutter_todo/widgets/task_counter.dart';
import 'package:flutter_todo/widgets/todo_item.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

extension DateTimeExtension on DateTime {
  String get dayName {
    switch (this.weekday) {
      case 1:
        return "Senin";
      case 2:
        return "Selasa";
      case 3:
        return "Rabu";
      case 4:
        return "Kamis";
      case 5:
        return "Jumat";
      case 6:
        return "Sabtu";
      default:
        return "Minggu";
    }
  }

  String get monthName {
    switch (this.month) {
      case 1:
        return "Januari";
      case 2:
        return "Februari";
      case 3:
        return "Maret";
      case 4:
        return "April";
      case 5:
        return "Mei";
      case 6:
        return "Juni";
      case 7:
        return "Juli";
      case 8:
        return "Agustus";
      case 9:
        return "September";
      case 10:
        return "Oktober";
      case 11:
        return "November";
      default:
        return "Desember";
    }
  }
}

class _HomePageState extends State<HomePage> {
  List<TodoModel> todos = [];

  TextEditingController todoController = TextEditingController(text: "");

  // String task = ""; to save data
  String timeString = "";
  String dateString = "";

  String formatDateTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }

  // to save data
  // Future<String> loadData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final key = "my_task_key";

  //   String task = prefs.getString(key)!;
  //   print("Berhasil mengambil tugas: $task");
  //   return task;
  // }

  // Future<String> saveData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final key = "my_task_key";
  //   String task = todoController.text.trim();

  //   prefs.setString(key, task);
  //   print("Berhasil menyimpan tugas: $task");
  //   return task;
  // }

  @override
  void initState() {
    // loadData().then(loadTask); to save data
    timeString = formatDateTime(DateTime.now());
    dateString =
        "${DateTime.now().dayName}, ${DateTime.now().day} ${DateTime.now().monthName} ${DateTime.now().year}";
    Timer.periodic(Duration(seconds: 1), (Timer t) => getTime());

    super.initState();
  }

  void getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = formatDateTime(now);

    setState(() {
      timeString = formattedDateTime;
      dateString = dateString;
    });
  }

  // @override
  // void dispose() {
  //   Timer timer = Timer.periodic(Duration(seconds: 1), (Timer t) => getTime());
  //   timer.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE3E8FF),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(300),
        child: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFFE3E8FF),
          flexibleSpace: Stack(
            children: [
              Column(
                children: [
                  Container(
                    color: Color(0xFF133EFF),
                    child: Column(
                      children: [
                        userProfile(),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ],
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 130),
                    Card(
                      elevation: 4,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 2 * 24,
                        height: 150,
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        child: categories(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowGlow();
              return false;
            },
            child: ListView(
              children: [
                //NOTE: TO DO MAIN
                Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: todoMain(),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 85,
                  color: Color(0xFF133EFF),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    controller: todoController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.add_box,
                            color: Color(0xFF133EFF),
                          ),
                          onPressed: () {
                            if (todoController.text.trim() != "") {
                              setState(() {
                                TaskCounter.taskCount++;

                                TaskCounter.isFirstTask = true;

                                todos.add(
                                  TodoModel(
                                    title: todoController.text.trim(),
                                    isDone: false,
                                  ),
                                );

                                todoController.text = "";

                                // to save data
                                // saveData()
                                //     .then((value) => todoController.text = "");
                              });
                            }
                          },
                        ),
                        hintText: "Tambah tugas barumu...."),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  userProfile() {
    String greeting() {
      var time = DateTime.now().hour;

      if (time < 10) {
        return "Pagi";
      } else if (time < 15) {
        return "Siang";
      } else if (time < 18) {
        return "Sore";
      } else {
        return "Malam";
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 24),
      padding: EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Selamat ${greeting()},",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              Text(
                "Nailul Firdaus!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              Text(
                "Mau apa hari ini?",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/me.jpg"),
              ),
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  categories() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dateString,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF133EFF),
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              timeString,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF133EFF),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Divider(color: Color(0xFFC5C5C5)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Get.to(PersonalPage());
              },
              child: MenuItem(title: "Personal", icon: Icons.person),
            ),
            GestureDetector(
              onTap: () {
                Get.to(WorkPage());
              },
              child: MenuItem(title: "Pekerjaan", icon: Icons.work_outlined),
            ),
          ],
        ),
      ],
    );
  }

  todoMain() {
    setState(() {});

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TaskCounter(),
        Column(
          children: todos.length < 1
              ? [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "images/undraw_questions.png",
                          width: 250,
                          height: 150,
                        ),
                        SizedBox(height: 4),
                        Center(
                            child: Text(
                          "Tidak ada tugas!",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        )),
                      ],
                    ),
                  )
                ]
              : todos
                  .map((item) => Container(
                      margin: EdgeInsets.only(top: 8),
                      child: TodoItem(title: item.title)))
                  .toList(),
        ),
        SizedBox(height: 24),
      ],
    );
  }

  // to save data
  // void loadTask(String? updateTask) {
  //   setState(() {
  //     this.task = updateTask ?? "";
  //   });
  // }

  // default setting save data
  // saveTask() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final key = "my_task_key";
  //   String value = todoController.text.trim();

  //   prefs.setString(key, value);
  //   print("Berhasil menyimpan tugas: $value");
  // }

  // loadTask() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final key = "my_task_key";
  //   String value = prefs.getString(key).toString();

  //   print("Berhasil mengambil tugas: $value");
  // }
}
