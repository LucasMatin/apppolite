import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:polite/Screens/wiget.dart';
import '../model/Profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Sigup extends StatefulWidget {
  const Sigup({super.key});

  @override
  State<Sigup> createState() => _Sigup();
}

class _Sigup extends State<Sigup> {
  CollectionReference user = FirebaseFirestore.instance.collection("UserID");
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  TextEditingController _dateController = TextEditingController();
  final DateFormat _dateFormat =
      DateFormat('dd-MM-yyyy'); // รูปแบบวันที่ที่ต้องการ

  Future<void> sendUserDataToDB(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('UserID').add({
        'fname': fname.text,
        'pass': pass.text,
        'okpass': okpass.text,
        'telno': telno.text,
        'email': email.text,
        'datatime': _dateController.text,
        'sex': sex.text,
      });

      // บันทึกสำเร็จ ไปยังหน้า HomeScreen
      Navigator.pop(context);
    } else {
      // แจ้งเตือนว่าข้อมูลไม่ครบ
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('กรุณากรอกข้อมูลให้ครบ'),
          duration: Duration(seconds: 2), // แสดงเป็นเวลา 2 วินาที
        ),
      );
    }
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    user = FirebaseFirestore.instance.collection("UserID");
  }

  TextEditingController fname = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController okpass = TextEditingController();
  TextEditingController telno = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController sex = TextEditingController();

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
                      textbox(fname, 'erorrtext', 'ชื่อนามสกุล',
                          'กรุณากรอกชื่อ-นามสกุล'),
                      const SizedBox(height: 24),
                      textbox(
                          pass, 'erorrtext', 'รหัสผ่าน', 'กรุณากรอกรหัสผ่าน'),
                      const SizedBox(height: 24),
                      textbox(okpass, 'erorrtext', 'ยืนยันรหัสผ่าน',
                          'กรุณากรอกยืนยันรหัสผ่าน'),
                      const SizedBox(height: 24),
                      textbox(telno, 'erorrtext', 'เบอร์โทรศัพท์',
                          'กรุณากรอกเบอร์โทรศัพท์'),
                      const SizedBox(height: 24),
                      textbox(
                          email, 'erorrtext', 'อีเมลล์', 'กรุณากรอกอีเมลล์'),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _dateController,
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
                            _dateController.text =
                                _dateFormat.format(selectedDate);
                          }
                        },
                        readOnly: true,
                        decoration: const InputDecoration(
                            hintText: 'กรอกวันที่ (dd-mm-yyyy)',
                            labelText: 'วัน เดือน ปีเกิด'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                ElevatedButton(
                  onPressed: () {
                    sendUserDataToDB(context);
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
