// ignore: file_names
// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, avoid_print, use_build_context_synchronously, unused_element, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:polite/Screens/Login_Screen.dart';

import 'package:polite/Screens/wiget.dart';

class Sigup extends StatefulWidget {
  const Sigup({super.key});

  @override
  State<Sigup> createState() => _Sigup();
}

class _Sigup extends State<Sigup> {
  final formKey = GlobalKey<FormState>();

  final DateFormat _dateFormat =
      DateFormat('dd-MM-yyyy'); // รูปแบบวันที่ที่ต้องการ

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
              .collection('UserID')
              .doc(userUid)
              .set({
            'Fullname': fullname.text,
            'Password': password.text,
            'Email': email.text,
            'Telno': telno.text,
            'Birthday': birthday.text,
            'Bisease': bisease.text,
            'Sex': sex.text,
            'UserUid': userUid, // เพิ่ม User UID ลงใน Firestore
            'Image': image, // เพิ่ม Image ลงใน Firestore
          });

          print("บันทึกสำเร็จ");
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
          );
        } catch (e) {
          print("Error creating user: $e");
          // แจ้งเตือนว่ามีข้อผิดพลาดในการสร้างบัญชีผู้ใช้
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('มีข้อผิดพลาดในการสร้างบัญชีผู้ใช้'),
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
          .collection('UserID')
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
          .collection('UserID')
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
  TextEditingController birthday = TextEditingController();
  TextEditingController bisease = TextEditingController();
  TextEditingController sex = TextEditingController();

  @override
  void dispose() {
    fullname.dispose();
    password.dispose();
    email.dispose();
    telno.dispose();
    birthday.dispose();
    bisease.dispose();
    sex.dispose();
    super.dispose();
  }

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
        backgroundColor: const Color.fromARGB(255, 112, 86, 77),
        elevation: 0,
        title: const Text(
          'ลงทะเบียน',
          style: TextStyle(color: Colors.white, fontSize: 26),
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
                      textbox(fullname, 'กรุณาป้อนชื่อนามสกุลด้วย',
                          'ชื่อนามสกุล', 'กรุณากรอกชื่อ-นามสกุล'),
                      const SizedBox(height: 24),
                      // textbox(sex, 'กรุณาป้อนเพศด้วย', 'เพศ', 'กรุณากรอกเพศ'),
                      SexDropdownFormField(controller: sex),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: birthday,
                        validator: RequiredValidator(
                            errorText: "กรุณาป้อนวัน เดือน ปีเกิดด้วย"),
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
                      textbox(email, 'กรุณาป้อนอีเมลด้วย', 'อีเมล',
                          'กรุณากรอกอีเมล'),
                      const SizedBox(height: 24),
                      DiseaseDropdownFormField(
                        controller: bisease,
                      ),
                      // textbox(bisease, 'กรุณาป้อนโรคประจำตัวด้วย',
                      //     'โรคประจำตัว', 'กรุณากรอกโรคประจำตัว'),
                      const SizedBox(height: 24),
                      telnotbox(telno, 'กรุณาป้อนเบอร์โทรศัพท์ด้วย',
                          'เบอร์โทรศัพท์', 'กรุณากรอกเบอร์โทรศัพท์'),
                      const SizedBox(height: 24),
                      passbox(
                        password,
                        'กรุณาป้อนรหัสผ่านด้วย',
                        'รหัสผ่าน',
                        'กรุณากรอกรหัสผ่าน',
                      ),
                    ],
                  ),
                ),
                // Padding(padding: const EdgeInsets.all(1),
                // child: Center(
                //   child: Text("หมายเหตุ: ใส่ข้อมูลของท่านให้"),
                // ),),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      sendUserDataToDB(context);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 86, 167, 89),
                    ),
                    minimumSize: MaterialStateProperty.all(
                        const Size(double.infinity, 48)),
                  ),
                  child: const Text(
                    'ลงทะเบียน',
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
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
    return DropdownButtonFormField<String>(
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
    );
  }
}

class DiseaseDropdownFormField extends StatefulWidget {
  final TextEditingController controller;

  const DiseaseDropdownFormField({Key? key, required this.controller})
      : super(key: key);

  @override
  _DiseaseDropdownFormFieldState createState() =>
      _DiseaseDropdownFormFieldState();
}

class _DiseaseDropdownFormFieldState extends State<DiseaseDropdownFormField> {
  String selectedDisease = 'ไม่มีโรคประจำตัว'; // Default value

  @override
  void initState() {
    super.initState();
    widget.controller.text = selectedDisease;

    // Set selectedDisease to the first item in the list (if available)
    getDiseases().then((diseases) {
      if (diseases.isNotEmpty) {
        setState(() {
          selectedDisease = diseases[0];
          widget.controller.text = selectedDisease;
        });
      }
    });
  }

  Future<List<String>> getDiseases() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('NutritionScreen').get();

      List<String> diseases = querySnapshot.docs
          .map((document) => document['Lable'].toString())
          .toList();

      print(
          'Diseases from Firestore: $diseases'); // Add this line for debugging

      // Add "ไม่มีโรคประจำตัว" to the list
      diseases.insert(0, 'ไม่มีโรคประจำตัว');

      return diseases;
    } catch (error) {
      // Handle errors as needed
      print('Error fetching diseases: $error');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: getDiseases(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No data available');
        } else {
          List<String> diseases = snapshot.data!;

          print(
              'Selected Disease: $selectedDisease'); // Add this line for debugging

          return DropdownButtonFormField<String>(
            value: selectedDisease,
            onChanged: (newValue) {
              setState(() {
                selectedDisease = newValue!;
                widget.controller.text = newValue;
              });
            },
            items: diseases
                .map((String disease) => DropdownMenuItem<String>(
                      value: disease,
                      child: Text(disease),
                    ))
                .toList(),
            decoration: const InputDecoration(
              labelText: 'โรคประจำตัว',
            ),
          );
        }
      },
    );
  }
}
