import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:polite/AdminScreen/Add/alert_delete.dart';

class Addfood extends StatefulWidget {
  const Addfood({super.key});

  @override
  State<Addfood> createState() => _AddfoodState();
}

class _AddfoodState extends State<Addfood> {
  // text field controller
  TextEditingController labal = TextEditingController();
  TextEditingController callory = TextEditingController();

  CollectionReference _items = FirebaseFirestore.instance.collection('Food');
  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    _items = FirebaseFirestore.instance.collection("Food");
  }

  String selectedCategory = 'อาหาร'; // ค่าเริ่มต้น
  String searchText = '';
  // for create operation
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
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
                    "เพิ่มหัวข้อหัว",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: labal,
                  decoration: const InputDecoration(
                      labelText: 'ชื่ออาหาร', hintText: 'อาหาร'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: callory,
                  decoration: const InputDecoration(
                      labelText: 'จำนวนแคลอรี่', hintText: 'แคลอรี่'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    value: selectedCategory,
                    onChanged: (newValue) {
                      // เมื่อผู้ใช้เลือกประเภทใหม่
                      setState(() {
                        selectedCategory = newValue!;
                      });
                    },
                    items: <String>[
                      'อาหาร',
                      'เครื่องดื่ม',
                      'ขนมของหวาน',
                      'ผลไม้'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final String name = labal.text;
                    final String callorys = callory.text;
                    if (name.isNotEmpty) {
                      // ตรวจสอบว่าชื่อไม่ว่างเปล่า
                      await _items.doc(name).set({
                        "Lable": name,
                        "Callory": callorys,
                        "Category":
                            selectedCategory, // เพิ่มค่าประเภทที่ผู้ใช้เลือก
                      });
                      labal.text = '';
                      Navigator.of(context)
                          .pop(); // เมื่อบันทึกสำเร็จให้ปิดหน้าต่างปัจจุบัน
                    } else {
                      // ในกรณีที่ชื่อว่างเปล่า คุณสามารถแจ้งเตือนผู้ใช้หรือดำเนินการเพิ่มเติมตามที่คุณต้องการ
                      // ยกตัวอย่างเช่นแสดง SnackBar หรือ AlertDialog
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('กรุณากรอกชื่อ'),
                        ),
                      );
                    }
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
          'เพิ่มหัวอาหาร',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _items.snapshots(),
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
                  final lable1 = document['Lable'] ?? '';
                  final callory = document['Callory'] ?? '';
                  final id = document['Category'] ?? '';

                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 12,
                      top: 10,
                    ),
                    child: Card(
                      elevation: 1,
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
                                      //     builder: (context) => AddFood2(
                                      //         documentReference:
                                      //             document.reference),
                                      //     settings: RouteSettings(
                                      //         arguments: document),
                                      //   ),
                                      // );
                                    },
                                    subtitle: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(),
                                          child: Row(
                                            children: [
                                              Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.6,
                                                  child: Text(
                                                    lable1.toString().length >
                                                            20
                                                        ? lable1
                                                                .toString()
                                                                .substring(
                                                                    0, 20) +
                                                            '...'
                                                        : lable1,
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ))
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(),
                                          child: Row(
                                            children: [
                                              Text(
                                                " $callory แคลลอรี่   หมวด : $id",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: SizedBox(
                                      width: 40,
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                  //TO DO DELETE
                                                  onTap: () async {
                                                    // await _update();
                                                  },
                                                  child:
                                                      const Icon(Icons.edit)),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                  //TO DO DELETE
                                                  onTap: () async {
                                                    final action =
                                                        await AlertDialogs
                                                            .yesorCancel(
                                                                context,
                                                                'ลบ',
                                                                'คุณต้องการลบข้อมูลนี้หรือไม่');
                                                    if (action ==
                                                        DialogsAction.yes) {
                                                      setState(() {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection('Food')
                                                            .doc(document.id)
                                                            .delete()
                                                            .then((_) {})
                                                            .catchError(
                                                                (error) {});
                                                      });
                                                    }
                                                  },
                                                  child:
                                                      const Icon(Icons.delete)),
                                            ],
                                          ),
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
      // Create new project button
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        backgroundColor: const Color.fromARGB(255, 161, 136, 127),
        child: const Icon(Icons.add),
      ),
    );
  }
}
