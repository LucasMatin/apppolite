// ignore_for_file: prefer_interpolation_to_compose_strings, sized_box_for_whitespace, use_build_context_synchronously, unused_element, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:polite/AdminScreen/Add/Add_Nutrition_Screen2.dart';
import 'package:polite/AdminScreen/Add/alert_delete.dart';

class NutritionsScreen extends StatefulWidget {
  const NutritionsScreen({super.key});

  @override
  State<NutritionsScreen> createState() => _NutritionsScreenState();
}

class _NutritionsScreenState extends State<NutritionsScreen> {
  // text field controller
  TextEditingController labal = TextEditingController();
  TextEditingController symptoms = TextEditingController();

  CollectionReference _items =
      FirebaseFirestore.instance.collection('NutritionScreen');
  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    _items = FirebaseFirestore.instance.collection("NutritionScreen");
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
                    "เพิ่มชื่อโรค",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: labal,
                  decoration: const InputDecoration(
                      labelText: 'ชื่อโรค', hintText: 'กรุณากรอกชื่อโรค'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final String name = labal.text;
                      await _items.doc(name).set({
                        "Lable": name,
                      });
                      labal.text = '';

                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "ยืนยัน",
                      style: TextStyle(fontSize: 20),
                    ))
              ],
            ),
          );
        });
  }

  // for _update operation
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
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: labal,
                  decoration: const InputDecoration(
                      labelText: 'ชื่อโรค', hintText: 'กรุณากรอกชื่อโรค'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final String name = labal.text;

                      await documentSnapshot.reference.update({
                        "Lable": name,
                      });
                      labal.text = '';

                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "ยืนยัน",
                      style: TextStyle(fontSize: 20),
                    ))
              ],
            ),
          );
        });
  }

  // TextEditingController title = TextEditingController();
  // TextEditingController id = TextEditingController();
  // TextEditingController texts = TextEditingController();
  // //สร้างข้อมูลข้างใน
  // Future<void> _creates([DocumentSnapshot? documentSnapshot]) async {
  //   await showModalBottomSheet(
  //       isScrollControlled: true,
  //       context: context,
  //       builder: (BuildContext ctx) {
  //         return SingleChildScrollView(
  //           child: Padding(
  //             padding: EdgeInsets.only(
  //                 top: 20,
  //                 right: 20,
  //                 left: 20,
  //                 bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 const Center(
  //                   child: Text(
  //                     "เพิ่มหัวข้อหัว",
  //                     style:
  //                         TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   height: 10,
  //                 ),
  //                 TextField(
  //                   controller: id,
  //                   decoration: const InputDecoration(
  //                       labelText: 'ลำดับ', hintText: 'กรุณาลำดับ'),
  //                 ),
  //                 const SizedBox(
  //                   height: 10,
  //                 ),
  //                 TextField(
  //                   controller: title,
  //                   decoration: const InputDecoration(
  //                     labelText: 'หัวข้อ',
  //                     hintText: 'กรุณาเพิ่มหัวข้อ',
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   height: 10,
  //                 ),
  //                 TextField(
  //                   maxLines: 10,
  //                   controller: texts,
  //                   decoration: const InputDecoration(
  //                       labelText: 'เนื้อหา', hintText: 'กรุณาเนื้อหา'),
  //                 ),
  //                 const SizedBox(
  //                   height: 20,
  //                 ),
  //                 ElevatedButton(
  //                   onPressed: () async {
  //                     final String number = id.text;
  //                     final String name = title.text;
  //                     final String text = texts.text;
  //                     {
  //                       // ตรวจสอบว่าชื่อไม่ว่างเปล่า
  //                       await _items.doc().collection('in').doc(number).set({
  //                         "ID": number,
  //                         "Title": name,
  //                         "Content": text,
  //                       });
  //                       id.text = '';
  //                       title.text = '';
  //                       texts.text = '';

  //                       Navigator.of(context)
  //                           .pop(); // เมื่อบันทึกสำเร็จให้ปิดหน้าต่างปัจจุบัน
  //                     }
  //                   },
  //                   child: const Text("ยืนยัน"),
  //                 )
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  List<MultiSelectItem> selectedDiseases = [];
  List<MultiSelectItem> allDiseases = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 112, 86, 77),
        elevation: 0,
        title: const Text(
          'ข้อมูลโรค',
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
                                          builder: (context) => EditNutrition(
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
                                          // Row(
                                          //   crossAxisAlignment:
                                          //       CrossAxisAlignment.center,
                                          //   children: [
                                          //     InkWell(
                                          //         //TO DO DELETE
                                          //         onTap: () async {
                                          //           await _creates(document);
                                          //         },
                                          //         child: const Icon(Icons
                                          //             .create_new_folder_rounded)),
                                          //   ],
                                          // ),
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
                                                                'NutritionScreen')
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
