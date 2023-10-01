// ignore_for_file: prefer_interpolation_to_compose_strings, sized_box_for_whitespace, use_build_context_synchronously, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:polite/AdminScreen/Add/alert_delete.dart';

class Adminuser extends StatefulWidget {
  const Adminuser({super.key});

  @override
  State<Adminuser> createState() => _AdminuserState();
}

class _AdminuserState extends State<Adminuser> {
  // text field controller
  TextEditingController labal = TextEditingController();
  TextEditingController email = TextEditingController();

  CollectionReference _items = FirebaseFirestore.instance.collection('AdminID');
  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    _items = FirebaseFirestore.instance.collection("AdminID");
  }

  // for _update operation
  Future<void> _update(DocumentSnapshot documentSnapshot) async {
    final String initialLabel = documentSnapshot['Fullname'];
    final String initialUrl = documentSnapshot['Email'];

    labal.text = initialLabel;
    email.text = initialUrl;

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            right: 20,
            left: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "แก้ไข",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              TextField(
                controller: labal,
                decoration: const InputDecoration(
                  labelText: 'ชื่อแอดมิน',
                  hintText: 'กรุณาชื่อแอดมิน',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: email,
                decoration: const InputDecoration(
                  labelText: 'อีเมลล์',
                  hintText: 'กรุณาอีเมลล์',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  final String name = labal.text;
                  final String urlvideos = email.text;

                  await documentSnapshot.reference.update({
                    "Email": name,
                    'Fullname': urlvideos,
                  });

                  labal.text = '';
                  email.text = '';

                  Navigator.of(context).pop();
                },
                child: const Text("ยืนยัน"),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown[300],
          elevation: 0,
          title: const Text(
            'เช็คแอดมิน',
            style: TextStyle(color: Colors.white, fontSize: 23),
          ),
          centerTitle: true,
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
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                            padding: const EdgeInsets.only(),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "แอดมิน : $name",
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(),
                                            child: Row(
                                              children: [
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.6,
                                                    child: Text(
                                                      email.toString().length >
                                                              20
                                                          ? email
                                                                  .toString()
                                                                  .substring(
                                                                      0, 20) +
                                                              '...'
                                                          : email,
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: SizedBox(
                                        width: 40,
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                    //TO DO DELETE
                                                    onTap: () async {
                                                      await _update(document);
                                                    },
                                                    child:
                                                        const Icon(Icons.edit)),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                    //TO DO DELETE
                                                    onTap: () async {
                                                      final action =
                                                          await AlertDialogs
                                                              .yesorCancel(
                                                                  context,
                                                                  'ลบ',
                                                                  'คุณต้องการลบข้อมูลนี้หรือไม่');
                                                      if (action ==
                                                          DialogsAction.yes) {
                                                        setState(() {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'AdminID')
                                                              .doc(document.id)
                                                              .delete()
                                                              .then((_) {})
                                                              .catchError(
                                                                  (error) {});
                                                        });
                                                      }
                                                    },
                                                    child: const Icon(
                                                        Icons.delete)),
                                              ],
                                            ),
                                          ],
                                        ),
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
                );
              }
              return const Text("ไม่มีข้อมูล");
            }));
  }
}
