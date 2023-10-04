// ignore_for_file: file_names

import 'package:flutter/material.dart';

class NutritionsScreen extends StatefulWidget {
  const NutritionsScreen({super.key});

  @override
  State<NutritionsScreen> createState() => _NutritionsScreenState();
}

class _NutritionsScreenState extends State<NutritionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        elevation: 0,
        title: const Text(
          'เพิ่มข้อมูลโรค',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
      ),
    );
  }
}
