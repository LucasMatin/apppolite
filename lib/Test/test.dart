// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Gender Dropdown'),
        ),
        body: const Center(
          child: MyGenderDropdown(),
        ),
      ),
    );
  }
}

class MyGenderDropdown extends StatefulWidget {
  const MyGenderDropdown({super.key});

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
