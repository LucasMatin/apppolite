import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Gender Dropdown'),
        ),
        body: Center(
          child: MyGenderDropdown(),
        ),
      ),
    );
  }
}

class MyGenderDropdown extends StatefulWidget {
  @override
  _MyGenderDropdownState createState() => _MyGenderDropdownState();
}

class _MyGenderDropdownState extends State<MyGenderDropdown> {
  String selectedGender = 'ชาย'; // ค่าเริ่มต้น

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedGender,
      onChanged: (newValue) {
        setState(() {
          selectedGender = newValue!;
        });
      },
      items: <String>['ชาย', 'หญิง'].map((String gender) {
        return DropdownMenuItem<String>(
          value: gender,
          child: Text(gender),
        );
      }).toList(),
    );
  }
}
