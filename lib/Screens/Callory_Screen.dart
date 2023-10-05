// ignore_for_file: unused_field, file_names, use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CalloryweekScreen extends StatefulWidget {
  const CalloryweekScreen({Key? key});

  @override
  State<CalloryweekScreen> createState() => _CalloryweekScreenState();
}

class _CalloryweekScreenState extends State<CalloryweekScreen> {
  late final User _currentUser;
  late final String _userUid;
  late final CollectionReference _foodTodayCollection;
  late final CollectionReference _foodMorningCollection;
  late final CollectionReference _foodDayTimeCollection;
  late final CollectionReference _foodEveningCollection;
  late DateTime startDate; // Declare startDate here
  late DateTime endDate; // Declare endDate here

  List<ChartData> chartData = [];
  double totalCalories = 0.0;
  late String _currentDate; // Declare _currentDate here

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser!;
    _userUid = _currentUser.uid;
    _currentDate = getCurrentDateTime(); // Initialize _currentDate here
    _foodTodayCollection = FirebaseFirestore.instance
        .collection("UserID")
        .doc(_userUid)
        .collection("Foodtoday");
    _foodMorningCollection =
        _foodTodayCollection.doc(_currentDate).collection("FoodMorning");
    _foodDayTimeCollection =
        _foodTodayCollection.doc(_currentDate).collection("FoodDayTime");
    _foodEveningCollection =
        _foodTodayCollection.doc(_currentDate).collection("FoodEvening");

    // Fetch data for the entire week
    _fetchDataForWeek();
  }

  String getCurrentDateTime() {
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(now);
  }

  Future<void> _fetchDataForWeek() async {
    DateTime now = DateTime.now();
    endDate = now.subtract(Duration(days: now.weekday));
    startDate = endDate.subtract(const Duration(days: 6));

    for (int i = 0; i < 7; i++) {
      DateTime currentDate = startDate.add(Duration(days: i));
      String dateKey = DateFormat('dd-MM-yyyy').format(currentDate);
      print("Fetching data for date: $dateKey");

      await _calculateTotalCaloriesForDay(dateKey);
    }

    double totalCaloriesForWeek =
        chartData.fold(0, (sum, data) => sum + data.value);

    setState(() {
      totalCalories = totalCaloriesForWeek;
    });
  }

  Future<void> _calculateTotalCaloriesForDay(String dateKey) async {
    CollectionReference foodMorningCollection =
        _foodTodayCollection.doc(dateKey).collection("FoodMorning");
    CollectionReference foodDayTimeCollection =
        _foodTodayCollection.doc(dateKey).collection("FoodDayTime");
    CollectionReference foodEveningCollection =
        _foodTodayCollection.doc(dateKey).collection("FoodEvening");

    double morningCalories = await _getTotalCalories(foodMorningCollection);
    double dayTimeCalories = await _getTotalCalories(foodDayTimeCollection);
    double eveningCalories = await _getTotalCalories(foodEveningCollection);

    setState(() {
      double totalCaloriesForDay =
          morningCalories + dayTimeCalories + eveningCalories;
      chartData.add(ChartData(dateKey, totalCaloriesForDay));
    });
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
          'สรุปแคลอรี่สัปดาห์ที่แล้ว',
          style: TextStyle(
              color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: 75,
                color: const Color.fromARGB(255, 228, 203, 184),
                child: Center(
                  child: Text(
                    "${DateFormat('dd-MM-yyyy').format(startDate)} - ${DateFormat('dd-MM-yyyy').format(endDate)}",
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
                  child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    series: <ChartSeries>[
                      ColumnSeries<ChartData, String>(
                        dataSource: chartData,
                        xValueMapper: (ChartData data, _) => data.category,
                        yValueMapper: (ChartData data, _) => data.value,
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                          labelAlignment: ChartDataLabelAlignment.top,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "รวมแคลอรี่: $totalCalories แคลอรี่",
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.category, this.value);

  final String category;
  final double value;
}
