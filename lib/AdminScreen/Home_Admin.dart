import 'package:flutter/material.dart';

class HomeadminScreen extends StatefulWidget {
  const HomeadminScreen({super.key});

  @override
  State<HomeadminScreen> createState() => _HomeadminScreenState();
}

class _HomeadminScreenState extends State<HomeadminScreen> {
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
    );
  }
}
