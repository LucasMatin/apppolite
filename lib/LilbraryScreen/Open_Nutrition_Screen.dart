// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Opennutritionscreen extends StatefulWidget {
  final DocumentReference documentReference;
  const Opennutritionscreen({Key? key, required this.documentReference})
      : super(key: key);

  @override
  State<Opennutritionscreen> createState() => _OpennutritionscreenState();
}

class _OpennutritionscreenState extends State<Opennutritionscreen> {
  // Add a Stream to listen to the "in" subcollection
  late Stream<QuerySnapshot> inCollectionStream;

  @override
  void initState() {
    super.initState();
    // Initialize the Stream for the "in" subcollection
    inCollectionStream = widget.documentReference.collection('in').snapshots();
  }

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
                  final t1 = document['Title'] ?? '';
                  final t2 = document["Content"] ?? '';

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Text(
                                      t1,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Text(
                                  t2,
                                  style: const TextStyle(fontSize: 19),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return const Text("ไม่มีข้อมูล");
          }),
    );
  }
}
