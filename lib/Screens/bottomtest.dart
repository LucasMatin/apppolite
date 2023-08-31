import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:polite/Screens/Home_Screen.dart';
import 'package:polite/Screens/Lilbrary_Screen.dart';
import 'package:polite/Screens/Profile_Screen.dart';
import 'package:polite/Screens/Sos_Screen.dart';

class Bottomtest extends StatefulWidget {
  const Bottomtest({super.key});

  @override
  State<Bottomtest> createState() => _BottomtestState();
}

class _BottomtestState extends State<Bottomtest> {
  int currentIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomeScreen(),
    Lilbraryscreen(),
    Sos(),
    Profilescreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: Container(
        color: Colors.brown,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: GNav(
            backgroundColor: Colors.brown,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: const Color.fromARGB(255, 175, 139, 125),
            gap: 20,
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            tabs: [
              GButton(
                icon: Icons.home_rounded,
                text: 'Home',
              ),
              GButton(
                icon: Icons.book_rounded,
                text: 'Lilbrary',
              ),
              GButton(
                icon: Icons.sos_rounded,
                text: 'SoS',
              ),
              GButton(
                icon: Icons.person_rounded,
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
