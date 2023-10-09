// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:polite/LilbraryScreen/Open_Nutrition_Screen.dart';

class NutritionSreen extends StatefulWidget {
  const NutritionSreen({super.key});

  @override
  State<NutritionSreen> createState() => _NutritionSreenState();
}

class _NutritionSreenState extends State<NutritionSreen> {
  CollectionReference nutrition =
      FirebaseFirestore.instance.collection("NutritionScreen");
  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    nutrition = FirebaseFirestore.instance.collection("NutritionScreen");
  }

  TextEditingController searchtext = TextEditingController();
  String search = "";

  void searchtest(value) {
    setState(() {
      search = value.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 112, 86, 77),
        elevation: 0,
        title: const Text(
          'โรคที่พบในผู้สูงอายุ',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: nutrition.snapshots(),
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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: searchtext,
                        onChanged: (value) {
                          EasyDebounce.debounce(
                              "searchDebounce",
                              const Duration(milliseconds: 1000),
                              () => searchtest(value));
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10),
                          hintText: "ค้นหา...",
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              searchtext.clear();
                              searchtest("");
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          final document = documents[index];
                          final lablenutrition = document['Lable'] ?? '';
                          final lowercaseSearch = search.toLowerCase();
                          if (!lablenutrition
                              .toLowerCase()
                              .contains(lowercaseSearch)) {
                            return const SizedBox.shrink();
                          }

                          return SingleChildScrollView(
                            child: SafeArea(
                                child: Column(
                              children: [
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(),
                                  child: Center(
                                    child: Wrap(
                                      spacing: 20.0,
                                      runSpacing: 20.0,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Opennutritionscreen(
                                                        documentReference:
                                                            document.reference),
                                                settings: RouteSettings(
                                                    arguments: document),
                                              ),
                                            );
                                          },
                                          child: SizedBox(
                                            width: 380.0,
                                            height: 70.0,
                                            child: Card(
                                              color: const Color.fromARGB(
                                                  255, 126, 97, 87),
                                              elevation: 2.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                          height: 5.0),
                                                      Text(
                                                        lablenutrition,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 24.0,
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
                                )
                              ],
                            )),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Text("ไม่มีข้อมูล");
          }),
    );
  }
}
