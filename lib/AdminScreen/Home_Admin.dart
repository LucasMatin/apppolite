// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:polite/AdminScreen/Add/Add_Article_Screen.dart';
import 'package:polite/AdminScreen/Add/Add_Eat_Screen.dart';
import 'package:polite/AdminScreen/Add/Add_Nutrition_Screen.dart';
import 'package:polite/AdminScreen/Add/Add_Video_Screen.dart';
import 'package:polite/AdminScreen/Add/Add_Food_Screen.dart';

class HomeadminScreen extends StatefulWidget {
  const HomeadminScreen({super.key});

  @override
  State<HomeadminScreen> createState() => _HomeadminScreenState();
}

class _HomeadminScreenState extends State<HomeadminScreen> {
  // ignore: unused_field
  final CollectionReference _items =
      FirebaseFirestore.instance.collection('UserID');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        elevation: 0,
        title: const Text(
          'จัดการแอดมิน',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Addfood()));
                  },
                  child: SizedBox(
                    width: 400.0,
                    height: 140.0,
                    child: Card(
                      color: const Color.fromARGB(255, 143, 113, 102),
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
                                "images/food.png",
                                width: 65.0,
                              ),
                              const SizedBox(height: 10.0),
                              const Text(
                                "อาหาร",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => const NutritionsScreen()));
                //   },
                //   child: SizedBox(
                //     width: 400.0,
                //     height: 140.0,
                //     child: Card(
                //       color: const Color.fromARGB(255, 143, 113, 102),
                //       elevation: 2.0,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(8.0),
                //       ),
                //       child: Center(
                //         child: Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Column(
                //             children: [
                //               Image.asset(
                //                 "images/roa2.png",
                //                 width: 65.0,
                //               ),
                //               const SizedBox(height: 10.0),
                //               const Text(
                //                 "ข้อมูลโรค",
                //                 style: TextStyle(
                //                   color: Colors.white,
                //                   fontWeight: FontWeight.bold,
                //                   fontSize: 25.0,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Addnutrition()));
                  },
                  child: SizedBox(
                    width: 400.0,
                    height: 140.0,
                    child: Card(
                      color: const Color.fromARGB(255, 143, 113, 102),
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
                                "images/nutrition.png",
                                width: 65.0,
                              ),
                              const SizedBox(height: 10.0),
                              const Text(
                                "แนะนำเกี่ยวกับโภชนาการ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0,
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
                            builder: (context) => const Saveeat()));
                  },
                  child: SizedBox(
                    width: 400.0,
                    height: 140.0,
                    child: Card(
                      color: const Color.fromARGB(255, 143, 113, 102),
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
                              const SizedBox(height: 10.0),
                              const Text(
                                "กินอย่างไรให้สุภาพดี",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0,
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
                            builder: (context) => const Addarticale()));
                  },
                  child: SizedBox(
                    width: 400.0,
                    height: 140.0,
                    child: Card(
                      color: const Color.fromARGB(255, 143, 113, 102),
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
                                width: 98.0,
                              ),
                              const SizedBox(height: 10.0),
                              const Text(
                                "บทความเพื่อสุขภาพ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0,
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
                            builder: (context) => const Addvideo()));
                  },
                  child: SizedBox(
                    width: 400.0,
                    height: 140.0,
                    child: Card(
                      color: const Color.fromARGB(255, 143, 113, 102),
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
                                width: 67.0,
                              ),
                              const SizedBox(height: 10.0),
                              const Text(
                                "วิดิโอเพื่อสุภาพ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0,
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
        ),
      ),
    );
  }
}
