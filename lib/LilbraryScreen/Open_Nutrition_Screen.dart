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
        backgroundColor: Colors.brown[300],
        elevation: 0,
        title: Text(
          'แนะนำเกี่ยวกับโภชนาการ',
          style: TextStyle(color: Colors.white, fontSize: 23),
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
                        SizedBox(
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
                                      style: TextStyle(
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
                                  style: TextStyle(fontSize: 19),
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
            return Text("ไม่มีข้อมูล");
          }),
    );
  }
}
