// ignore_for_file: file_names, use_key_in_widget_constructors, non_constant_identifier_names, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Sexuser extends StatefulWidget {
  const Sexuser({Key? key});

  @override
  State<Sexuser> createState() => _SexuserState();
}

class _SexuserState extends State<Sexuser> {
  int maleCount = 0;
  int WomanCount = 0;
  CollectionReference _items = FirebaseFirestore.instance.collection('UserID');

  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    _items = FirebaseFirestore.instance.collection("UserID");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 112, 86, 77),
        elevation: 0,
        title: const Text(
          'จำนวนผู้ใช้',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _items.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            final documents = snapshot.data!.docs;
            int userCount = documents.length; // นับจำนวน
            maleCount = documents
                .where((doc) =>
                    doc.data() is Map<String, dynamic> &&
                    (doc.data() as Map<String, dynamic>).containsKey("Sex") &&
                    (doc.data() as Map<String, dynamic>)["Sex"] == 'ชาย')
                .length;
            WomanCount = documents
                .where((doc) =>
                    doc.data() is Map<String, dynamic> &&
                    (doc.data() as Map<String, dynamic>).containsKey("Sex") &&
                    (doc.data() as Map<String, dynamic>)["Sex"] == 'หญิง')
                .length;
            if (documents.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('ยังไม่มีข้อมูล')],
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 75,
                          color: const Color.fromARGB(255, 228, 203, 184),
                          child: Center(
                            child: Text(
                              "จำนวนผู้ใช้: $userCount ",
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Text(
                          "ชาย: $maleCount",
                          style: const TextStyle(fontSize: 25),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Text(
                          "หญิง: $WomanCount",
                          style: const TextStyle(fontSize: 25),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: SfCircularChart(
                                legend: Legend(isVisible: true),
                                series: <CircularSeries>[
                                  PieSeries<ChartData, String>(
                                      dataSource: <ChartData>[
                                        ChartData(
                                            "ชาย",
                                            (maleCount *
                                                    100 /
                                                    (maleCount + WomanCount))
                                                .round()),
                                        ChartData(
                                            "หญิง",
                                            (WomanCount *
                                                    100 /
                                                    (maleCount + WomanCount))
                                                .round()),
                                      ],
                                      xValueMapper: (ChartData data, _) =>
                                          data.sexman,
                                      yValueMapper: (ChartData data, _) =>
                                          data.value,
                                      dataLabelSettings:
                                          const DataLabelSettings(
                                        isVisible: true,
                                        labelPosition:
                                            ChartDataLabelPosition.inside,
                                      ))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6),
                              child: Stack(
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(),
                                              child: Text(
                                                "เพศชาย: ${(maleCount * 100 / (maleCount + WomanCount)).round()} %",
                                                style: const TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(),
                                              child: Text(
                                                "เพศหญิง: ${(WomanCount * 100 / (maleCount + WomanCount)).round()} %",
                                                style: const TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return const Text("ไม่มีข้อมูล");
        },
      ),
    );
  }
}

class ChartData {
  ChartData(this.sexman, this.value);
  final String sexman;
  final int value;
}
