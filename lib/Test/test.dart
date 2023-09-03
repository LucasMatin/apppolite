import 'package:flutter/material.dart';

class GenderSelectionScreen extends StatefulWidget {
  @override
  _GenderSelectionScreenState createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  // สร้างตัวแปรเพื่อเก็บค่าเพศที่ถูกเลือก
  String sex = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เลือกเพศ'),
      ),
      body: Column(
        children: <Widget>[
          RadioListTile(
            title: Text('ชาย'),
            value: 'ชาย',
            groupValue: sex,
            onChanged: (value) {
              setState(() {
                sex = value!;
              });
            },
          ),
          RadioListTile(
            title: Text('หญิง'),
            value: 'หญิง',
            groupValue: sex,
            onChanged: (value) {
              setState(() {
                sex = value!;
              });
            },
          ),
          SizedBox(height: 16.0),
          Text('เพศที่เลือก: $sex'),
        ],
      ),
    );
  }
}
