import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Opennutritionscreen extends StatefulWidget {
  const Opennutritionscreen({super.key});

  @override
  State<Opennutritionscreen> createState() => _OpennutritionscreenState();
}

class _OpennutritionscreenState extends State<Opennutritionscreen> {
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
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('UserID')
              .doc('')
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
                child: SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(height: 14),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(documents['fname'],
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      const SizedBox(height: 3),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(documents['email'],
                            style: TextStyle(fontSize: 21)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("aaaaaaaaaaaaaaaaaaaaaaa",
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      const SizedBox(height: 3),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                            style: TextStyle(fontSize: 21)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("aaaaaaaaaaaaaaaaaaaaaaa",
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      const SizedBox(height: 3),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                            style: TextStyle(fontSize: 21)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("aaaaaaaaaaaaaaaaaaaaaaa",
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      const SizedBox(height: 3),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                            style: TextStyle(fontSize: 21)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("aaaaaaaaaaaaaaaaaaaaaaa",
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      const SizedBox(height: 3),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                            style: TextStyle(fontSize: 21)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("aaaaaaaaaaaaaaaaaaaaaaa",
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      const SizedBox(height: 3),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                            style: TextStyle(fontSize: 21)),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Text("ไม่มีข้อมูล");
          }),
    );
  }
}
