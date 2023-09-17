import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:polite/FoodSceen/Foodscreen.dart';

class Addfooddaytime extends StatefulWidget {
  const Addfooddaytime({super.key});

  @override
  State<Addfooddaytime> createState() => _AddfooddaytimeState();
}

class _AddfooddaytimeState extends State<Addfooddaytime> {
  CollectionReference _items = FirebaseFirestore.instance.collection('Food');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        elevation: 0,
        title: Text(
          'อาหารกลางวัน',
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
              return Column(
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 10),
                          //search bar
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10),
                                hintText: "ค้นหา...",
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.search),
                                  onPressed: () {
                                    // เรียกใช้งานฟังก์ชันค้นหาเมื่อกดปุ่มค้นหา
                                    // searchInFirebase(searchTextController.text);
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: const BorderSide(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final document = documents[index];
                        final lable1 = document['Lable'] ?? '';
                        final callory = document['Callory'] ?? '';
                        // final id = document['Category'] ?? '';

                        return Column(
                          children: [
                            MyWidget(textedit: "$lable1 : $callory แคลลอรี่")
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return Text("ไม่มีข้อมูล");
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const Foodscreen()),
          );
        },
        backgroundColor: const Color.fromARGB(255, 161, 136, 127),
        child: const Icon(Icons.save_as),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  final String textedit;

  MyWidget({required this.textedit});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection("UserID");

  // for create operation
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return SingleChildScrollView(
            child: Padding(
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
                      "รายการบันทึก",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: Center(
                      child: Text(
                        "$lable  $callory แคลลอรี่",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Ink(
                          width: 32,
                          height: 32,
                          decoration: ShapeDecoration(
                            color: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  8.0), // ปรับขนาดตามที่คุณต้องการ
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              decrement();
                            },
                            child: Padding(
                              padding: EdgeInsets.all(1),
                              child: Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          '$number',
                          style: TextStyle(fontSize: 24.0),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Ink(
                          width: 32,
                          height: 32,
                          decoration: ShapeDecoration(
                            color: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  8.0), // ปรับขนาดตามที่คุณต้องการ
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              increment();
                            },
                            child: Padding(
                              padding: EdgeInsets.all(1),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      var currentUser = auth.currentUser;
                      String? useruid = currentUser!.uid;

                      DocumentReference foodTodayDoc = usersCollection
                          .doc(useruid)
                          .collection("Foodtoday")
                          .doc(getCurrentDateTime())
                          .collection("FoodDayTime")
                          .doc(lable);

                      // เพิ่มข้อมูลลงในเอกสารย่อย
                      await foodTodayDoc.set({
                        'Foodname': lable,
                        'Callory': callory,
                        'Number': number,
                      });

                      // เมื่อข้อมูลถูกเพิ่มเรียบร้อย ให้เปิดหน้า Foodscreen
                      Navigator.of(context).pop();
                    },
                    child: const Text("ยืนยัน"),
                  )
                ],
              ),
            ),
          );
        });
  }

  String getCurrentDateTime() {
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(now);
  }

  int number = 1; // สามารถเปลี่ยนค่าตัวเลขตามต้องการ
  String? lable;
  String? callory;

  @override
  void initState() {
    super.initState();
    final parts = widget.textedit.split(' : ');
    if (parts.length == 2) {
      lable = parts[0];
      callory = parts[1].replaceAll(' แคลลอรี่', '');
    }
  }

  void increment() {
    setState(() {
      number++;
      if (number >= 2) {
        // เพิ่มค่า callory เมื่อ number เป็น 2 ขึ้นไป
        callory = (int.parse(callory!) +
                int.parse(widget.textedit
                    .split(' : ')[1]
                    .replaceAll(' แคลลอรี่', '')))
            .toString();
      }
    });
  }

  void decrement() {
    setState(() {
      if (number > 1) {
        number--;
        if (number == 1) {
          // ให้ค่า callory เป็นค่าปกติของแคลอรี่ เมื่อ number เป็น 1
          callory = widget.textedit.split(' : ')[1].replaceAll(' แคลลอรี่', '');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.textedit,
                        style: TextStyle(
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25, left: 320),
                  child: Row(
                    children: <Widget>[
                      Ink(
                        width: 32,
                        height: 32,
                        decoration: ShapeDecoration(
                          color: const Color.fromARGB(255, 138, 102, 87),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8.0), // ปรับขนาดตามที่คุณต้องการ
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            // increment();
                            _create();
                          },
                          child: Padding(
                            padding: EdgeInsets.all(1),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 2,
            color: Colors.grey,
            indent: 25,
            endIndent: 25,
          ),
        ],
      ),
    );
  }
}
