// ignore_for_file: use_build_context_synchronously, avoid_print, library_private_types_in_public_api, camel_case_types, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:polite/FoodSceen/Foodscreen.dart';

class Addfooddaytime extends StatefulWidget {
  const Addfooddaytime({super.key});

  @override
  State<Addfooddaytime> createState() => _AddfooddaytimeState();
}

enum foodstatus {
  all,
  drink,
  food,
  dessert,
  fruit,
  puff,
  fry,
  grill,
  boiled,
  curry,
  soup,
}

class _AddfooddaytimeState extends State<Addfooddaytime> {
  TextEditingController searchtext = TextEditingController();
  CollectionReference _items = FirebaseFirestore.instance.collection('Food');
  bool isSearching = false; // เพิ่มตัวแปร isSearching เพื่อตรวจสอบสถานะการค้นหา
  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    _items = FirebaseFirestore.instance.collection("Food");
  }

  Widget buildStatusButton(foodstatus status, String label, Color color) {
    return TextButton(
      onPressed: () {
        setState(() {
          selectedStatus = status;
        });
      },
      style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: color),
      child: Text(
        '  $label  ',
        style: const TextStyle(color: Colors.black, fontSize: 18),
      ),
    );
  }

  foodstatus selectedStatus = foodstatus.all;

  String search = "";

  void searchtest(value) {
    setState(() {
      search = value.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 112, 86, 77),
        elevation: 0,
        title: const Text(
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
                              controller: searchtext,
                              onChanged: (value) {
                                EasyDebounce.debounce(
                                    "searchDebounce",
                                    const Duration(milliseconds: 1500),
                                    () => searchtest(value));
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10),
                                hintText: "ค้นหา...",
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.search),
                                  onPressed: () {
                                    searchtext.clear();
                                    searchtest("");
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: const BorderSide(),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedStatus = foodstatus.all;
                                      });
                                    },
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      backgroundColor:
                                          selectedStatus == foodstatus.all
                                              ? const Color.fromRGBO(
                                                  229, 227, 227, 1)
                                              : const Color.fromRGBO(
                                                  229, 227, 227, 1),
                                    ),
                                    child: const Text(
                                      '  ทั้งหมด ',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  buildStatusButton(
                                      foodstatus.drink,
                                      'เครื่องดื่ม',
                                      const Color.fromRGBO(255, 228, 193, 1)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  buildStatusButton(foodstatus.food, 'อาหาร',
                                      const Color.fromRGBO(255, 253, 146, 1)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  buildStatusButton(
                                      foodstatus.dessert,
                                      'ขนมของหวาน',
                                      const Color.fromRGBO(207, 255, 203, 1)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  buildStatusButton(foodstatus.fruit, 'ผลไม้',
                                      const Color.fromRGBO(218, 255, 246, 1)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  buildStatusButton(
                                      foodstatus.puff,
                                      'อาหารประเภทผัด',
                                      const Color.fromRGBO(218, 212, 255, 1)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  buildStatusButton(
                                      foodstatus.fry,
                                      'อาหารประเภททอด',
                                      const Color.fromRGBO(255, 226, 235, 1)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  buildStatusButton(
                                      foodstatus.grill,
                                      'อาหารประเภทย่าง',
                                      const Color.fromRGBO(255, 228, 193, 1)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  buildStatusButton(
                                      foodstatus.boiled,
                                      'อาหารประเภทต้ม/นึง',
                                      const Color.fromRGBO(255, 253, 146, 1)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  buildStatusButton(
                                      foodstatus.curry,
                                      'อาหารประเภทแกง',
                                      const Color.fromRGBO(207, 255, 203, 1)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  buildStatusButton(
                                      foodstatus.soup,
                                      'อาหารประเภทซุป',
                                      const Color.fromRGBO(218, 255, 246, 1)),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(
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
                        final id = document['Category'] ?? '';
                        final key = document['Foodtype'] ?? '';
                        final image = document['Image'] ?? '';
                        final units = document['Unit'] ?? '';
                        final diseases = document['Diseases'] ?? [];
                        final diseasess = document['NoDiseases'] ?? [];
                        // แปลง search เป็นตัวพิมพ์เล็กทั้งหมด
                        final lowercaseSearch = search.toLowerCase();

                        if (!lable1.toLowerCase().contains(lowercaseSearch)) {
                          return const SizedBox.shrink();
                        }

                        switch (selectedStatus) {
                          case foodstatus.all:
                            break;
                          case foodstatus.drink:
                            if (id != 'เครื่องดื่ม') {
                              return const SizedBox.shrink();
                            }
                            break;
                          case foodstatus.food:
                            if (id != 'อาหาร') {
                              return const SizedBox.shrink();
                            }
                            break;
                          case foodstatus.dessert:
                            if (id != 'ขนมของหวาน') {
                              return const SizedBox.shrink();
                            }
                            break;
                          case foodstatus.fruit:
                            if (id != 'ผลไม้') {
                              return const SizedBox.shrink();
                            }
                            break;
                          case foodstatus.puff:
                            if (key != 'อาหารประเภทผัด') {
                              return const SizedBox.shrink();
                            }
                            break;
                          case foodstatus.fry:
                            if (key != 'อาหารประเภททอด') {
                              return const SizedBox.shrink();
                            }
                          case foodstatus.grill:
                            if (key != 'อาหารประเภทย่าง') {
                              return const SizedBox.shrink();
                            }
                            break;
                          case foodstatus.boiled:
                            if (key != 'อาหารประเภทต้ม/นึง') {
                              return const SizedBox.shrink();
                            }
                            break;
                          case foodstatus.curry:
                            if (key != 'อาหารประเภทแกง') {
                              return const SizedBox.shrink();
                            }
                            break;
                          case foodstatus.soup:
                            if (key != 'อาหารประเภทซุป') {
                              return const SizedBox.shrink();
                            }
                            break;
                        }

                        return Column(
                          children: [
                            MyWidget(
                              textedit: lable1,
                              image: image,
                              callory: callory,
                              diseases: diseases,
                              diseasess: diseasess,
                              unitss: units,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return const Text("ไม่มีข้อมูล");
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const Foodscreen()),
          );
        },
        backgroundColor: const Color.fromARGB(255, 112, 86, 77),
        child: const Icon(Icons.save_as),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  final String textedit, image, callory, unitss;
  final List<dynamic> diseases,
      diseasess; // เพิ่ม properties สำหรับรับข้อมูล Diseases และ NoDiseases
  const MyWidget({
    super.key,
    required this.textedit,
    required this.image,
    required this.callory,
    required this.unitss,
    required this.diseases,
    required this.diseasess,
  });
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late String colory;
  @override
  void initState() {
    super.initState();
    colory = widget.callory;
  }

  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection("UserID");

  String getCurrentDateTime() {
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(now);
  }

  // for create operation
  Future<void> _create(
      {required String lable, required String callorys}) async {
    int number = 1; // สามารถเปลี่ยนค่าตัวเลขตามต้องการ

    print(callorys);
    void increment() {
      setState(() {
        number++;

        if (number >= 2) {
          // เพิ่มค่า callory เมื่อ number เป็น 2 ขึ้นไป

          callorys =
              (int.parse(callorys) + int.parse(widget.callory)).toString();
        }
      });
    }

    void decrement() {
      setState(() {
        if (number > 1) {
          print(number);
          number--;
          // ปรับค่า callorys เมื่อ number เป็น 1 ขึ้นไป
          callorys =
              (int.parse(callorys) - int.parse(widget.callory)).toString();
        } else {
          // ไม่ทำอะไรเมื่อ number เป็น 1 หรือน้อยกว่า
        }
      });
    }

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
                        "$lable : $callorys แคลอรี่",
                        style: const TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(2),
                    child: Center(
                      child: Text(
                        // ignore: unnecessary_type_check
                        "แนะนำสำหรับโรค",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: Center(
                      child: Text(
                        // ignore: unnecessary_type_check
                        "${widget.diseases is List ? widget.diseases.join(', ') : widget.diseases}",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(2),
                    child: Center(
                      child: Text(
                        // ignore: unnecessary_type_check
                        "ไม่แนะนำสำหรับโรค",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: Center(
                      child: Text(
                        // ignore: unnecessary_type_check
                        "${widget.diseasess is List ? widget.diseasess.join(', ') : widget.diseasess}",
                        style: const TextStyle(fontSize: 18),
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
                            child: const Padding(
                              padding: EdgeInsets.all(1),
                              child: Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          '$number ${widget.unitss}',
                          style: const TextStyle(fontSize: 24.0),
                        ),
                        const SizedBox(
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
                            child: const Padding(
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
                        'Callory': callorys,
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(),
            child: Stack(
              children: [
                SizedBox(
                  width: 400.0,
                  height: 100.0,
                  child: Card(
                    color: const Color.fromARGB(255, 112, 80, 68),
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 140.0,
                              height: 100.0,
                              child: Card(
                                color: const Color.fromARGB(255, 237, 230, 224),
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Image.network(
                                    widget.image,
                                    width: 100, // กำหนดความกว้างของรูป
                                    height: 100, // กำหนดความสูงของรูป
                                    fit: BoxFit
                                        .cover, // ตัวเลือกที่จะให้รูปภาพปรับตามขนาดที่กำหนด
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 150, right: 15, top: 15),
                          child: SafeArea(
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        widget.textedit,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Stack(
                                    children: [
                                      Text(
                                        "$colory แคลอรี่",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 25, left: 170, top: 16),
                                  child: Row(
                                    children: <Widget>[
                                      Ink(
                                        width: 32,
                                        height: 32,
                                        decoration: ShapeDecoration(
                                          color: const Color.fromARGB(
                                              255, 138, 102, 87),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                8.0), // ปรับขนาดตามที่คุณต้องการ
                                          ),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            // increment();
                                            _create(
                                                callorys: colory,
                                                lable: widget.textedit);
                                          },
                                          child: const Padding(
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
    );
  }
}
