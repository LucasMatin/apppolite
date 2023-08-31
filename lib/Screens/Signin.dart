import 'package:polite/Screens/Bottom.dart';
import 'package:polite/Screens/Signup.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
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
                      Text(
                        'บัญชี',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                            hintText: 'อีเมลล์หรือหมายเลขโทรศัพท์'),
                        validator: _emailValidator,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'รหัสผ่าน',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          hintText: 'รหัสผ่าน',
                          suffixIcon: IconButton(
                            icon: Icon(_obscureText
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                        validator: _passwordValidator,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Implement forgot password
                          },
                          child: const Text(
                            'ลืมรหัสผ่าน?',
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
