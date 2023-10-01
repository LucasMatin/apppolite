import 'package:flutter/material.dart';

// ignore: camel_case_types
class textapp extends StatefulWidget {
  const textapp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _textappState createState() => _textappState();
}

// ignore: camel_case_types
class _textappState extends State<textapp> {
  int number = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('เพิ่ม/ลดตัวเลข'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'ตัวเลขปัจจุบัน: $number',
                    style: const TextStyle(fontSize: 24.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            number--;
                          });
                        },
                      ),
                      const SizedBox(width: 20.0),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            number++;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
