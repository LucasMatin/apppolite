// ignore_for_file: file_names, sized_box_for_whitespace, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Userscreen extends StatefulWidget {
  const Userscreen({super.key});

  @override
  State<Userscreen> createState() => _UserscreenState();
}

class _UserscreenState extends State<Userscreen> {
  // text field controller
  TextEditingController labal = TextEditingController();
  TextEditingController email = TextEditingController();

  CollectionReference _items = FirebaseFirestore.instance.collection('UserID');
  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    _items = FirebaseFirestore.instance.collection("UserID");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 112, 86, 77),
          elevation: 0,
          title: const Text(
            'เช็คข้อมูลผู้ใช้',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: _items.snapshots(),
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
                final documents = snapshot.data!.docs;
                int userCount = documents.length; // นับจำนวน
                if (documents.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text('ยังไม่มีข้อมูล')],
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 75,
                            color: const Color.fromARGB(255, 228, 203, 184),
                            child: Center(
                              child: Text(
                                "จำนวนผู้ใช้: $userCount ",
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: documents.length,
                            itemBuilder: (context, index) {
                              final document = documents[index];
                              final email = document['Email'] ?? '';
                              final name = document['Fullname'] ?? '';

                              return Padding(
                                padding: const EdgeInsets.only(
                                  left: 15,
                                  right: 12,
                                  top: 10,
                                ),
                                child: Card(
                                  elevation: 1,
                                  child: SizedBox(
                                    height: 90,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Stack(
                                            children: [
                                              ListTile(
                                                isThreeLine: false,
                                                onTap: () {},
                                                subtitle: Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .only(),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "ชื่อ : $name",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 15,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .only(),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.6,
                                                              child: Text(
                                                                email.toString().length >
                                                                        20
                                                                    ? email.toString().substring(
                                                                            0,
                                                                            20) +
                                                                        '...'
                                                                    : email,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 15,
                                                                ),
                                                              ))
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ]),
                );
              }
              return const Text("ไม่มีข้อมูล");
            }));
  }
}
