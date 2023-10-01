// ignore_for_file: avoid_function_literals_in_foreach_calls, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TotalCalloryPage extends StatelessWidget {
  const TotalCalloryPage({super.key});

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

      // ignore: avoid_function_literals_in_foreach_calls
      foodDayTimeSnapshot.docs.forEach((doc) {
        final callory = doc['Callory'];
        if (callory is int) {
          totalCallory += callory;
        } else if (callory is String) {
          totalCallory += int.tryParse(callory) ?? 0;
        }
      });

      // ignore: avoid_function_literals_in_foreach_calls
      foodEveningSnapshot.docs.forEach((doc) {
        final callory = doc['Callory'];
        if (callory is int) {
          totalCallory += callory;
        } else if (callory is String) {
          totalCallory += int.tryParse(callory) ?? 0;
        }
      });

      // ignore: avoid_print
      print("Total Callory: $totalCallory");
      return totalCallory;
    } catch (e) {
      // ignore: avoid_print
      print("เกิดข้อผิดพลาดในการดึงข้อมูล: $e");
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("รวมค่าแคลอรี่ของ "),
      ),
      body: FutureBuilder<int>(
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
              // ignore: prefer_const_constructors
              style: TextStyle(fontSize: 20),
            ),
          );
        },
      ),
    );
  }

  String getCurrentDateTime() {
    final now = DateTime.now();
    final formatter = DateFormat('dd-MM-yyyy');
    final formattedDate = formatter.format(now);
    return formattedDate;
  }
}
