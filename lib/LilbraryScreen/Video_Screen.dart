import 'package:flutter/material.dart';

import 'package:polite/LilbraryScreen/Open_Video_Screen.dart';

class videoscreen extends StatelessWidget {
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
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 10),
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
                const SizedBox(height: 15),
                //text
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Container(
                    alignment: FractionalOffset.topLeft,
                    child: Text(
                      'วิดีโอเพื่อสุขภาพ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.brown),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(
                  thickness: 3,
                  color: Color.fromARGB(255, 175, 136, 122),
                  indent: 25,
                  endIndent: 25,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 150),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Openvideoscreen(),
                            ),
                          );
                        },
                        child: SizedBox(
                          width: 400.0,
                          height: 130.0,
                          child: Card(
                            color: Color.fromARGB(255, 143, 113, 102),
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "images/nutrition.png",
                                      width: 65.0,
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      "แนะนำเกี่ยวกับโภชนาการ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
