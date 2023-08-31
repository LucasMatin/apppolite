import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../model/Profile.dart';

class Sigup extends StatefulWidget {
  const Sigup({super.key});

  @override
  State<Sigup> createState() => _Sigup();
}

class _Sigup extends State<Sigup> {
  final _formKey = GlobalKey<FormState>();
  final bool _obscureText = true;
  Profile profile = Profile();

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
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ชื่อ-นามสกุล',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        validator: RequiredValidator(
                            errorText: "กรุณาป้อนชื่อ-นามสกุลด้วย"),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration:
                            const InputDecoration(hintText: 'ชื่อ-นามสกุล'),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'รหัสผ่าน',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        validator:
                            RequiredValidator(errorText: "กรุณาป้อนรหัสด้วย"),
                        obscureText: _obscureText,
                        decoration: const InputDecoration(
                          hintText: 'รหัสผ่าน',
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'รหัสผ่านอีกครั้ง',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        validator: RequiredValidator(
                            errorText: "กรุณาป้อนรหัสอีกครั้งด้วย"),
                        obscureText: _obscureText,
                        decoration: const InputDecoration(
                          hintText: 'รหัสผ่านอีกครั้ง',
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'หมายเลขโทรศัพท์',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        validator: RequiredValidator(
                            errorText: "กรุณาป้อนหมายเลขโทรศัพท์ด้วย"),
                        obscureText: _obscureText,
                        decoration: const InputDecoration(
                          hintText: 'หมายเลขโทรศัพท์',
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'อีเมลล์',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        validator: RequiredValidator(
                            errorText: "กรุณาป้อนอีเมลล์ด้วย"),
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'อีเมลล์',
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'วันเกิด',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        validator: RequiredValidator(
                            errorText: "กรุณาป้อนอีเมลล์ด้วย"),
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'วันเกิด',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                ElevatedButton(
                  onPressed: () {},
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
