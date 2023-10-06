// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OpenArticlescreen extends StatefulWidget {
  final DocumentReference documentReference;
  const OpenArticlescreen({Key? key, required this.documentReference})
      : super(key: key);

  @override
  State<OpenArticlescreen> createState() => _OpenArticlescreenState();
}

class _OpenArticlescreenState extends State<OpenArticlescreen> {
  // Add a Stream to listen to the "in" subcollection
  late Stream<QuerySnapshot> inCollectionStream;

  @override
  void initState() {
    super.initState();
    // Initialize the Stream for the "in" subcollection
    inCollectionStream = widget.documentReference.collection('in').snapshots();
  }

  CollectionReference article =
      FirebaseFirestore.instance.collection("ArticleScreen");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 112, 86, 77),
        elevation: 0,
        title: StreamBuilder<DocumentSnapshot>(
          stream: widget.documentReference.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              final documents = snapshot.data;
              final title = documents?['Lable'] ?? '';
              return Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 23),
              );
            }
            return const Text('ไม่มีข้อมูล');
          },
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: inCollectionStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error fetching data'),
              );
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('ไม่มีข้อมูล'),
              );
            }

            final documents = snapshot.data!.docs;

            final widgets = documents.map(
              (document) {
                final t1 = document['Title'] ?? '';
                final t2 = document["Content"] ?? '';
                final t3 = document["Image"] ?? '';

                return SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              if (t3.isNotEmpty)
                                SizedBox(
                                  width: 350.0,
                                  height: 180.0,
                                  child: Card(
                                    color: const Color.fromARGB(
                                        255, 143, 113, 102),
                                    elevation: 2.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.network(t3),
                                    ),
                                  ),
                                ),
                              const SizedBox(
                                height: 20,
                              ),
                              if (t1.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Center(
                                    child: Text(
                                      t1,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              const SizedBox(
                                height: 10,
                              ),
                              if (t2.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Text(
                                    t2,
                                    style: const TextStyle(
                                      fontSize: 19,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ).toList(); // เพิ่ม .toList() เพื่อแปลงเป็นรายการวิดเจ็ต
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: widgets,
                ),
              ),
            );
          }),
    );
  }
}
