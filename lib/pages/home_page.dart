import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          width: double.infinity,
          height: 250,
          color: Color(0xFF133EFF),
          child: Row(
            children: [
              Column(
                children: [
                  Text("Selamat ${greeting()},"),
                  Text("Nailul Firdaus!"),
                ],
              ),
              // Image.asset(""),
            ],
          ),
        )
      ],
    ));
  }
}
