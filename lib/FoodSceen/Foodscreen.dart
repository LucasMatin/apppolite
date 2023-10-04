// ignore_for_file: deprecated_member_use, unnecessary_string_interpolations, avoid_print, avoid_function_literals_in_foreach_calls, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:polite/FoodSceen/Open_FoodDaytime_Screen.dart';
import 'package:polite/FoodSceen/Open_FoodView_Screen.dart';
import 'package:polite/FoodSceen/Open_FoodMorning_Screen.dart';
import 'package:polite/FoodSceen/Open_Foodevening_Screen.dart';

import 'package:polite/Screens/Bottom_Screen.dart';

class Foodscreen extends StatefulWidget {
  const Foodscreen({super.key});

  @override
  State<Foodscreen> createState() => _FoodscreenState();
}

class _FoodscreenState extends State<Foodscreen> {
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    getTotalCallory();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  String formattedDate = "";

  get useruid => null;

  String getCurrentDateTime() {
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(now);
  }

  // TotalCalloryPage({required this.useruid, required this.lable});
  Future<int> getTotalCallory() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      var currentUser = auth.currentUser;
      String? useruid = currentUser!.uid;

      final CollectionReference foodMorningCollection = FirebaseFirestore
          .instance
          .collection("UserID")
          .doc(useruid)
          .collection("Foodtoday")
          .doc(getCurrentDateTime())
          .collection("FoodMorning");

      final CollectionReference foodDayTimeCollection = FirebaseFirestore
          .instance
          .collection("UserID")
          .doc(useruid)
          .collection("Foodtoday")
          .doc(getCurrentDateTime())
          .collection("FoodDayTime");

      final CollectionReference foodEveningCollection = FirebaseFirestore
          .instance
          .collection("UserID")
          .doc(useruid)
          .collection("Foodtoday")
          .doc(getCurrentDateTime())
          .collection("FoodEvening");

      QuerySnapshot foodMorningSnapshot =
          await foodMorningCollection.where('Foodname').get();

      QuerySnapshot foodDayTimeSnapshot =
          await foodDayTimeCollection.where('Foodname').get();

      QuerySnapshot foodEveningSnapshot =
          await foodEveningCollection.where('Foodname').get();

      // เมื่อคุณได้ snapshots ของทุกโคลเลกชันแล้ว คุณสามารถรวมข้อมูลได้
      int totalCallory = 0;

      foodMorningSnapshot.docs.forEach((doc) {
        final callory = doc['Callory'];
        if (callory is int) {
          totalCallory += callory;
        } else if (callory is String) {
          totalCallory += int.tryParse(callory) ?? 0;
        }
      });

      foodDayTimeSnapshot.docs.forEach((doc) {
        final callory = doc['Callory'];
        if (callory is int) {
          totalCallory += callory;
        } else if (callory is String) {
          totalCallory += int.tryParse(callory) ?? 0;
        }
      });

      foodEveningSnapshot.docs.forEach((doc) {
        final callory = doc['Callory'];
        if (callory is int) {
          totalCallory += callory;
        } else if (callory is String) {
          totalCallory += int.tryParse(callory) ?? 0;
        }
      });

      print("Total Callory: $totalCallory");
      return totalCallory;
    } catch (e) {
      print("เกิดข้อผิดพลาดในการดึงข้อมูล: $e");
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 112, 86, 77),
        elevation: 0,
        title: const Text(
          'บันทึกรายการอาหาร',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                height: 75,
                color: const Color.fromARGB(255, 228, 203, 184),
                child: Center(
                  child: Text(
                    '${getCurrentDateTime()}',
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Addfoodmorning(),
                    ),
                  );
                },
                child: SizedBox(
                  width: 370.0,
                  height: 100.0,
                  child: Card(
                    color: const Color.fromARGB(255, 112, 86, 77),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            SizedBox(height: 5.0),
                            Text(
                              "อาหารเช้า",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Addfooddaytime(),
                    ),
                  );
                },
                child: SizedBox(
                  width: 370.0,
                  height: 100.0,
                  child: Card(
                    color: const Color.fromARGB(255, 112, 86, 77),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            SizedBox(height: 5.0),
                            Text(
                              "อาหารกลางวัน",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Addfoodevening(),
                    ),
                  );
                },
                child: SizedBox(
                  width: 370.0,
                  height: 100.0,
                  child: Card(
                    color: const Color.fromARGB(255, 112, 86, 77),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            SizedBox(height: 5.0),
                            Text(
                              "อาหารเย็น",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              FutureBuilder<int>(
                future: getTotalCallory(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text("เกิดข้อผิดพลาด: ${snapshot.error}"),
                    );
                  }

                  int totalCallory = snapshot.data ?? 0;

                  return Center(
                    child: Text(
                      "รวมค่าแคลอรี่: $totalCallory แคลลอรี่",
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(),
                child: Center(
                  child: SizedBox(
                    width: 300,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FoodListPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 228, 203,
                              184) // Set your desired background color here
                          ),
                      child: const Text(
                        'รายการอาหารทั้งหมด',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(),
                child: Center(
                  child: SizedBox(
                    width: 300,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const bottomsceen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 228, 203,
                              184) // Set your desired background color here
                          ),
                      child: const Text(
                        'บันทึก',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
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
    );
  }
}
