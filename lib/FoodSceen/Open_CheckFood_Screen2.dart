import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class FoodHistoryPage extends StatefulWidget {
  final String selectedDate;
  const FoodHistoryPage({required this.selectedDate, Key? key})
      : super(key: key);
  @override
  _FoodHistoryPageState createState() => _FoodHistoryPageState();
}

class _FoodHistoryPageState extends State<FoodHistoryPage> {
  late final User _currentUser;
  late final String _userUid;
  late final String _currentDate;
  late final CollectionReference _foodMorningCollection;
  late final CollectionReference _foodDayTimeCollection;
  late final CollectionReference _foodEveningCollection;

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser!;
    _userUid = _currentUser.uid;
    _currentDate = widget.selectedDate; // ใช้วันที่ที่ถูกส่งมาจากหน้า Checkfood
    _foodMorningCollection = FirebaseFirestore.instance
        .collection("UserID")
        .doc(_userUid)
        .collection("Foodtoday")
        .doc(_currentDate)
        .collection("FoodMorning");

    _foodDayTimeCollection = FirebaseFirestore.instance
        .collection("UserID")
        .doc(_userUid)
        .collection("Foodtoday")
        .doc(_currentDate)
        .collection("FoodDayTime");

    _foodEveningCollection = FirebaseFirestore.instance
        .collection("UserID")
        .doc(_userUid)
        .collection("Foodtoday")
        .doc(_currentDate)
        .collection("FoodEvening");
  }

  Future<QuerySnapshot> _getFoodCollectionSnapshot(
      CollectionReference collection) async {
    final snapshot = await collection.where('Foodname').get();
    return snapshot;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        elevation: 0,
        title: Text(
          'รายการอาหารย้อนหลัง',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 75,
              color: Color.fromARGB(255, 228, 203, 184),
              child: Center(
                child: Text(
                  widget.selectedDate,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'ตอนเช้า',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: _getFoodCollectionSnapshot(_foodMorningCollection),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('เกิดข้อผิดพลาด: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Text('ไม่มีข้อมูลในรายการอาหารเมื่อตอนเช้า');
                } else {
                  final docs = snapshot.data!.docs;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: docs.map((doc) {
                      final foodname = doc['Foodname'];
                      final callory = doc['Callory'];
                      final number = doc['Number'];
                      return ListTile(
                        title: Text(
                          '$foodname',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '$callory แคลลอรี่ x $number',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),
            const Divider(
              thickness: 2,
              color: Colors.grey,
              indent: 25,
              endIndent: 25,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'กลางวัน',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: _getFoodCollectionSnapshot(_foodDayTimeCollection),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('เกิดข้อผิดพลาด: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Text('ไม่มีข้อมูลในรายการอาหารเมื่อตอนกลางวัน');
                } else {
                  final docs = snapshot.data!.docs;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: docs.map((doc) {
                      final foodname = doc['Foodname'];
                      final callory = doc['Callory'];
                      final number = doc['Number'];
                      return ListTile(
                        title: Text(
                          '$foodname',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '$callory แคลลอรี่ x $number',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),
            const Divider(
              thickness: 2,
              color: Colors.grey,
              indent: 25,
              endIndent: 25,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'ตอนเย็น',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: _getFoodCollectionSnapshot(_foodEveningCollection),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('เกิดข้อผิดพลาด: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Text('ไม่มีข้อมูลในรายการอาหารเมื่อตอนเย็น');
                } else {
                  final docs = snapshot.data!.docs;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: docs.map((doc) {
                      final foodname = doc['Foodname'];
                      final callory = doc['Callory'];
                      final number = doc['Number'];
                      return ListTile(
                        title: Text(
                          '$foodname',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '$callory แคลลอรี่ x $number',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),
            const Divider(
              thickness: 2,
              color: Colors.grey,
              indent: 25,
              endIndent: 25,
            ),
          ],
        ),
      ),
    );
  }
}
