import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:polite/AdminScreen/Add_Eat_Sreen.dart';
import 'package:polite/LilbraryScreen/Video_Screen.dart';

class Addvideo extends StatefulWidget {
  const Addvideo({super.key});

  @override
  State<Addvideo> createState() => _AddvideoState();
}

class _AddvideoState extends State<Addvideo> {
  final formKey = GlobalKey<FormState>();
  Future<void> sendUserDataToDB() async {
    if (formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('ArticleScreen').add({
        'Labal': labal.text,
      });
      // บันทึกสำเร็จ ไปยังหน้า HomeScreen
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

  void _resetForm() {
    formKey.currentState?.reset();
  }

  TextEditingController labal = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        elevation: 0,
        title: Text(
          'เพิ่มข้อมูล',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                "หน้าวิดีโอเพื่อสุขภาพ",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: editbox(labal, "หัวเรื่อง", "หัวเรื่อง", 1,
                            "กรุณากรอกหัวเรื่อง")),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              sendUserDataToDB();
                              formKey.currentState!.reset();
                            }
                          },
                          child: Text("บันทึก")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const TableArticle(),
                            //   ),
                            // );
                          },
                          child: Text("เช็ค")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => videoscreen(),
                              ),
                            );
                          },
                          child: Text("ตรวจสอบ")),
                    )
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
