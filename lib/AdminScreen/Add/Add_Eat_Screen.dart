// ignore_for_file: prefer_interpolation_to_compose_strings, sized_box_for_whitespace, use_build_context_synchronously, unused_element, file_names, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:polite/AdminScreen/Add/alert_delete.dart';

//ส่วนการเพิ่มข้อมูล
class Saveeat extends StatefulWidget {
  const Saveeat({super.key});

  @override
  State<Saveeat> createState() => _SaveeatState();
}

class _SaveeatState extends State<Saveeat> {
  // text field controller
  TextEditingController title1 = TextEditingController();
  TextEditingController title2 = TextEditingController();
  TextEditingController id = TextEditingController();

  CollectionReference _items =
      FirebaseFirestore.instance.collection('EatScreen');
  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    _items = FirebaseFirestore.instance.collection("EatScreen");
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
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "เพิ่มหัวข้อหัว",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: id,
                      decoration: const InputDecoration(
                          labelText: 'ลำดับ', hintText: 'กรุณาลำดับ'),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      maxLines: 1,
                      controller: title1,
                      decoration: const InputDecoration(
                          labelText: 'หัวข้อ', hintText: 'กรุณาเพิ่มหัวข้อ'),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      maxLines: 10,
                      controller: title2,
                      decoration: const InputDecoration(
                          labelText: 'เนื้อหา', hintText: 'กรุณาเนื้อหา'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final String name = title1.text;
                        final String nname = title2.text;
                        final String num = id.text;
                        await _items.doc(num).set({
                          "Title1": name,
                          "Title2": nname,
                          "ID": num,
                        });
                        title1.text = '';
                        title2.text = '';
                        id.text = '';

                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(
                            255, 86, 167, 89), // กำหนดสีพื้นหลังเป็นสีเขียว
                      ),
                      child: const Text(
                        "ยืนยัน",
                        style: TextStyle(fontSize: 25),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  // for _update operation
  Future<void> _update(DocumentSnapshot documentSnapshot) async {
    final String initialID = documentSnapshot['ID'];
    final String initialTitle1 = documentSnapshot['Title1'];
    final String initialTitle2 = documentSnapshot['Title2'];

    id.text = initialID;
    title1.text = initialTitle1;
    title2.text = initialTitle2;

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
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "แก้ไข",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: id,
                      decoration: const InputDecoration(
                          labelText: 'ลำดับ', hintText: 'กรุณาลำดับ'),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      maxLines: 1,
                      controller: title1,
                      decoration: const InputDecoration(
                          labelText: 'หัวข้อ', hintText: 'กรุณาเพิ่มหัวข้อ'),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      maxLines: 10,
                      controller: title2,
                      decoration: const InputDecoration(
                          labelText: 'เนื้อหา', hintText: 'กรุณาเนื้อหา'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final String name = title1.text;
                        final String nname = title2.text;
                        final String num = id.text;
                        await documentSnapshot.reference.update({
                          "Title1": name,
                          "Title2": nname,
                          "ID": num,
                        });
                        title1.text = '';
                        title2.text = '';
                        id.text = '';

                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(
                            255, 86, 167, 89), // กำหนดสีพื้นหลังเป็นสีเขียว
                      ),
                      child: const Text(
                        "ยืนยัน",
                        style: TextStyle(fontSize: 25),
                      ),
                    )
                  ],
                ),
              ),
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
          'กินอย่างไรให้สุขภาพดี',
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
                  final title1 = document['Title1'] ?? '';
                  final title2 = document['Title2'] ?? '';
                  final number = document['ID'] ?? '';

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
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => Editarticle(
                                      //         documentReference:
                                      //             document.reference),
                                      //     settings: RouteSettings(
                                      //         arguments: document),
                                      //   ),
                                      // );
                                    },
                                    subtitle: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text("# $number"),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              title1,
                                              style: const TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                child: Text(title2
                                                            .toString()
                                                            .length >
                                                        20
                                                    ? title2
                                                            .toString()
                                                            .substring(0, 20) +
                                                        '...'
                                                    : title2))
                                          ],
                                        ),
                                      ],
                                    ),
                                    trailing: SizedBox(
                                      width: 60,
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
                                                                'EatScreen')
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
        backgroundColor: const Color.fromARGB(255, 112, 86, 77),
        child: const Icon(Icons.add),
      ),
    );
  }
}
