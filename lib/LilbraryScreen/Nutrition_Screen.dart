import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        elevation: 0,
        title: Text(
          'แนะนำเกี่ยวกับโภชนาการ',
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
              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final document = documents[index];
                  final lablenutrition = document['Lablenutrition'] ?? '';

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
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) =>
                                    //         const Opennutritionscreen(),
                                    //   ),
                                    // );
                                  },
                                  child: SizedBox(
                                    width: 380.0,
                                    height: 70.0,
                                    child: Card(
                                      color: Color.fromARGB(255, 143, 113, 102),
                                      elevation: 2.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              SizedBox(height: 5.0),
                                              Text(
                                                lablenutrition,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
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
              );
            }
            return Text("ไม่มีข้อมูล");
          }),
    );
  }
}
