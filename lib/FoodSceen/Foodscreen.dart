import 'package:flutter/material.dart';

class Foodscreen extends StatefulWidget {
  const Foodscreen({super.key});

  @override
  State<Foodscreen> createState() => _FoodscreenState();
}

class _FoodscreenState extends State<Foodscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        elevation: 0,
        title: Text(
          'บันทึกรายการอาหาร',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
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
              const SizedBox(height: 14),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const OpenArticlescreen(),
                  //   ),
                  // );
                },
                child: SizedBox(
                  width: 400.0,
                  height: 140.0,
                  child: Card(
                    color: Color.fromARGB(255, 143, 113, 102),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.sunny,
                              size: 60,
                              color: Color.fromARGB(255, 235, 135, 5),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              "แนะนำเกี่ยวกับโภชนาการ",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const OpenArticlescreen(),
                  //   ),
                  // );
                },
                child: SizedBox(
                  width: 400.0,
                  height: 140.0,
                  child: Card(
                    color: Color.fromARGB(255, 143, 113, 102),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Image.asset(
                              "images/nutrition.png",
                              width: 65.0,
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              "แนะนำเกี่ยวกับโภชนาการ",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const OpenArticlescreen(),
                  //   ),
                  // );
                },
                child: SizedBox(
                  width: 400.0,
                  height: 140.0,
                  child: Card(
                    color: Color.fromARGB(255, 143, 113, 102),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Image.asset(
                              "images/nutrition.png",
                              width: 65.0,
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              "แนะนำเกี่ยวกับโภชนาการ",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
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
    );
  }
}
