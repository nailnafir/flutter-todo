import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  String timeString = "";
  String dateString = "";
  String formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm:ss').format(dateTime);
  }

  @override
  void initState() {
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
      body: ListView(
        children: [
          Stack(
            children: [
              //NOTE: USER PROFILE
              Container(
                width: double.infinity,
                height: 180,
                color: Color(0xFF133EFF),
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      userProfile(),
                    ],
                  ),
                ),
              ),
              //NOTE: CATEGORIES
              Column(
                children: [
                  SizedBox(height: 180 - (180 / 2.5)),
                  Center(
                    child: Card(
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
                  ),
                ],
              ),
            ],
          ),
          //NOTE: TO DO MAIN
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(24),
                child: todoMain(),
              ),
            ],
          )
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
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0x25133EFF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.person_outline,
                    color: Color(0xFF133EFF),
                    size: 30,
                  ),
                ),
                Text("Personal"),
              ],
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0x25133EFF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.work_outline,
                    color: Color(0xFF133EFF),
                    size: 30,
                  ),
                ),
                Text("Pekerjaan"),
              ],
            ),
          ],
        ),
      ],
    );
  }

  todoMain() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Tugas Hari Ini",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "Sisa 3 Lagi",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 12),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Ketik tugas barumu....",
              suffixIcon: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add_box,
                  color: Color(0xFF133EFF),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
