// ignore_for_file: file_names, use_build_context_synchronously, duplicate_ignore, avoid_print, unused_element, deprecated_member_use, library_private_types_in_public_api, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:polite/AdminScreen/Admin_Screen.dart';

import 'package:polite/Screens/wiget.dart';

class Addadminscreen extends StatefulWidget {
  const Addadminscreen({super.key});

  @override
  State<Addadminscreen> createState() => _AddadminscreenState();
}

class _AddadminscreenState extends State<Addadminscreen> {
  final formKey = GlobalKey<FormState>();
  Future<void> sendUserDataToDB(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      // ตรวจสอบว่าอีเมลหรือหมายเลขโทรศัพท์ไม่ซ้ำกันใน Firestore
      bool isEmailUnique = await isEmailUniqueInFirestore(email.text);
      bool isTelnoUnique = await isTelnoUniqueInFirestore(telno.text);

      if (isEmailUnique && isTelnoUnique) {
        try {
          // สร้างบัญชีผู้ใช้ใน Firebase Authentication
          UserCredential userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email.text,
            password: password.text,
          );
          // รับ User UID จาก Authentication
          String userUid = userCredential.user!.uid;
          String image =
              "https://firebasestorage.googleapis.com/v0/b/apppolite.appspot.com/o/images%2Fpeople-icon-vector-person-sing-250nw-707883430.webp?alt=media&token=a042325b-d34d-4e85-a86d-fb82f4e00700";

          // บันทึกข้อมูลลงใน Firestore
          await FirebaseFirestore.instance
              .collection('AdminID')
              .doc(userUid)
              .set({
            'Fullname': fullname.text,
            'Password': password.text,
            'Email': email.text,
            'Telno': telno.text,
            'Sex': sex.text,
            'UserUid': userUid, // เพิ่ม User UID ลงใน Firestore
            'Image': image, // เพิ่ม Image ลงใน Firestore
          });
          fullname.text = '';
          password.text = '';
          email.text = '';
          telno.text = '';
          sex.text = '';

          // ignore: avoid_print
          print("บันทึกสำเร็จ");
        } catch (e) {
          // ignore: avoid_print
          print("Error creating user: $e");
          // แจ้งเตือนว่ามีข้อผิดพลาดในการสร้างบัญชีผู้ใช้
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            // ignore: prefer_const_constructors
            SnackBar(
              // ignore: prefer_const_constructors
              content: Text('มีข้อผิดพลาดในการสร้างบัญชีผู้ใช้'),
              // ignore: prefer_const_constructors
              duration: Duration(seconds: 2), // แสดงเป็นเวลา 2 วินาที
            ),
          );
        }
      } else {
        // แจ้งเตือนว่ามีบัญชีนี้อยู่แล้ว
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('มีบัญชีนี้อยู่แล้ว'),
            duration: Duration(seconds: 2), // แสดงเป็นเวลา 2 วินาที
          ),
        );
      }
    } else {
      // แจ้งเตือนว่าข้อมูลไม่ครบ
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('กรุณากรอกข้อมูลให้ครบ'),
          duration: Duration(seconds: 2), // แสดงเป็นเวลา 2 วินาที
        ),
      );
    }
  }

  Future<bool> isEmailUniqueInFirestore(String email) async {
    try {
      QuerySnapshot query = await FirebaseFirestore.instance
          .collection('AdminID')
          .where('Email', isEqualTo: email)
          .get();

      return query.docs.isEmpty; // ถ้าไม่มีเอกสารในคำขอ แสดงว่าอีเมลไม่ซ้ำกัน
    } catch (e) {
      print('Error: $e');
      return false; // เกิดข้อผิดพลาดในการตรวจสอบ
    }
  }

  Future<bool> isTelnoUniqueInFirestore(String telno) async {
    try {
      QuerySnapshot query = await FirebaseFirestore.instance
          .collection('AdminID')
          .where('Telno', isEqualTo: telno)
          .get();

      return query
          .docs.isEmpty; // ถ้าไม่มีเอกสารในคำขอ แสดงว่าหมายเลขโทรศัพท์ไม่ซ้ำกัน
    } catch (e) {
      print('Error: $e');
      return false; // เกิดข้อผิดพลาดในการตรวจสอบ
    }
  }

  TextEditingController fullname = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController telno = TextEditingController();
  TextEditingController userid = TextEditingController();
  TextEditingController sex = TextEditingController();

  // checkadmin
  Future<void> _check([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
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
                    "เช็คผู้ดูแลระบบ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Adminuser(),
                      ),
                    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 112, 86, 77),
        elevation: 0,
        title: const Text(
          'ADMIN',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(2),
                        child: Center(
                          child: Text(
                            "เพิ่มผู้ดูแลระบบ",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      boxadmin(fullname, 'กรุณาป้อนชื่อนามสกุลด้วย',
                          'ชื่อนามสกุล', 'กรุณากรอกชื่อ-นามสกุล'),
                      const SizedBox(height: 24),
                      SexDropdownFormField(
                        controller: sex,
                      ),
                      // boxadmin(sex, 'กรุณาป้อนเพศด้วย', 'เพศ', 'กรุณากรอกเพศ'),
                      const SizedBox(height: 24),
                      boxadmin(email, 'กรุณาป้อนอีเมลล์ด้วย', 'อีเมล',
                          'กรุณากรอกอีเมล์'),
                      const SizedBox(height: 24),
                      telnotboxs(telno, 'กรุณาป้อนเบอร์โทรศัพท์ด้วย',
                          'เบอร์โทรศัพท์', 'กรุณากรอกเบอร์โทรศัพท์'),
                      const SizedBox(height: 24),
                      boxadmin(password, 'กรุณาป้อนรหัสผ่านด้วย', 'รหัสผ่าน',
                          'กรุณากรอกรหัสผ่าน'),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: 250,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        sendUserDataToDB(context);
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 86, 167, 89)),
                      minimumSize: MaterialStateProperty.all(
                          const Size(double.infinity, 48)),
                    ),
                    child: const Text(
                      'เพิ่มผู้ดูแลระบบ',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // // Create new project button
      floatingActionButton: FloatingActionButton(
        onPressed: () => _check(),
        backgroundColor: const Color.fromARGB(255, 112, 86, 77),
        child: const Icon(Icons.assignment_turned_in),
      ),
    );
  }
}

class SexDropdownFormField extends StatefulWidget {
  final TextEditingController controller;

  const SexDropdownFormField({super.key, required this.controller});

  @override
  _SexDropdownFormFieldState createState() => _SexDropdownFormFieldState();
}

class _SexDropdownFormFieldState extends State<SexDropdownFormField> {
  String selectedGender = 'ชาย'; // ค่าเริ่มต้น

  @override
  void initState() {
    super.initState();
    widget.controller.text = selectedGender;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        child: DropdownButtonFormField<String>(
          value: selectedGender,
          onChanged: (newValue) {
            setState(() {
              selectedGender = newValue!;
              widget.controller.text = newValue;
            });
          },
          decoration: const InputDecoration(
            labelText: 'เพศ',
          ),
          items: <String>['ชาย', 'หญิง'].map((String gender) {
            return DropdownMenuItem<String>(
              value: gender,
              child: Text(gender),
            );
          }).toList(),
        ),
      ),
    );
  }
}

Widget telnotboxs(
  controller,
  String text,
  String labal,
  String hint,
) {
  return Center(
    child: Container(
      width: 300,
      child: TextFormField(
        controller: controller,
        validator: RequiredValidator(errorText: text),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        maxLength: 10,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText: hint,
          labelText: labal,
        ),
      ),
    ),
  );
}
