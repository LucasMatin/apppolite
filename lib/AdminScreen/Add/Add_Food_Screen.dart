// ignore_for_file: prefer_interpolation_to_compose_strings, sized_box_for_whitespace, use_build_context_synchronously, avoid_print, unused_element, file_names, unused_local_variable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:polite/AdminScreen/Add/alert_delete.dart';

class Addfood extends StatefulWidget {
  const Addfood({super.key});

  @override
  State<Addfood> createState() => _AddfoodState();
}

class _AddfoodState extends State<Addfood> {
  String imageUrl = '';
  List<File> image = [];
  ImagePicker picker = ImagePicker();
  // text field controller
  TextEditingController labal = TextEditingController();
  TextEditingController callory = TextEditingController();
  TextEditingController unit = TextEditingController();

  CollectionReference _items = FirebaseFirestore.instance.collection('Food');

  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    _items = FirebaseFirestore.instance.collection("Food");
  }

  String selectedCategory = 'อาหาร'; // ค่าเริ่มต้น
  String selectedFood = ''; // ค่าเริ่มต้น
  String searchText = '';

  Future<List<MultiSelectItem>> getDiseases() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('NutritionScreen').get();

      List<MultiSelectItem> diseases = querySnapshot.docs.map((document) {
        return MultiSelectItem(document.id, document['Lable']);
      }).toList();

      return diseases;
    } catch (error) {
      // จัดการเรื่องข้อผิดพลาดได้ตามความเหมาะสม
      print('Error fetching diseases: $error');
      return [];
    }
  }

  // for create operation
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    List<MultiSelectItem> diseases = await getDiseases();
    List<String> selectedDiseases = [];
    List<String> selectedDiseases2 = [];
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
                      "เพิ่มอาหาร",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: labal,
                    decoration: const InputDecoration(
                        labelText: 'ชื่ออาหาร', hintText: 'อาหาร'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: callory,
                    decoration: const InputDecoration(
                        labelText: 'จำนวนแคลอรี่', hintText: 'แคลอรี่'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: unit,
                    decoration: const InputDecoration(
                        labelText: 'หน่วย', hintText: 'หน่วย'),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          value: selectedCategory,
                          onChanged: (newValue) {
                            // เมื่อผู้ใช้เลือกประเภทใหม่
                            setState(() {
                              selectedCategory = newValue!;
                            });
                          },
                          items: <String>[
                            'อาหาร',
                            'เครื่องดื่ม',
                            'ขนมของหวาน',
                            'ผลไม้'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      const Text(
                        "/",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          value: selectedFood,
                          onChanged: (newValue) {
                            // เมื่อผู้ใช้เลือกประเภทใหม่
                            setState(() {
                              selectedFood = newValue!;
                            });
                          },
                          items: <String>[
                            '',
                            'อาหารประเภทผัด',
                            'อาหารประเภททอด',
                            'อาหารประเภทย่าง',
                            'อาหารประเภทต้ม/นึง',
                            'อาหารประเภทแกง',
                            'อาหารประเภทซุป',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MultiSelectDialogField(
                      items: diseases,
                      initialValue: selectedDiseases,
                      onConfirm: (values) {
                        setState(() {
                          selectedDiseases = List<String>.from(values);
                        });
                      },
                      title: const Text('แนะนำสำหรับโรค'),
                      buttonText: const Text(
                        'แนะนำสำหรับโรค',
                        style: TextStyle(color: Colors.green, fontSize: 18),
                      ), // เปลี่ยนชื่อ buttonText ที่นี่
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MultiSelectDialogField(
                      items: diseases,
                      initialValue: selectedDiseases2,
                      onConfirm: (values) {
                        setState(() {
                          selectedDiseases2 = List<String>.from(values);
                        });
                      },
                      title: const Text('ไม่แนะนำสำหรับโรค'),
                      buttonText: const Text(
                        'ไม่แนะนำสำหรับโรค',
                        style: TextStyle(color: Colors.red, fontSize: 18),
                      ), // เปลี่ยนชื่อ buttonText ที่นี่
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                          referenceRoot.child('Food');

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
                      final String name = labal.text;
                      final String callorys = callory.text;
                      final String units = unit.text;
                      if (name.isNotEmpty) {
                        // ตรวจสอบว่าชื่อไม่ว่างเปล่า
                        await _items.doc(name).set({
                          "Lable": name,
                          "Callory": callorys,
                          "Unit": units,
                          "Foodtype": selectedFood,
                          "Category":
                              selectedCategory, // เพิ่มค่าประเภทที่ผู้ใช้เลือก
                          'Image': imageUrl,
                          'Diseases':
                              selectedDiseases, // เพิ่มค่าโรคที่เกี่ยวข้อง
                          'NoDiseases':
                              selectedDiseases2, // เพิ่มค่าโรคที่เกี่ยวข้อง
                        });
                        labal.text = '';
                        callory.text = '';
                        unit.text = '';
                        imageUrl = "";
                        selectedDiseases = []; // รีเซ็ตค่าโรคที่เกี่ยวข้อง
                        selectedDiseases2 = []; // รีเซ็ตค่าโรคที่เกี่ยวข้อง
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
    List<MultiSelectItem> diseases = await getDiseases();
    List<String> updatedDiseases = [];
    List<String> updatedDiseases2 = [];
    final String initialLabel = documentSnapshot['Lable'];
    final String initialCallory = documentSnapshot['Callory'];
    final String initialCategory = documentSnapshot['Category'];
    final String initialFoodtype = documentSnapshot['Foodtype'];
    final String initialImage = documentSnapshot['Image'];
    final String initialUnit = documentSnapshot['Unit'];
    final List<String> initialDiseases =
        List<String>.from(documentSnapshot['Diseases'] ?? []);
    final List<String> initialDiseasess =
        List<String>.from(documentSnapshot['NoDiseases'] ?? []);

    labal.text = initialLabel;
    callory.text = initialCallory;
    selectedCategory = initialCategory;
    selectedFood = initialFoodtype;
    imageUrl = initialImage;
    unit.text = initialUnit;
    updatedDiseases = initialDiseases;
    updatedDiseases2 = initialDiseasess;

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
                    height: 20,
                  ),
                  TextField(
                    controller: labal,
                    decoration: const InputDecoration(
                        labelText: 'ชื่ออาหาร', hintText: 'อาหาร'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: callory,
                    decoration: const InputDecoration(
                        labelText: 'จำนวนแคลอรี่', hintText: 'แคลอรี่'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: unit,
                    decoration: const InputDecoration(
                        labelText: 'หน่วย', hintText: 'หน่วย'),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          value: selectedCategory,
                          onChanged: (newValue) {
                            // เมื่อผู้ใช้เลือกประเภทใหม่
                            setState(() {
                              selectedCategory = newValue!;
                            });
                          },
                          items: <String>[
                            'อาหาร',
                            'เครื่องดื่ม',
                            'ขนมของหวาน',
                            'ผลไม้'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      const Text(
                        "/",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          value: selectedFood,
                          onChanged: (newValue) {
                            // เมื่อผู้ใช้เลือกประเภทใหม่
                            setState(() {
                              selectedFood = newValue!;
                            });
                          },
                          items: <String>[
                            '',
                            'อาหารประเภทผัด',
                            'อาหารประเภททอด',
                            'อาหารประเภทย่าง',
                            'อาหารประเภทต้ม/นึง',
                            'อาหารประเภทแกง',
                            'อาหารประเภทซุป',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MultiSelectDialogField(
                      items: diseases,
                      initialValue: updatedDiseases,
                      onConfirm: (values) {
                        // Handle the selected values
                        setState(() {
                          updatedDiseases = List<String>.from(values);
                        });
                      },
                      title: const Text('แนะนำสำหรับโรค'),
                      buttonText: const Text(
                        'แนะนำสำหรับโรค',
                        style: TextStyle(color: Colors.green, fontSize: 18),
                      ), // เปลี่ยนชื่อ buttonText ที่นี่
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MultiSelectDialogField(
                      items: diseases,
                      initialValue: updatedDiseases2,
                      onConfirm: (values) {
                        // Handle the selected values
                        setState(() {
                          updatedDiseases2 = List<String>.from(values);
                        });
                      },
                      title: const Text('ไม่แนะนำสำหรับโรค'),
                      buttonText: const Text(
                        'ไม่แนะนำสำหรับโรค',
                        style: TextStyle(color: Colors.red, fontSize: 18),
                      ), // เปลี่ยนชื่อ buttonText ที่นี่
                    ),
                  ),

                  // Display the image if available
                  imageUrl.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Container(
                              width: 200, // Set the desired width
                              height: 120, // Set the desired height

                              child: Image.network(imageUrl),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
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
                          referenceRoot.child('Food');

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
                  ElevatedButton(
                    onPressed: () async {
                      final String name = labal.text;
                      final String callorys = callory.text;
                      if (name.isNotEmpty) {
                        // ตรวจสอบว่าชื่อไม่ว่างเปล่า
                        await documentSnapshot.reference.update({
                          "Lable": name,
                          "Callory": callorys,
                          "Foodtype": selectedFood,
                          "Category":
                              selectedCategory, // เพิ่มค่าประเภทที่ผู้ใช้เลือก
                          'Image': imageUrl,
                          'Diseases': updatedDiseases,
                          'NoDiseases': updatedDiseases2,
                        });
                        labal.text = '';
                        callory.text = '';
                        imageUrl = "";
                        updatedDiseases = [];
                        updatedDiseases2 = [];
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
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 112, 86, 77),
        elevation: 0,
        title: const Text(
          'ข้อมูลอาหาร',
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
                  final callory = document['Callory'] ?? '';
                  final id = document['Category'] ?? '';
                  final key = document['Foodtype'] ?? '';
                  final image = document['Image'] ?? '';
                  final units = document['Unit'] ?? '';
                  final diseases = document['Diseases'] ?? [];
                  final diseasess = document['NoDiseases'] ?? [];

                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 12,
                      top: 10,
                    ),
                    child: Card(
                      elevation: 1,
                      child: SizedBox(
                        height: 110,
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
                                      //     builder: (context) => AddFood2(
                                      //         documentReference:
                                      //             document.reference),
                                      //     settings: RouteSettings(
                                      //         arguments: document),
                                      //   ),
                                      // );
                                    },
                                    subtitle: Stack(
                                      children: [
                                        Column(
                                          children: [
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
                                                        lable1
                                                                    .toString()
                                                                    .length >
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
                                                                FontWeight
                                                                    .bold),
                                                      ))
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "$callory แคลลอรี่",
                                                    style: const TextStyle(
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "$id:$key",
                                                    style: const TextStyle(
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Padding(
                                            //   padding: const EdgeInsets.only(),
                                            //   child: Row(
                                            //     children: [
                                            //       Text(
                                            //         "Diseases: ${diseases.join(', ')}",
                                            //         style: const TextStyle(
                                            //             fontSize: 16),
                                            //       ),
                                            //     ],
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              width: 95.0,
                                              height: 75.0,
                                              child: Card(
                                                color: const Color.fromARGB(
                                                    255, 237, 230, 224),
                                                elevation: 2.0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(3),
                                                  child: Visibility(
                                                    visible: image !=
                                                        null, // กำหนดให้แสดงเมื่อ image ไม่เท่ากับ null
                                                    child: Image.network(
                                                      image!,
                                                      width: 70,
                                                      height: 50,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    trailing: SizedBox(
                                      width: 30,
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
                                                            .collection('Food')
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
