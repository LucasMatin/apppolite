import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Articlescreen extends StatefulWidget {
  const Articlescreen({super.key});

  @override
  State<Articlescreen> createState() => _ArticlescreenState();
}

class _ArticlescreenState extends State<Articlescreen> {
  CollectionReference article =
      FirebaseFirestore.instance.collection("ArticleScreen");
  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    article = FirebaseFirestore.instance.collection("ArticleScreen");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        elevation: 0,
        title: Text(
          'บทความเพื่อสุขภาพ',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: article.snapshots(),
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
              return Column(
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 10),
                          //search bar
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10),
                                  hintText: "ค้นหา...",
                                  suffixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: const BorderSide())),
                            ),
                          ),
                          const SizedBox(height: 15),
                          //text
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: Container(
                              alignment: FractionalOffset.topLeft,
                              child: Text(
                                'บทความยอดนิยม',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Colors.brown),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Divider(
                            thickness: 3,
                            color: Color.fromARGB(255, 175, 136, 122),
                            indent: 25,
                            endIndent: 25,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final document = documents[index];
                        final lable1 = document['Labal'] ?? '';

                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 12,
                            top: 10,
                          ),
                          child: Column(
                            children: [
                              Card(
                                elevation: 2,
                                child: SizedBox(
                                  height: 90,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Stack(
                                          children: [
                                            ListTile(
                                              isThreeLine: false,
                                              onTap: () {
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //     builder: (context) =>
                                                //         const Editeatsreeen(),
                                                //   ),
                                                // );
                                              },
                                              subtitle: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.6,
                                                          child: Text(
                                                            lable1
                                                                        .toString()
                                                                        .length >
                                                                    20
                                                                ? lable1
                                                                        .toString()
                                                                        .substring(
                                                                            0,
                                                                            30) +
                                                                    '...'
                                                                : lable1,
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black87),
                                                          ))
                                                    ],
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
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return Text("ไม่มีข้อมูล");
          }),
    );
  }
}
