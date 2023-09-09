import 'package:flutter/material.dart';
import 'package:polite/FoodSceen/Foodscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown[300],
          elevation: 0,
          title: Text(
            'รายการการบริโภค',
            style: TextStyle(color: Colors.white, fontSize: 23),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(children: [
              Container(
                height: 75,
                color: Color.fromARGB(255, 228, 203, 184),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 520),
                child: Container(
                  width: 260,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Foodscreen(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(const Size(
                        double.infinity,
                        48,
                      )),
                    ),
                    child: const Text(
                      'บันทึกเมนูอาหาร',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                ),
              )
            ]),
          ),
        ));
  }
}
