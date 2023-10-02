// ignore_for_file: file_names, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:polite/FoodSceen/Foodscreen.dart';
import 'package:polite/FoodSceen/Open_CheckFood_Screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _mounted = false;
  // เพิ่มตัวแปรเก็บค่าแคลอรี่ทั้งหมด
  double totalCalories = 0.0;
  late final User _currentUser;
  late final String _userUid;
  late final String _currentDate;
  late final CollectionReference _foodMorningCollection;
  late final CollectionReference _foodDayTimeCollection;
  late final CollectionReference _foodEveningCollection;

  @override
  void initState() {
    super.initState();
    _mounted = true;
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
    // เรียก _calculateTotalCalories() เมื่อหน้า HomeScreen ถูกโหลด
    _calculateTotalCalories();
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }

  String getCurrentDateTime() {
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(now);
  }

  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection("UserID");

  sendUserDataToDB() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    String? useruid = currentUser!.uid;

    // สร้างเอกสารย่อยภายใต้คอลเลกชัน "UserID" โดยใช้วันที่ปัจจุบันเป็นชื่อเอกสาร
    DocumentReference foodTodayDoc = usersCollection
        .doc(useruid)
        .collection("Foodtoday")
        .doc(getCurrentDateTime());

    // เพิ่มข้อมูลลงในเอกสารย่อย
    await foodTodayDoc.set({
      'date': getCurrentDateTime(),
    });
    // // หลังจากบันทึกข้อมูลแล้ว เรียกฟังก์ชันคำนวณค่าแคลอรี่ทั้งหมด
    // _calculateTotalCalories();

    // เมื่อข้อมูลถูกเพิ่มเรียบร้อย ให้เปิดหน้า Foodscreen
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const Foodscreen()),
    );
  }

  void _calculateTotalCalories() async {
    double morningCalories = await _getTotalCalories(_foodMorningCollection);
    double dayTimeCalories = await _getTotalCalories(_foodDayTimeCollection);
    double eveningCalories = await _getTotalCalories(_foodEveningCollection);

    if (_mounted) {
      setState(() {
        // รวมค่าแคลอรี่ทั้งหมดและกำหนดค่าให้กับ totalCalories
        totalCalories = morningCalories + dayTimeCalories + eveningCalories;
      });
    }
  }

  Future<double> _getTotalCalories(CollectionReference collection) async {
    double total = 0.0;
    QuerySnapshot snapshot = await collection.get();
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      double calories = (doc['Callory'] ?? 0.0) is double
          ? doc['Callory']
          : double.tryParse(doc['Callory'] ?? '0.0') ?? 0.0;
      total += calories;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 112, 86, 77),
        elevation: 0,
        title: const Text(
          'โภชนาการของผู้สูงวัย',
          style: TextStyle(
              color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(children: [
            Container(
              height: 75,
              color: const Color.fromARGB(255, 228, 203, 184),
              child: Center(
                child: Text(
                  getCurrentDateTime(),
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(),
              child: Center(
                child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("UserID")
                      .doc(_userUid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasData) {
                      final documents = snapshot.data;
                      final title = documents?['Fullname'] ?? '';
                      return Text(
                        title,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      );
                    }
                    return const Text('ไม่มีข้อมูล');
                  },
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(),
                child: Column(
                  children: <Widget>[
                    // ignore: avoid_unnecessary_containers
                    Container(
                      child: SfCircularChart(
                        series: <CircularSeries>[
                          RadialBarSeries<RadialBarData, String>(
                            maximumValue: 3000,
                            gap: '10%',
                            dataSource: <RadialBarData>[
                              RadialBarData('Consumed',
                                  totalCalories), // ใช้ค่า totalCalories ที่คำนวณมาแสดง
                            ],
                            xValueMapper: (RadialBarData data, _) =>
                                data.category,
                            yValueMapper: (RadialBarData data, _) => data.value,
                            pointColorMapper: (RadialBarData data, _) {
                              if (data.category == 'Consumed') {
                                if (data.value > 2500) {
                                  return Colors
                                      .red; // ถ้าค่า Callory มากกว่า 2500 ให้เป็นสีแดง
                                } else if (data.value > 2000) {
                                  return Colors
                                      .yellow; // ถ้าค่า Callory อยู่ระหว่าง 2500 ถึง 2000 ให้เป็นสีเหลือง
                                } else {
                                  return Colors
                                      .green; // ถ้าค่า Callory ต่ำกว่าหรือเท่ากับ 2000 ให้เป็นสีเขียว
                                }
                              } else {
                                return Colors
                                    .grey; // สีสำหรับแท่ง 'Remaining' ที่ไม่ใช่ 'Consumed'
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "$totalCalories แคลอรี่ ",
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 16,
                      child: Text(
                        _getStatusText(
                            totalCalories), // ตรวจสอบสถานะและสร้างข้อความ
                        style: const TextStyle(
                          color: Colors.green, // สีข้อความสีเขียว
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                width: 260,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    sendUserDataToDB();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 160, 126,
                            115)), // Set your desired background color here
                    minimumSize: MaterialStateProperty.all(const Size(
                      double.infinity,
                      48,
                    )),
                  ),
                  child: const Text(
                    'บันทึกเมนูอาหาร',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const Checkfood()),
          );
        },
        backgroundColor: const Color.fromARGB(255, 161, 136, 127),
        child: const Icon(Icons.check_box_rounded),
      ),
    );
  }
}

String _getStatusText(double value) {
  if (value > 2500) {
    return 'อยู่ในเกณฑ์อันตราย';
  } else if (value > 2000) {
    return 'อยู่ในเกณฑ์เสี่ยง';
  } else {
    return '';
  }
}

class RadialBarData {
  RadialBarData(this.category, this.value);

  final String category;
  final double value;
}
