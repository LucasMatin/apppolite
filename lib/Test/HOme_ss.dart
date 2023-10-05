// ignore_for_file: file_names, sized_box_for_whitespace, unused_import

import 'package:flutter/material.dart';
import 'package:polite/FoodSceen/Foodscreen.dart';
import 'package:polite/Screens/Home_Screen.dart';
import 'package:polite/Screens/Lilbrary_Screen.dart';
import 'package:polite/Screens/Sos_Screen.dart';

import '../FoodSceen/Open_FoodMorning_Screen.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        elevation: 0,
        title: const Text(
          'โภชนาการสำหรับผู้สูงวัย',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: 260,
                  height: 70,
                  child: ElevatedButton(
                    onPressed: () {
                      // sendUserDataToDB();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(const Size(
                        double.infinity,
                        48,
                      )),
                    ),
                    child: const Text(
                      'บันทึกรายการอาหาร',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  width: 260,
                  height: 70,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(const Size(
                        double.infinity,
                        48,
                      )),
                    ),
                    child: const Text(
                      'สรุปแคลอรี่ประจำสัปดาห์',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  width: 260,
                  height: 70,
                  child: ElevatedButton(
                    onPressed: () {
                      // sendUserDataToDB();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Lilbraryscreen(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(const Size(
                        double.infinity,
                        48,
                      )),
                    ),
                    child: const Text(
                      'ห้องสมุดโภชนาการ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  width: 260,
                  height: 70,
                  child: ElevatedButton(
                    onPressed: () {
                      // sendUserDataToDB();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Sos(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(const Size(
                        double.infinity,
                        48,
                      )),
                    ),
                    child: const Text(
                      'เหตุฉุกเฉิน',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  width: 260,
                  height: 70,
                  child: ElevatedButton(
                    onPressed: () {
                      // sendUserDataToDB();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => (),
                      //   ),
                      // );
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(const Size(
                        double.infinity,
                        48,
                      )),
                    ),
                    child: const Text(
                      'อาหารแนะนำสำหรับโรค',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
