import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor: Color(0xFFE5E5E5),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 250,
                color: Color(0xFF133EFF),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(24),
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
                                  fontSize: 18,
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
                    ),
                    SizedBox(height: 18),
                    Expanded(
                      child: Text(
                        '"Jangan Lupa Sholat!"',
                        style: GoogleFonts.architectsDaughter().copyWith(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 2 * 24,
                  height: 100,
                  margin: EdgeInsets.only(top: 250 - 50),
                  child: Card(
                    elevation: 4,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "${DateTime.now().day} ${DateTime.now()}",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
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
    switch (this.weekday) {
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
      case 6:
        return "November";
      default:
        return "Desember";
    }
  }
}
