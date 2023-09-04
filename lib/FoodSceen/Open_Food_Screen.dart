import 'package:flutter/material.dart';

class Openfoodscreen extends StatefulWidget {
  const Openfoodscreen({super.key});

  @override
  State<Openfoodscreen> createState() => _OpenfoodscreenState();
}

class _OpenfoodscreenState extends State<Openfoodscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        elevation: 0,
        title: Text(
          'อาหารเช้า',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              //search bar
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10),
                      hintText: "ค้นหา...",
                      suffixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide())),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
