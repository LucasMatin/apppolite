// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: prefer_const_constructors, file_names

import 'package:polite/LilbraryScreen/Article_Screen.dart';
import 'package:polite/LilbraryScreen/Nutrition_Screen.dart';
import 'package:polite/LilbraryScreen/Eat_Screen%20.dart';
import 'package:flutter/material.dart';
import 'package:polite/LilbraryScreen/Video_Screen.dart';

class Lilbraryscreen extends StatelessWidget {
  const Lilbraryscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 112, 86, 77),
        elevation: 0,
        title: Text(
          'ห้องสมุดเพื่อสุขภาพ',
          style: TextStyle(
              color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Wrap(
                  spacing: 20.0,
                  runSpacing: 20.0,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NutritionSreen()));
                      },
                      child: SizedBox(
                        width: 400.0,
                        height: 140.0,
                        child: Card(
                          color: const Color.fromARGB(255, 112, 86, 77),
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Image.asset(
                                    "images/nutrition.png",
                                    width: 67.0,
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    "แนะนำเกี่ยวกับโภชนาการ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EatScreen()));
                      },
                      child: SizedBox(
                        width: 400.0,
                        height: 140.0,
                        child: Card(
                          color: const Color.fromARGB(255, 112, 86, 77),
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    "images/eat.png",
                                    width: 65.0,
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    "กินอย่างไรให้สุภาพดี",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Articlescreen()));
                      },
                      child: SizedBox(
                        width: 400.0,
                        height: 140.0,
                        child: Card(
                          color: const Color.fromARGB(255, 112, 86, 77),
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    "images/article.png",
                                    width: 105.0,
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    "บทความเพื่อสุขภาพ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => videoscreen()));
                      },
                      child: SizedBox(
                        width: 400.0,
                        height: 140.0,
                        child: Card(
                          color: const Color.fromARGB(255, 112, 86, 77),
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    "images/exercise.png",
                                    width: 70.0,
                                  ),
                                  SizedBox(height: 5.0),
                                  const Text(
                                    "วิดิโอเพื่อสุภาพ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
