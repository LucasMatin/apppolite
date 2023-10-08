// ignore_for_file: file_names, camel_case_types, unnecessary_string_interpolations, unused_import

import 'package:polite/AdminScreen/Add/Add_Admin.dart';
import 'package:polite/AdminScreen/Admin_Screen.dart';
import 'package:polite/AdminScreen/Home_Admin.dart';
import 'package:polite/AdminScreen/Profile_Admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:polite/AdminScreen/User_Screen.dart';

class bottomadminsceen extends StatefulWidget {
  const bottomadminsceen({super.key});

  @override
  State<bottomadminsceen> createState() => _bottomadminsceenState();
}

class _bottomadminsceenState extends State<bottomadminsceen> {
  int currentIndex = 0;

  // ignore: unused_element
  void _navigateBottomBar(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  final List<Widget> _pages = [
    const HomeadminScreen(),
    const Userscreen(),
    const Addadminscreen(),
    const Profiladminescreen(),
  ];

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
                            width:
                                index == currentIndex ? displayWidth * .13 : 0,
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
    'Check',
    'ADMIN',
    'Profile',
  ];
  List<IconData> listofIcons = [
    Icons.home_rounded,
    Icons.list_sharp,
    Icons.add_moderator_outlined,
    Icons.person_rounded,
  ];
}
