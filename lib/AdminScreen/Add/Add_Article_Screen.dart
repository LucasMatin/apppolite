// ignore_for_file: file_names, unused_element, use_build_context_synchronously, sized_box_for_whitespace, prefer_interpolation_to_compose_strings, deprecated_member_use, avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
                    "เพิ่มหัวข้อ",
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
          );
        });
  }

  String imageUrl = '';
  List<File> image = [];
  ImagePicker picker = ImagePicker();
  TextEditingController title = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController texts = TextEditingController();
  // for create operation
  Future<void> _creates(DocumentSnapshot documentSnapshot) async {
    final String parentDocumentId = documentSnapshot.id;
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return SingleChildScrollView(
            child: Padding(
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: id,
                    decoration: const InputDecoration(
                        labelText: 'ลำดับ', hintText: 'กรุณาลำดับ'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: title,
                    decoration: const InputDecoration(
                      labelText: 'หัวข้อ',
                      hintText: 'กรุณาเพิ่มหัวข้อ',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    maxLines: 10,
                    controller: texts,
                    decoration: const InputDecoration(
                        labelText: 'เนื้อหา', hintText: 'กรุณาเนื้อหา'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    onTap: () async {
                      ImagePicker imagePicker = ImagePicker();
                      XFile? file = await imagePicker.pickImage(
                        source: ImageSource.gallery,
                      );

                      print('${file?.path}');

                      if (file == null) return;

                      String uniqueFileName =
                          DateTime.now().millisecondsSinceEpoch.toString();

                      Reference referenceRoot = FirebaseStorage.instance.ref();
                      Reference referenceDirImages =
                          referenceRoot.child('Article');

                      Reference referenceImageToUpload =
                          referenceDirImages.child(uniqueFileName);

                      try {
                        await referenceImageToUpload.putFile(File(file.path));

                        imageUrl =
                            await referenceImageToUpload.getDownloadURL();
                        // แสดงข้อมูลหลังจากอัปโหลดรูปภาพสำเร็จ
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('อัปโหลดรูปภาพสำเร็จ'),
                              content: Column(
                                children: [
                                  Image.network(
                                      imageUrl), // แสดงรูปภาพที่อัปโหลด
                                  Text('URL ของรูปภาพ: $imageUrl'),
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('ปิด'),
                                ),
                              ],
                            );
                          },
                        );
                        setState(() {});
                      } catch (error) {
                        // แสดงข้อความหรือผลลัพธ์อื่น ๆ หากมีข้อผิดพลาด
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'เกิดข้อผิดพลาดในการอัปโหลดรูปภาพ: $error'),
                          ),
                        );
                      }
                    },
                    leading: const Icon(Icons.add_a_photo_rounded),
                    title: const Text('เลือกรูปภาพ'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // if (imageUrl == null ||
                      //     imageUrl.isEmpty ||
                      //     imageUrl.trim() == "") {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(
                      //       content: Text('กรุณาอัปโหลดรูปภาพ'),
                      //     ),
                      //   );
                      //   return;
                      // }

                      final String number = id.text;
                      final String name = title.text;
                      final String text = texts.text;
                      {
                        // ตรวจสอบว่าชื่อไม่ว่างเปล่า
                        await _items
                            .doc(parentDocumentId)
                            .collection('in')
                            .doc(number)
                            .set({
                          "ID": number,
                          "Title": name,
                          "Content": text,
                          'Image': imageUrl,
                        });
                        id.text = '';
                        title.text = '';
                        texts.text = '';
                        imageUrl = "";
                        Navigator.of(context)
                            .pop(); // เมื่อบันทึกสำเร็จให้ปิดหน้าต่างปัจจุบัน
                      }
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
          );
        });
  }

  String search = "";
  TextEditingController searchtexts = TextEditingController();
  void searchtest(value) {
    setState(() {
      search = value.toLowerCase();
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
              return Column(
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          Stack(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: searchtexts,
                                      onChanged: (value) {
                                        EasyDebounce.debounce(
                                            "searchDebounce",
                                            const Duration(milliseconds: 1500),
                                            () => searchtest(value));
                                      },
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10.0, horizontal: 10),
                                        hintText: "ค้นหา...",
                                        suffixIcon: IconButton(
                                          icon: const Icon(Icons.search),
                                          onPressed: () {
                                            searchtexts.clear();
                                            searchtest("");
                                          },
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          borderSide: const BorderSide(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final document = documents[index];
                        final lable1 = document['Lable'] ?? '';
                        final lowercaseSearch = search.toLowerCase();

                        if (!lable1.toLowerCase().contains(lowercaseSearch)) {
                          return const SizedBox.shrink();
                        }

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
                                                builder: (context) =>
                                                    Editarticle(
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
                                                                          17) +
                                                                  '...'
                                                              : lable1,
                                                          style: const TextStyle(
                                                              fontSize: 23,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.all(2),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "ข้อมูลเพิ่มเติม",
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
                                                                await _creates(
                                                                    document);
                                                              },
                                                              child: const Icon(
                                                                Icons
                                                                    .create_new_folder_rounded,
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
                                                                            'ArticleScreen')
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
      // Create new project button
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        backgroundColor: const Color.fromARGB(255, 112, 86, 77),
        child: const Icon(Icons.add),
      ),
    );
  }
}
