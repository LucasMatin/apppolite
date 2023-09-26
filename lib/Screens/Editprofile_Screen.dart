import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:polite/Screens/Profile_Screen.dart';

class editscreen extends StatefulWidget {
  @override
  State<editscreen> createState() => _editscreenState();
}

class _editscreenState extends State<editscreen> {
  final formKey = GlobalKey<FormState>();

  final currrenUser = FirebaseAuth.instance.currentUser!;

  final userCollection = FirebaseFirestore.instance.collection('UserID');

  TextEditingController fullname = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController telno = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //     },
        //     icon: Icon(Icons.arrow_back_ios_new_sharp)),
        backgroundColor: Colors.brown[300],
        elevation: 0,
        title: Text(
          'แก้ไขข้อมูลส่วนตัว',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('UserID')
              .doc(currrenUser.uid)
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
              final userData = snapshot.data!.data() as Map<String, dynamic>;

              return SingleChildScrollView(
                child: SafeArea(
                  // padding: const EdgeInsets.all(DefaulitSize),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 300,
                                child: TextFormField(
                                  controller: fullname,
                                  decoration: const InputDecoration(
                                      label: Text('ชื่อ-นามสกุล'),
                                      prefixIcon:
                                          Icon(Icons.account_circle_outlined)),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณาป้อนชื่อ-นามสกุล';
                                    }
                                    return null; // ไม่มีข้อผิดพลาด
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: 300,
                                child: TextFormField(
                                  controller: telno,
                                  decoration: const InputDecoration(
                                      label: Text('เบอร์โทรศัพท์'),
                                      prefixIcon: Icon(Icons.call)),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณาเบอร์โทรศัพท์';
                                    }
                                    return null; // ไม่มีข้อผิดพลาด
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: 300,
                                child: TextFormField(
                                  controller: password,
                                  decoration: const InputDecoration(
                                      label: Text('โรคประจำตัว'),
                                      prefixIcon: Icon(
                                          Icons.accessibility_new_rounded)),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณาโรคประจำตัว';
                                    }
                                    return null; // ไม่มีข้อผิดพลาด
                                  },
                                ),
                              ),
                            ],
                          )),
                      const SizedBox(height: 20),
                      Center(
                        child: SizedBox(
                          width: 350,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                // ถ้าฟอร์มถูกต้อง คุณสามารถดำเนินการต่อไปได้
                                // ดึงข้อมูลที่ป้อนจากฟอร์ม
                                String name = fullname.text;
                                String phone = telno.text;
                                String passwords = password.text;

                                // สร้าง Map ของข้อมูลที่จะอัพเดทใน Firestore
                                Map<String, dynamic> updatedData = {
                                  'Fullname': name,
                                  'Telno': phone,
                                  'Bisease': passwords,
                                  // เพิ่มข้อมูลอื่น ๆ ที่คุณต้องการอัพเดท
                                };

                                try {
                                  // อัพเดทข้อมูลใน Firestore
                                  await userCollection
                                      .doc(currrenUser.uid)
                                      .update(updatedData);

                                  // อัพเดท Password ใน Firebase Authentication
                                  await currrenUser.updatePassword(passwords);

                                  // อัพเดทข้อมูลสำเร็จ
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('อัพเดทข้อมูลสำเร็จ'),
                                    ),
                                  );
                                  Navigator.of(context).pop();
                                } catch (e) {
                                  // การอัพเดทข้อมูลผิดพลาด
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'เกิดข้อผิดพลาดในการอัพเดทข้อมูล: $e'),
                                    ),
                                  );
                                }
                              }
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(const Size(
                                double.infinity,
                                48,
                              )),
                            ),
                            child: const Text('แก้ไขเสร็จสิ้น'),
                          ),
                        ),
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
