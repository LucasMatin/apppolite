//import 'package:firebase_auth/firebase_auth.dart';
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
                        validator: RequiredValidator(
                            errorText: 'กรุณากรอกหมายเลขโทรศัพท์'),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                            hintText: 'หมายเลขโทรศัพท์', labelText: 'บัญชี'),
                      ),
                      const SizedBox(height: 24),
                      const SizedBox(height: 12),
                      TextFormField(
                        validator: RequiredValidator(
                            errorText: 'กรุณากรอกรหัสผ่านให้ถูกต้อง'),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            hintText: 'รหัสผ่าน', labelText: 'รหัสผ่าน'),
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
                    if (_formKey.currentState!.validate()) {}
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const bottomsceen(),
                      ),
                    );
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
