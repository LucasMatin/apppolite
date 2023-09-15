import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
        // บันทึกข้อมูลลงใน Firestore
        await FirebaseFirestore.instance.collection('AdminID').add({
          'Fullname': fullname.text,
          'Password': password.text,
          'Email': email.text,
          'Telno': telno.text,
          'UserAdminID': userid.text,
          'Sex': sex.text,
        });
        // บันทึกสำเร็จ ไปยังหน้า HomeScreen
      } else {
        // แจ้งเตือนว่ามีบัญชีนี้อยู่แล้ว
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('มีบัญชีนี้อยู่แล้ว'),
            duration: Duration(seconds: 2), // แสดงเป็นเวลา 2 วินาที
          ),
        );
      }
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
                    "เช็คแอดมิน",
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
                  child: const Text("ยืนยัน"),
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
        backgroundColor: Colors.brown[300],
        elevation: 0,
        title: Text(
          'ADMIN',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
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
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Center(
                          child: Text(
                            "เพิ่มผู้พัฒนา",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      boxadmin(fullname, 'กรุณาป้อนชื่อนามสกุลด้วย',
                          'ชื่อนามสกุล', 'กรุณากรอกชื่อ-นามสกุล'),
                      const SizedBox(height: 24),
                      boxadmin(userid, 'กรุณาป้อนIDADMIN', 'ผู้พัฒนาID',
                          'กรุณาผู้พัฒนาID'),
                      const SizedBox(height: 24),
                      boxadmin(sex, 'กรุณาป้อนเพศด้วย', 'เพศ', 'กรุณากรอกเพศ'),
                      const SizedBox(height: 24),
                      boxadmin(email, 'กรุณาป้อนอีเมลล์ด้วย', 'อีเมล์',
                          'กรุณากรอกอีเมล์'),
                      const SizedBox(height: 24),
                      boxadmin(telno, 'กรุณาป้อนเบอร์โทรศัพท์ด้วย',
                          'เบอร์โทรศัพท์', 'กรุณากรอกเบอร์โทรศัพท์'),
                      const SizedBox(height: 24),
                      boxadmin(password, 'กรุณาป้อนรหัสผ่านด้วย', 'รหัสผ่าน',
                          'กรุณากรอกรหัสผ่าน'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        sendUserDataToDB(context);
                      }
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          const Size(double.infinity, 48)),
                    ),
                    child: const Text(
                      'เพิ่มผู้พัฒนา',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // Create new project button
      floatingActionButton: FloatingActionButton(
        onPressed: () => _check(),
        backgroundColor: const Color.fromARGB(255, 161, 136, 127),
        child: const Icon(Icons.assignment_turned_in),
      ),
    );
  }
}
