import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NutritionSreen extends StatelessWidget {
  const NutritionSreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        elevation: 0,
        title: Text(
          'กินอย่างไรให้สุขภาพดี',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
      ),
    );
  }
}

class bottomscreen extends StatefulWidget {
  const bottomscreen({super.key});

  @override
  State<bottomscreen> createState() => _bottomscreen();
}

class _bottomscreen extends State<bottomscreen> {
  int currentIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  final List<Widget> _pages = [];

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(displayWidth * .05),
        height: displayWidth * .155,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.1),
                blurRadius: 30,
                offset: Offset(0, 10),
              ),
            ],
            borderRadius: BorderRadius.circular(50)),
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(() {
                currentIndex = index;
                HapticFeedback.lightImpact();
              });
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == currentIndex
                      ? displayWidth * .32
                      : displayWidth * .18,
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: index == currentIndex ? displayWidth * .12 : 0,
                    width: index == currentIndex ? displayWidth * .32 : 0,
                    decoration: BoxDecoration(
                      color: index == currentIndex
                          ? Colors.blueAccent.withOpacity(.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == currentIndex
                      ? displayWidth * .31
                      : displayWidth * .18,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width:
                                index == currentIndex ? displayWidth * .13 : 0,
                          ),
                          AnimatedOpacity(
                            opacity: index == currentIndex ? 1 : 0,
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Text(
                              index == currentIndex
                                  ? '${listDfStrings[index]}'
                                  : '',
                              style: TextStyle(
                                color: Colors.brown[400],
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width:
                                index == currentIndex ? displayWidth * .03 : 20,
                          ),
                          Icon(
                            listofIcons[index],
                            size: displayWidth * .076,
                            color: index == currentIndex
                                ? Colors.brown[300]
                                : Colors.black26,
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<String> listDfStrings = [
    'Home',
    'Lilbarary',
  ];
  List<IconData> listofIcons = [
    Icons.home_rounded,
    Icons.book_rounded,
  ];
}
