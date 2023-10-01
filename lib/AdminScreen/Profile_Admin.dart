// ignore_for_file: sort_child_properties_last, avoid_unnecessary_containers, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:polite/Screens/Login_Screen.dart';
import 'package:flutter/material.dart';

class Profiladminescreen extends StatefulWidget {
  const Profiladminescreen({super.key});

  @override
  State<Profiladminescreen> createState() => _ProfiladminescreenState();
}

class _ProfiladminescreenState extends State<Profiladminescreen> {
  final currrenUser = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        elevation: 0,
        title: const Text(
          'ข้อมูลผู้ดูแล',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('AdminID')
              .doc(currrenUser.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              final documents = snapshot.data!.data() as Map<String, dynamic>;

              return SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Stack(
                        children: [
                          SizedBox(
                            width: 130,
                            height: 130,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset('images/proflie.jpg'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(documents['Fullname'],
                              style: const TextStyle(fontSize: 21)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(documents['Email'],
                              style: const TextStyle(fontSize: 18)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("ผู้ดูแล", style: TextStyle(fontSize: 18)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            child: const Text("ออกจากระบบ"),
                            style: ElevatedButton.styleFrom(
                                // backgroundColor:
                                ),
                          )),
                      const SizedBox(height: 10),
                      const Divider(),
                    ],
                  ),
                ),
              );
            }
            return const Text("ไม่มีข้อมูล");
          }),
    );
  }
}
