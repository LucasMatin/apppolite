import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:polite/AdminScreen/Add_Eat_Sreen.dart';
import 'package:polite/AdminScreen/alert_delete.dart';
import 'package:polite/LilbraryScreen/Nutrition_Screen.dart';

class Addnutrition extends StatefulWidget {
  const Addnutrition({super.key});

  @override
  State<Addnutrition> createState() => _AddnutritionState();
}

class _AddnutritionState extends State<Addnutrition> {
  final formKey = GlobalKey<FormState>();
  Future<void> sendUserDataToDB() async {
    if (formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('NutritionScreen').add({
        'Lablenutrition': labal.text,
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
                "หน้าแนะนำเกี่ยวกับโภชนาการ",
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
                        child: editbox(labal, "ชื่อโรค", "กรอกชื่อโรค", 1,
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Tablenutrition(),
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
                                builder: (context) => const NutritionSreen(),
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

// แสดง table
class Tablenutrition extends StatefulWidget {
  const Tablenutrition({super.key});

  @override
  State<Tablenutrition> createState() => _TablenutritionState();
}

class _TablenutritionState extends State<Tablenutrition> {
  CollectionReference nutrition =
      FirebaseFirestore.instance.collection("NutritionScreen");
  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    nutrition = FirebaseFirestore.instance.collection("NutritionScreen");
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
          stream: nutrition.snapshots(),
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
                  final lablenutrition = document['Lablenutrition'] ?? '';

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
                                            Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                child: Text(
                                                  lablenutrition
                                                              .toString()
                                                              .length >
                                                          20
                                                      ? lablenutrition
                                                              .toString()
                                                              .substring(
                                                                  0, 20) +
                                                          '...'
                                                      : lablenutrition,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))
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
