// ignore_for_file: file_names, unused_field, avoid_print, unnecessary_nullable_for_final_variable_declarations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  DateTime? _startDate;
  DateTime? _endDate;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;
  QuerySnapshot? _snapshotData;
  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser!;
    _userUid = _currentUser.uid;
    _foodtodayCollection = FirebaseFirestore.instance
        .collection("UserID")
        .doc(_userUid)
        .collection("Foodtoday");
    _startDateController = TextEditingController(
      text: _startDate != null
          ? DateFormat('dd-MM-yyyy').format(_startDate!)
          : '',
    );
    _endDateController = TextEditingController(
      text: _endDate != null ? DateFormat('dd-MM-yyyy').format(_endDate!) : '',
    );
  }

  Future<QuerySnapshot> _getFoodCollectionSnapshot(
      CollectionReference collection) async {
    final snapshot = await collection.where('date').get();
    return snapshot;
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = selectedDate;
          _endDate = selectedDate;
          _startDateController.text =
              DateFormat('dd-MM-yyyy').format(selectedDate);
          print(_startDateController);
          print(selectedDate);
        } else {
          _endDate = selectedDate;
          _endDateController.text =
              DateFormat('dd-MM-yyyy').format(selectedDate);
          print(_endDateController);
          print(_endDate);
        }

        // เรียกใช้งานฟังก์ชัน _fetchData เพื่อดึงข้อมูลใหม่
        _fetchData();
      });
    } else {
      // ถ้า selectedDate เป็น null (กด Cancel) ให้รีเซ็ตทั้งหมดเป็น null
      setState(() {
        _startDate = null;
        _endDate = null;
        _startDateController.clear();
        _endDateController.clear();
      });
    }
  }

  Future<void> _fetchData() async {
    if (_startDate != null && _endDate != null) {
      try {
        // Fetch data based on the selected date range
        final snapshot = await _foodtodayCollection
            .orderBy('date')
            .startAt([_startDate]).endAt([_endDate]).get();
        // print(_startDate);
        // print(_endDate);

        // Check if there is data in the snapshot
        if (snapshot.size == 0) {
          // Handle the case where there is no data
          setState(() {
            _snapshotData = null;
          });
        } else {
          // Update the UI with the new data
          setState(() {
            _snapshotData = snapshot;
          });
        }
      } catch (e) {
        // Handle errors here
        print("Error fetching data: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 112, 86, 77),
        elevation: 0,
        title: const Text(
          'รายการอาหารย้อนหลัง',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      readOnly: true,
                      controller: _startDateController,
                      onTap: () => _selectDate(context, true),
                      decoration: const InputDecoration(
                        labelText: 'วันที่เริ่มต้น',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      readOnly: true,
                      controller: _endDateController,
                      onTap: () => _selectDate(context, false),
                      decoration: const InputDecoration(
                        labelText: 'วันที่สิ้นสุด',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: FutureBuilder<QuerySnapshot>(
                  future: _getFoodCollectionSnapshot(_foodtodayCollection),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('เกิดข้อผิดพลาด: ${snapshot.error}');
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return const Text('ไม่มีข้อมูลในรายการอาหาร');
                    } else {
                      final docs = snapshot.data!.docs;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: docs.map((doc) {
                          final String data = doc['date'];
                          final List dates = data.split("-");
                          final DateTime? dateTime = DateTime.parse(
                              "${dates[2]}-${dates[1]}-${dates[0]}");

                          // Check if the date is within the selected range
                          if ((_startDate == null ||
                                  dateTime!.isAfter(_startDate!)) &&
                              (_endDate == null ||
                                  dateTime!.isBefore(_endDate!))) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                left: 15,
                                right: 12,
                              ),
                              child: Card(
                                elevation: 1,
                                child: SizedBox(
                                  height: 80,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ListTile(
                                        isThreeLine: false,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FoodHistoryPage(
                                                      selectedDate: data),
                                            ),
                                          );
                                        },
                                        subtitle: Column(
                                          children: [
                                            Center(
                                              child: Text(
                                                data,
                                                style: const TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            // เพิ่ม Widget ที่ต้องการแสดง (เช่น นาฬิกา) ตรงนี้
                                            // เช่น Text(DateTime.now().toString()),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container(); // If the date is not in the range, return an empty container
                          }
                        }).toList(),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
