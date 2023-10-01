// ignore_for_file: unnecessary_string_interpolations, avoid_print, avoid_function_literals_in_foreach_calls, library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:polite/FoodSceen/Foodscreen.dart';

import '../AdminScreen/Add/alert_delete.dart';

class FoodListPage extends StatefulWidget {
  const FoodListPage({super.key});

  @override
  _FoodListPageState createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
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
    _currentDate = getCurrentDateTime();
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

  String getCurrentDateTime() {
    final now = DateTime.now();
    final formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(now);
  }

  Future<QuerySnapshot> _getFoodCollectionSnapshot(
      CollectionReference collection) async {
    final snapshot = await collection.where('Foodname').get();
    return snapshot;
  }

  void _deleteFoodItem(String foodName) {
    FirebaseFirestore.instance
        .collection("UserID")
        .doc(_userUid)
        .collection("Foodtoday")
        .doc(_currentDate)
        .collection("FoodMorning")
        .where('Foodname', isEqualTo: foodName)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    }).catchError((error) {
      print("Error deleting food: $error");
    });
  }

  void _deleteFoodItema(String foodName) {
    FirebaseFirestore.instance
        .collection("UserID")
        .doc(_userUid)
        .collection("Foodtoday")
        .doc(_currentDate)
        .collection("FoodDayTime")
        .where('Foodname', isEqualTo: foodName)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    }).catchError((error) {
      print("Error deleting food: $error");
    });
  }

  void _deleteFoodItemb(String foodName) {
    FirebaseFirestore.instance
        .collection("UserID")
        .doc(_userUid)
        .collection("Foodtoday")
        .doc(_currentDate)
        .collection("FoodEvening")
        .where('Foodname', isEqualTo: foodName)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    }).catchError((error) {
      print("Error deleting food: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 112, 86, 77),
        elevation: 0,
        title: const Text(
          'รายการอาหารวันนี้',
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
              color: const Color.fromARGB(255, 228, 203, 184),
              child: Center(
                child: Text(
                  '${getCurrentDateTime()}',
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '  ตอนเช้า',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: _getFoodCollectionSnapshot(_foodMorningCollection),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('เกิดข้อผิดพลาด: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Text('');
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
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '$callory แคลลอรี่ x $number',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        trailing: SizedBox(
                          width: 40,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 18,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                      //TO DO DELETE
                                      onTap: () async {
                                        final action =
                                            await AlertDialogs.yesorCancel(
                                                context,
                                                'ลบ',
                                                'คุณต้องการลบข้อมูลนี้หรือไม่');
                                        if (action == DialogsAction.yes) {
                                          setState(() {
                                            _deleteFoodItem(foodname);
                                          });
                                        }
                                      },
                                      child: const Icon(Icons.delete)),
                                ],
                              ),
                            ],
                          ),
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
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '  กลางวัน',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: _getFoodCollectionSnapshot(_foodDayTimeCollection),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('เกิดข้อผิดพลาด: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Text('');
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
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '$callory แคลลอรี่ x $number',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        trailing: SizedBox(
                          width: 40,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 18,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                      //TO DO DELETE
                                      onTap: () async {
                                        final action =
                                            await AlertDialogs.yesorCancel(
                                                context,
                                                'ลบ',
                                                'คุณต้องการลบข้อมูลนี้หรือไม่');
                                        if (action == DialogsAction.yes) {
                                          setState(() {
                                            _deleteFoodItema(foodname);
                                          });
                                        }
                                      },
                                      child: const Icon(Icons.delete)),
                                ],
                              ),
                            ],
                          ),
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
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '  ตอนเย็น',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: _getFoodCollectionSnapshot(_foodEveningCollection),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('เกิดข้อผิดพลาด: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Text('');
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
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '$callory แคลลอรี่ x $number',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        trailing: SizedBox(
                          width: 40,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 18,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                      //TO DO DELETE
                                      onTap: () async {
                                        final action =
                                            await AlertDialogs.yesorCancel(
                                                context,
                                                'ลบ',
                                                'คุณต้องการลบข้อมูลนี้หรือไม่');
                                        if (action == DialogsAction.yes) {
                                          setState(() {
                                            _deleteFoodItemb(foodname);
                                          });
                                        }
                                      },
                                      child: const Icon(Icons.delete)),
                                ],
                              ),
                            ],
                          ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const Foodscreen()),
          );
        },
        backgroundColor: const Color.fromARGB(255, 161, 136, 127),
        child: const Icon(Icons.save_as),
      ),
    );
  }
}
