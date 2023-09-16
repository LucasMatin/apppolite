//import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:polite/AdminScreen/Login_Admin_Screen.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:polite/Screens/Bottom_Screen.dart';
import 'package:polite/Screens/Register_Screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorMessage = '';

  Future<void> _login() async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // เข้าสู่ระบบสำเร็จ
        String userUid = userCredential.user!.uid;
        // เข้าสู่ระบบสำเร็จ
        // ตรวจสอบว่าผู้ใช้อยู่ใน Collection "UserID" โดยเช็ค UserUid
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('UserID')
            .where('UserUid', isEqualTo: userUid)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          // ถ้ามีผู้ใช้ใน Collection "UserID" ที่ UserUid ตรงกัน
          // ให้นำผู้ใช้ไปหน้าที่ต้องการในกรณีนี้คือ bottomsceen()
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => bottomsceen()),
          );
        } else {
          // ถ้าไม่มี UserUid ที่ตรงกัน
          // ให้แสดงข้อความข้อผิดพลาด
          errorMessage = "ไม่สามารถเข้าสู่ระบบได้";
        }
      }
    } catch (e) {
      // เกิดข้อผิดพลาดในการเข้าสู่ระบบ
      errorMessage = "เบอร์โทรศัพท์หรือรหัสผ่านไม่ถูกต้อง";
    }

    // รีเซ็ตค่าในฟอร์ม
    emailController.text = '';
    passwordController.text = '';

    // อัพเดท UI
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  child: Image.asset("images/logo.png"),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(
                  '"โภชนาการของผู้สูงวัย"',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                ),
                const SizedBox(height: 12),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: emailController, // เพิ่ม controller
                        validator: RequiredValidator(
                          errorText: 'กรุณากรอกอีเมล์',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          hintText: 'อีเมลล์',
                          labelText: 'บัญชี',
                        ),
                      ),
                      const SizedBox(height: 24),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: passwordController, // เพิ่ม controller
                        validator: RequiredValidator(
                          errorText: 'กรุณากรอกรหัสผ่านให้ถูกต้อง',
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'รหัสผ่าน',
                          labelText: 'รหัสผ่าน',
                        ),
                        obscureText: true,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Loginadmin(),
                              ),
                            );
                          },
                          child: const Text(
                            'แอดมิน',
                            style: TextStyle(color: Color(0xFF3D80DE)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _login(); // เรียกใช้งาน _login()
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => bottomsceen()),
                      // );
                    }
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                        const Size(double.infinity, 48)),
                  ),
                  child: const Text('เข้าสู่ระบบ'),
                ),
                const SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    text: "คุณยังไม่ได้ลงทะเบียนใช่หรือไม่? ",
                    style: const TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'ลงทะเบียน',
                        style: const TextStyle(color: Color(0xFF3D80DE)),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Sigup(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
                Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
