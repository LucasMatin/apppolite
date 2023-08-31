import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

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
    body: Column(children: [
      Container(
        height: 75,
        color: Color.fromARGB(255, 228, 203, 184),
      ),
    ]),
  );
}
