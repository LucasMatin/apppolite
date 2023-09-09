import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:polite/Screens/wiget.dart';
import '../ModelCalss/Profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Sigup extends StatefulWidget {
  const Sigup({super.key});

  @override
  State<Sigup> createState() => _Sigup();
}

class _Sigup extends State<Sigup> {
  final formKey = GlobalKey<FormState>();
  final DateFormat _dateFormat =
      DateFormat('dd-MM-yyyy'); // รูปแบบวันที่ที่ต้องการ

  // Future<void> sendUserDataToDB(BuildContext context) async {
  //   if (formKey.currentState!.validate()) {
  //     await FirebaseFirestore.instance.collection('UserID').add({
  //       'fname': fname.text,
  //       'pass': pass.text,
  //       'okpass': okpass.text,
  //       'telno': telno.text,
  //       'email': email.text,
  //       'datatime': _dateController.text,
  //       'sex': sex.text,
  //     });
  //     // บันทึกสำเร็จ ไปยังหน้า HomeScreen
  //     Navigator.pop(context);
  //   } else {
  //     // แจ้งเตือนว่าข้อมูลไม่ครบ
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('กรุณากรอกข้อมูลให้ครบ'),
  //         duration: Duration(seconds: 2), // แสดงเป็นเวลา 2 วินาที
  //       ),
  //     );
  //   }
  // }

  TextEditingController fullname = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController telno = TextEditingController();
  TextEditingController birthday = TextEditingController();
  TextEditingController bisease = TextEditingController();
  TextEditingController sex = TextEditingController();

  // Future sig_up() async {
  //   String url = "http://127.0.0.1/api/register.php";
  //   final respone = await http.post(Uri.parse(url), body: {
  //     'fullname': fullname.text,
  //     'password': password.text,
  //     'email': email.text,
  //     'telno': telno.text,
  //     'birthday': birthday.text,
  //     'bisease': bisease.text,
  //     'sex': sex.text,
  //   });
  //   print(respone.statusCode);
  //   var data = json.decode(respone.body);
  //   if (data == "error") {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const Sigup(),
  //       ),
  //     );
  //   } else {
  //     Navigator.of(context).pop();
  //   }
  // }
  // Future testapi() async {
  //   String url = "https://jsonplaceholder.typicode.com/posts";
  //   final respone = await http.get(Uri.parse(url));
  //   print(respone.statusCode);
  // }

  Future<void> _selectDateFromPicker(BuildContext context, value) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 10),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null) {
      setState(() {
        value.text = "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        elevation: 0,
        title: Text(
          'ลงทะเบียน',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context); // Returns to the previous page
          },
        ),
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
                      textbox(fullname, 'erorrtext', 'ชื่อนามสกุล',
                          'กรุณากรอกชื่อ-นามสกุล'),
                      const SizedBox(height: 24),
                      textbox(sex, 'erorrtext', 'เพศ', 'กรุณากรอกเพศ'),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: birthday,
                        validator: RequiredValidator(
                            errorText: "กรุณาป้อนอีเมลล์ด้วย"),
                        onTap: () async {
                          DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2101),
                          );

                          if (selectedDate != null) {
                            birthday.text = _dateFormat.format(selectedDate);
                          }
                        },
                        readOnly: true,
                        decoration: const InputDecoration(
                            hintText: 'กรอกวันที่ (dd-mm-yyyy)',
                            labelText: 'วัน เดือน ปีเกิด'),
                      ),
                      const SizedBox(height: 24),
                      textbox(
                          email, 'erorrtext', 'อีเมลล์', 'กรุณากรอกอีเมลล์'),
                      const SizedBox(height: 24),
                      textbox(bisease, 'erorrtext', 'โรคประจำตัว',
                          'กรุณากรอกโรคประจำตัว'),
                      const SizedBox(height: 24),
                      textbox(telno, 'erorrtext', 'เบอร์โทรศัพท์',
                          'กรุณากรอกเบอร์โทรศัพท์'),
                      const SizedBox(height: 24),
                      textbox(password, 'erorrtext', 'รหัสผ่าน',
                          'กรุณากรอกรหัสผ่าน'),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                ElevatedButton(
                  onPressed: () {
                    // sig_up();
                    // testapi();
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                        const Size(double.infinity, 48)),
                  ),
                  child: const Text('ลงทะเบียนเสร็จสิ้น'),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
