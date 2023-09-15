import 'package:flutter/material.dart';
import 'package:polite/FoodSceen/Foodscreen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown[300],
          elevation: 0,
          title: Text(
            'รายการการบริโภค',
            style: TextStyle(color: Colors.white, fontSize: 23),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(children: [
              Container(
                height: 75,
                color: Color.fromARGB(255, 228, 203, 184),
              ),
              Padding(
                  padding: const EdgeInsets.only(),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: SfCircularChart(
                          series: <CircularSeries>[
                            RadialBarSeries<RadialBarData, String>(
                              maximumValue:
                                  1000, // ค่าสูงสุดที่ต้องการแสดง (ครึ่งวงกลม)
                              gap: '20%', // ระยะห่างระหว่างแท่งครึ่งวงกลม

                              dataSource: <RadialBarData>[
                                RadialBarData('Category 1', 700),
                              ],
                              xValueMapper: (RadialBarData data, _) =>
                                  data.category,
                              yValueMapper: (RadialBarData data, _) =>
                                  data.value,
                              pointColorMapper: (RadialBarData data, _) {
                                // เปลี่ยนสีของแท่ง Radial Bar ตามค่า
                                if (data.value > 800) {
                                  return Colors
                                      .red; // ถ้าค่ามากกว่า 100 เปลี่ยนเป็นสีแดง
                                } else if (data.value > 600) {
                                  return Colors
                                      .yellow; // ถ้าค่ามากกว่า 60 ใช้สีเหลือง
                                } else {
                                  return Colors
                                      .green; // ถ้าค่าน้อยกว่าหรือเท่ากับ 60 ใช้สีฟ้า
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        child: Text(
                          _getStatusText(700), // ตรวจสอบสถานะและสร้างข้อความ
                          style: TextStyle(
                            color: Colors.green, // สีข้อความสีเขียว
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.all(50),
                child: Container(
                  width: 260,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Foodscreen(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(const Size(
                        double.infinity,
                        48,
                      )),
                    ),
                    child: const Text(
                      'บันทึกเมนูอาหาร',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                ),
              )
            ]),
          ),
        ));
  }
}

String _getStatusText(double value) {
  if (value > 900) {
    return 'อยู่ในเกณฑ์อันตราย';
  } else if (value > 600) {
    return 'อยู่ในเกณฑ์เสี่ยง';
  } else {
    return 'อยู่ในเกณฑ์ปกติ';
  }
}

class RadialBarData {
  RadialBarData(this.category, this.value);

  final String category;
  final double value;
}
