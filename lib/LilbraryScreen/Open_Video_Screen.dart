import 'package:flutter/material.dart';

class Openvideoscreen extends StatefulWidget {
  const Openvideoscreen({super.key});

  @override
  State<Openvideoscreen> createState() => _OpenvideoscreenState();
}

class _OpenvideoscreenState extends State<Openvideoscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        elevation: 0,
        title: Text(
          'วิดีโอเพื่อสุขภาพ',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            const SizedBox(height: 90),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: SizedBox(
                    width: 400.0,
                    height: 210.0,
                    child: Card(
                      color: Color.fromARGB(255, 143, 113, 102),
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Text(
              "aaaaaaaaaaaaaaa",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Container(
                alignment: FractionalOffset.topLeft,
                child: Text(
                  'แหล่งอ้างอิง :',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Text(
              "aaaaaaaaaaaaaaa",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
