import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:polite/FoodSceen/Open_CheckFood_Screen2.dart';
// import 'package:polite/FoodSceen/Open_FoodView_Screen.dart';

class Checkfood extends StatefulWidget {
  const Checkfood({super.key});

  @override
  State<Checkfood> createState() => _CheckfoodState();
}

class _CheckfoodState extends State<Checkfood> {
  late final User _currentUser;
  late final String _userUid;
  late final CollectionReference _foodtodayCollection;

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser!;
    _userUid = _currentUser.uid;
    _foodtodayCollection = FirebaseFirestore.instance
        .collection("UserID")
        .doc(_userUid)
        .collection("Foodtoday");
  }

  Future<QuerySnapshot> _getFoodCollectionSnapshot(
      CollectionReference collection) async {
    final snapshot = await collection.where('date').get();
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
            SizedBox(height: 20),
            FutureBuilder<QuerySnapshot>(
              future: _getFoodCollectionSnapshot(_foodtodayCollection),
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
                      final data = doc['date'];
                      print("$data");

                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 12,
                          top: 10,
                        ),
                        child: Card(
                          elevation: 1,
                          child: SizedBox(
                            height: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ListTile(
                                  isThreeLine: false,
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => FoodHistoryPage(),
                                    //   ),
                                    // );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            FoodHistoryPage(selectedDate: data),
                                      ),
                                    );
                                  },
                                  subtitle: Center(
                                    child: Text(
                                      data,
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
