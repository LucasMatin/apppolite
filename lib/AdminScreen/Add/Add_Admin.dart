import 'package:flutter/material.dart';

class Addadminscreen extends StatefulWidget {
  const Addadminscreen({super.key});

  @override
  State<Addadminscreen> createState() => _AddadminscreenState();
}

class _AddadminscreenState extends State<Addadminscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        elevation: 0,
        title: Text(
          'เพิ่มผู้ดูแล',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
      ),
    );
  }
}
