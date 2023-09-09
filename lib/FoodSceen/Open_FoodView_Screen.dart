import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Openview extends StatefulWidget {
  const Openview({super.key});

  @override
  State<Openview> createState() => _OpenviewState();
}

class _OpenviewState extends State<Openview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        elevation: 0,
        title: Text(
          'รายการอาหาร',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Container(
                  height: 75,
                  color: Color.fromARGB(255, 228, 203, 184),
                  child: Center(
                    child: Text(
                      "วันที่",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                  ),
                ),
                textbar("textbar1"),
                textview("textview1", "textview2", "textview3")
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget textbar(textbar1) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 10),
        child: Container(
          alignment: FractionalOffset.topLeft,
          child: Text(
            textbar1,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
          ),
        ),
      ),
      const SizedBox(height: 10),
      const Divider(
        thickness: 4,
        color: Colors.black,
        indent: 25,
        endIndent: 25,
      ),
    ],
  );
}

Widget textview(textview1, textview2, textview3) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 10),
        child: Container(
          alignment: FractionalOffset.topLeft,
          child: Row(
            children: [
              Text(
                textview1,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                textview2,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(),
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Column(
                      children: [
                        Text(
                          textview2,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      const Divider(
        thickness: 2,
        color: Colors.grey,
        indent: 25,
        endIndent: 25,
      ),
    ],
  );
}
