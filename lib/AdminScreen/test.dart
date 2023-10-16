import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:polite/AdminScreen/Add/alert_delete.dart';

class testsss extends StatefulWidget {
  const testsss({super.key});

  @override
  State<testsss> createState() => _testsssState();
}

class _testsssState extends State<testsss> {
  TextEditingController id = TextEditingController();
  TextEditingController lable = TextEditingController();
  CollectionReference _items =
      FirebaseFirestore.instance.collection('Foodtype');
  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    _items = FirebaseFirestore.instance.collection("Foodtype");
  }

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
                    "เพิ่มประเภทอาหาร",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: id,
                  decoration: const InputDecoration(
                      labelText: 'ชื่อหมวด', hintText: 'กรุณากรอกชื่อหมวด'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: lable,
                  decoration: const InputDecoration(
                      labelText: 'ชื่อประเภท', hintText: 'กรุณาชื่อประเภท'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final String name = id.text;
                    final String names = lable.text;
                    await _items.doc(name).set({
                      "ID": name,
                      "Lable": names,
                    });
                    id.text = '';
                    lable.text = '';

                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // กำหนดสีพื้นหลังเป็นสีเขียว
                  ),
                  child: const Text(
                    "ยืนยัน",
                    style: TextStyle(fontSize: 25),
                  ),
                )
              ],
            ),
          );
        });
  }

  Future<void> _update(DocumentSnapshot documentSnapshot) async {
    final String initialLabel = documentSnapshot['Lable'];
    final String initialid = documentSnapshot['ID'];

    lable.text = initialLabel;
    id.text = initialid;
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
                    "เพิ่มประเภทอาหาร",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: id,
                  decoration: const InputDecoration(
                      labelText: 'ชื่อหมวด', hintText: 'กรุณากรอกชื่อหมวด'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: lable,
                  decoration: const InputDecoration(
                      labelText: 'ชื่อประเภท', hintText: 'กรุณาชื่อประเภท'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final String name = id.text;
                    final String names = lable.text;
                    await _items.doc(name).update({
                      "ID": name,
                      "Lable": names,
                    });
                    id.text = '';
                    lable.text = '';

                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // กำหนดสีพื้นหลังเป็นสีเขียว
                  ),
                  child: const Text(
                    "ยืนยัน",
                    style: TextStyle(fontSize: 25),
                  ),
                )
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
          'ประเภทอาหาร',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
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
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final document = documents[index];
                        final lable1 = document['ID'] ?? '';
                        final lable2 = document['Lable'] ?? '';

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
                                                padding:
                                                    const EdgeInsets.all(2),
                                                child: Row(
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
                                                                          20) +
                                                                  '...'
                                                              : lable1,
                                                          style: const TextStyle(
                                                              fontSize: 23,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(2),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "$lable2",
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Stack(
                                              children: [
                                                SizedBox(
                                                  width: 70,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          InkWell(
                                                              //TO DO DELETE
                                                              onTap: () async {
                                                                await _update(
                                                                    document);
                                                              },
                                                              child: const Icon(
                                                                Icons.edit,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        133,
                                                                        132,
                                                                        132),
                                                              )),
                                                        ],
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          InkWell(
                                                              //TO DO DELETE
                                                              onTap: () async {
                                                                final action = await AlertDialogs
                                                                    .yesorCancel(
                                                                        context,
                                                                        'ลบ',
                                                                        'คุณต้องการลบข้อมูลนี้หรือไม่');
                                                                if (action ==
                                                                    DialogsAction
                                                                        .yes) {
                                                                  setState(() {
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'Foodtype')
                                                                        .doc(document
                                                                            .id)
                                                                        .delete()
                                                                        .then(
                                                                            (_) {})
                                                                        .catchError(
                                                                            (error) {});
                                                                  });
                                                                }
                                                              },
                                                              child: const Icon(
                                                                Icons.delete,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        133,
                                                                        132,
                                                                        132),
                                                              )),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
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
                    ),
                  ),
                ],
              );
            }
            return const Text("ไม่มีข้อมูล");
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        backgroundColor: const Color.fromARGB(255, 112, 86, 77),
        child: const Icon(Icons.add),
      ),
    );
  }
}
