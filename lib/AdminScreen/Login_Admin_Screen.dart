import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:polite/AdminScreen/Bottom_Admin_Screen.dart';

class Loginadmin extends StatefulWidget {
  const Loginadmin({super.key});

  @override
  State<Loginadmin> createState() => _LoginadminState();
}

class _LoginadminState extends State<Loginadmin> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auths = FirebaseAuth.instance;

  TextEditingController emails = TextEditingController();
  TextEditingController passwords = TextEditingController();
  String errorMessage = '';

  Future<void> _login() async {
    final String email = emails.text.trim();
    final String password = passwords.text.trim();

    try {
      UserCredential userCredential = await _auths.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        String userUid = userCredential.user!.uid;
        // เข้าสู่ระบบสำเร็จ
        // ตรวจสอบว่าผู้ใช้อยู่ใน Collection "UserID" โดยเช็ค UserUid
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('AdminID')
            .where('UserUid', isEqualTo: userUid)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          // ถ้ามีผู้ใช้ใน Collection "UserID" ที่ UserUid ตรงกัน
          // ให้นำผู้ใช้ไปหน้าที่ต้องการในกรณีนี้คือ bottomsceen()
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => bottomadminsceen()),
          );
        } else {
          // ถ้าไม่มี UserUid ที่ตรงกัน
          // ให้แสดงข้อความข้อผิดพลาด
          errorMessage = "ไม่สามารถเข้าสู่ระบบได้คุณไม่ใช่แอดมิน";
        }
      }
    } catch (e) {
      // เกิดข้อผิดพลาดในการเข้าสู่ระบบ
      errorMessage = "เบอร์โทรศัพท์หรือรหัสผ่านไม่ถูกต้อง";
    }

    // รีเซ็ตค่าในฟอร์ม
    emails.text = '';
    passwords.text = '';

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
                  'ADMIN',
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
                        controller: emails,
                        validator: RequiredValidator(errorText: 'กรุณากรอกID'),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                            hintText: 'บัญชีผู้พัฒนา', labelText: 'บัญชี'),
                      ),
                      const SizedBox(height: 24),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: passwords,
                        validator: RequiredValidator(
                            errorText: 'กรุณากรอกรหัสผ่านให้ถูกต้อง'),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            hintText: 'รหัสผ่าน', labelText: 'รหัสผ่าน'),
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // _login();
                    }
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => bottomadminsceen()),
                    );
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                        const Size(double.infinity, 48)),
                  ),
                  child: const Text('เข้าสู่ระบบ'),
                ),
                const SizedBox(height: 16),
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
