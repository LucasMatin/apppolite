// ignore_for_file: file_names, unused_element, use_build_context_synchronously, sized_box_for_whitespace, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:polite/AdminScreen/Add/Add_Article_Screen2.dart';
import 'package:polite/AdminScreen/Add/alert_delete.dart';

class Addarticale extends StatefulWidget {
  const Addarticale({super.key});

  @override
  State<Addarticale> createState() => _AddarticaleState();
}

class _AddarticaleState extends State<Addarticale> {
  // text field controller
  TextEditingController labal = TextEditingController();

  CollectionReference _items =
      FirebaseFirestore.instance.collection('ArticleScreen');
  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    _items = FirebaseFirestore.instance.collection("ArticleScreen");
  }

  String searchText = '';
  // for create operation
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "เพิ่มหัวข้อหัว",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: labal,
                  decoration: const InputDecoration(
                      labelText: 'หัวข้อ', hintText: 'กรุณาเพิ่มหัวข้อ'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final String name = labal.text;
                    if (name.isNotEmpty) {
                      // ตรวจสอบว่าชื่อไม่ว่างเปล่า
                      await _items.doc(name).set({
                        "Lable": name,
                      });
                      labal.text = '';
                      Navigator.of(context)
                          .pop(); // เมื่อบันทึกสำเร็จให้ปิดหน้าต่างปัจจุบัน
                    } else {
                      // ในกรณีที่ชื่อว่างเปล่า คุณสามารถแจ้งเตือนผู้ใช้หรือดำเนินการเพิ่มเติมตามที่คุณต้องการ
                      // ยกตัวอย่างเช่นแสดง SnackBar หรือ AlertDialog
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('กรุณากรอกชื่อ'),
                        ),
                      );
                    }
                  },
                  child: const Text("ยืนยัน"),
                )
              ],
            ),
          );
        });
  }

  // for Update operation
  Future<void> _update(DocumentSnapshot documentSnapshot) async {
    final String initialLabel = documentSnapshot['Lable'];

    labal.text = initialLabel;

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
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
                      labelText: 'หัวข้อ', hintText: 'eg.Elon'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final String name = labal.text;

                      await documentSnapshot.reference.update({"Lable": name});
                      labal.text = '';

                      Navigator.of(context).pop();
                    },
                    child: const Text("ยืนยัน"))
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 112, 86, 77),
        elevation: 0,
        title: const Text(
          'บทความเพื่อสุขภาพ',
          style: TextStyle(color: Colors.white, fontSize: 25),
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
                  final lable1 = document['Lable'] ?? '';

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
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Editarticle(
                                              documentReference:
                                                  document.reference),
                                          settings: RouteSettings(
                                              arguments: document),
                                        ),
                                      );
                                    },
                                    subtitle: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.6,
                                                  child: Text(
                                                    lable1.toString().length >
                                                            20
                                                        ? lable1
                                                                .toString()
                                                                .substring(
                                                                    0, 20) +
                                                            '...'
                                                        : lable1,
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                                                'ArticleScreen')
                                                            .doc(document.id)
                                                            .delete()
                                                            .then((_) {})
                                                            .catchError(
                                                                (error) {});
                                                      });
                                                    }
                                                  },
                                                  child:
                                                      const Icon(Icons.delete)),
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
          }),
      // Create new project button
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        backgroundColor: const Color.fromARGB(255, 161, 136, 127),
        child: const Icon(Icons.add),
      ),
    );
  }
}
