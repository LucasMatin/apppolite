import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:polite/AdminScreen/alert_delete.dart';
import 'package:polite/AdminScreen/test.dart';
import 'package:polite/LilbraryScreen/Eat_Screen%20.dart';

//ส่วนการเพิ่มข้อมูล
class Saveeat extends StatefulWidget {
  const Saveeat({super.key});

  @override
  State<Saveeat> createState() => _SaveeatState();
}

class _SaveeatState extends State<Saveeat> {
  final formKey = GlobalKey<FormState>();
  Future<void> sendUserDataToDB() async {
    if (formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('SaveEatSreen').add({
        'title1': title1.text,
        'title2': title2.text,
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

  TextEditingController title1 = TextEditingController();
  TextEditingController title2 = TextEditingController();
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
                "หน้ากินอย่างไรให้สุขภาพดี",
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
                        child: editbox(title1, "หัวเรื่อง", "หัวเรื่อง", 1,
                            "กรุณากรอกหัวเรื่อง")),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: editbox(title2, "เนื้อหา", "เนื้อหาข้างใน", 15,
                            "กรุณากรอกเนื้อหา")),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TableEatScreen(),
                              ),
                            );
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
                                builder: (context) => const EatScreen(),
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

Widget editbox(controller, hint, labal, num, text) {
  return TextFormField(
    maxLines: num,
    controller: controller,
    validator: RequiredValidator(errorText: text),
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
      hintText: hint,
      labelText: labal,
    ),
  );
}

// ส่วนแสดง table
class TableEatScreen extends StatefulWidget {
  const TableEatScreen({super.key});

  @override
  State<TableEatScreen> createState() => _TableEatScreenState();
}

class _TableEatScreenState extends State<TableEatScreen> {
  CollectionReference eat =
      FirebaseFirestore.instance.collection("SaveEatSreen");
  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    eat = FirebaseFirestore.instance.collection("SaveEatSreen");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        elevation: 0,
        title: Text(
          'จัดการแก้ไข',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: eat.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              final documents = snapshot.data!.docs;
              if (documents.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('ยังไม่มีข้อมูล')],
                  ),
                );
              }
              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final document = documents[index];
                  final t1 = document['title1'] ?? '';
                  final t2 = document["title2"] ?? '';

                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 12,
                      top: 10,
                    ),
                    child: Card(
                      elevation: 2,
                      child: SizedBox(
                        height: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  ListTile(
                                    isThreeLine: false,
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         const Editeatsreeen(),
                                      //   ),
                                      // );
                                    },
                                    subtitle: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(t1),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                child: Text(
                                                    t2.toString().length > 20
                                                        ? t2
                                                                .toString()
                                                                .substring(
                                                                    0, 20) +
                                                            '...'
                                                        : t2))
                                          ],
                                        ),
                                      ],
                                    ),
                                    trailing: SizedBox(
                                      width: 40,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                              //TO DO DELETE
                                              onTap: () async {
                                                final action = await AlertDialogs
                                                    .yesorCancel(context, 'ลบ',
                                                        'คุณต้องการลบข้อมูลนี้หรือไม่');
                                                if (action ==
                                                    DialogsAction.yes) {
                                                  setState(() {
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            'SaveEatSreen')
                                                        .doc(document.id)
                                                        .delete()
                                                        .then((_) {})
                                                        .catchError((error) {});
                                                  });
                                                }
                                              },
                                              child: const Icon(Icons.delete)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Text("ไม่มีข้อมูล");
          }),
    );
  }
}
