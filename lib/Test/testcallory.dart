import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TotalCalloryPage extends StatelessWidget {
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
        title: Text("รวมค่าแคลอรี่ของ "),
      ),
      body: FutureBuilder<int>(
        future: getTotalCallory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
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
