// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: unnecessary_string_interpolations, file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:polite/Screens/Home_Screen.dart';
import 'package:polite/Screens/Lilbrary_Screen.dart';
import 'package:polite/Screens/Profile_Screen.dart';
import 'package:polite/Screens/Sos_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:polite/Screens/profile_kub.dart';

// ignore: camel_case_types
class bottomsceen extends StatefulWidget {
  const bottomsceen({super.key});

  @override
  State<bottomsceen> createState() => _bottomsceenState();
}

// ignore: camel_case_types
class _bottomsceenState extends State<bottomsceen> {
  final currrenUser = FirebaseAuth.instance.currentUser!;
  int currentIndex = 0;

  // ignore: unused_element
  void _navigateBottomBar(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  final List<Widget> _pages = [
    // ignore: prefer_const_constructors
    HomeScreen(),
    const Lilbraryscreen(),
    const Sos(),
    const Profilescreen(),
  ];

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
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
                  offset: const Offset(0, 10),
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
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    width: index == currentIndex
                        ? displayWidth * .32
                        : displayWidth * .18,
                    alignment: Alignment.center,
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
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
                    duration: const Duration(seconds: 1),
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
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastLinearToSlowEaseIn,
                              width: index == currentIndex
                                  ? displayWidth * .13
                                  : 0,
                            ),
                            AnimatedOpacity(
                              opacity: index == currentIndex ? 1 : 0,
                              duration: const Duration(seconds: 1),
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
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastLinearToSlowEaseIn,
                              width: index == currentIndex
                                  ? displayWidth * .03
                                  : 20,
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
      ),
    );
  }

  List<String> listDfStrings = [
    'หน้าแรก',
    'ห้องสมุด',
    'เหตุฉุกเฉิน',
    'โปรไฟล์',
  ];
  List<IconData> listofIcons = [
    Icons.home_rounded,
    Icons.book_rounded,
    Icons.sos_rounded,
    Icons.person_rounded,
  ];
}
