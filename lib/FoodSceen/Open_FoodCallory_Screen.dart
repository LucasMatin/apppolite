import 'package:flutter/material.dart';

class Opencallory extends StatefulWidget {
  const Opencallory({super.key});

  @override
  State<Opencallory> createState() => _OpencalloryState();
}

class _OpencalloryState extends State<Opencallory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        elevation: 0,
        title: Text(
          'ปริมาณแคลอรี่',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
      ),
    );
  }
}
