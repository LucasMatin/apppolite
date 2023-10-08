// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, sized_box_for_whitespace, non_constant_identifier_names, use_build_context_synchronously, await_only_futures, unused_element, file_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polite/AdminScreen/Add/alert_delete.dart';
// ignore: unused_import
import 'package:polite/Test/testasd.dart';

class Editarticle extends StatefulWidget {
  final DocumentReference documentReference;

  const Editarticle({Key? key, required this.documentReference})
      : super(key: key);

  @override
  State<Editarticle> createState() => _EditarticleState();
}

class _EditarticleState extends State<Editarticle> {
  // ...
  String imageUrl = '';
  List<File> image = [];
  ImagePicker picker = ImagePicker();
  // Add a Stream to listen to the "in" subcollection
  late Stream<QuerySnapshot> inCollectionStream;

  @override
  void initState() {
    super.initState();
    // Initialize the Stream for the "in" subcollection
    inCollectionStream = widget.documentReference.collection('in').snapshots();
  }

  // text field controller
  TextEditingController title = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController texts = TextEditingController();

  final CollectionReference _items =
      FirebaseFirestore.instance.collection('ArticleScreen');

  String searchText = '';
  // for create operation
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
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
                        await _items.doc();
                        widget.documentReference
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
                    child: const Text(
                      "ยืนยัน",
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  // for _update operation
  Future<void> _update(DocumentSnapshot documentSnapshot) async {
    final String initialLabel = documentSnapshot['Title'];
    final String initialUrl = documentSnapshot['ID'];
    final String initialContent = documentSnapshot['Content'];
    final String initialImage = documentSnapshot['Image'];

    title.text = initialLabel;
    id.text = initialUrl;
    texts.text = initialContent;
    imageUrl = initialImage;

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
                      "แก้ไข",
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
                    maxLines: 8,
                    controller: texts,
                    decoration: const InputDecoration(
                        labelText: 'เนื้อหา', hintText: 'กรุณาเนื้อหา'),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  // Display the image if available
                  imageUrl.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Container(
                              width: 200, // Set the desired width
                              height: 150, // Set the desired height

                              child: Image.network(imageUrl),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(
                    height: 5,
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
                          referenceRoot.child('images');

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
                        await documentSnapshot.reference.update({
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
                    child: const Text(
                      "ยืนยัน",
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ...
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
                style: const TextStyle(color: Colors.white, fontSize: 25),
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
                  final lable1 = document['Title'] ?? '';
                  final id = document['ID'] ?? '';
                  final content = document['Content'] ?? '';
                  final Image = document['Image'] ?? '';

                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 12,
                      top: 10,
                    ),
                    child: Card(
                      elevation: 1,
                      child: SizedBox(
                        height: 120,
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
                                      //     builder: (context) => AddImage(
                                      //         documentReference:
                                      //             document.reference),
                                      //     settings: RouteSettings(
                                      //         arguments: document),
                                      //   ),
                                      // );
                                    },
                                    subtitle: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(),
                                          child: Row(
                                            children: [Text("# $id")],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(),
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
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ))
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(),
                                          child: Row(
                                            children: [
                                              Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.6,
                                                  child: Text(
                                                    content.toString().length >
                                                            20
                                                        ? content
                                                                .toString()
                                                                .substring(
                                                                    0, 20) +
                                                            '...'
                                                        : content,
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(),
                                          child: Row(
                                            children: [
                                              Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.6,
                                                  child: Text(
                                                    Image.toString().length > 20
                                                        ? Image.toString()
                                                                .substring(
                                                                    0, 20) +
                                                            '...'
                                                        : Image,
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
                                                                'ArticleScreen')
                                                            .doc();
                                                        widget.documentReference
                                                            .collection("in")
                                                            .doc(document.id)
                                                            .delete()
                                                            .then((value) {})
                                                            .catchError(
                                                                (error) {
                                                          print(error);
                                                        });
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
