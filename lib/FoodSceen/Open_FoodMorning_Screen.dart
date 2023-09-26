import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:polite/FoodSceen/Foodscreen.dart';

class Addfoodmorning extends StatefulWidget {
  const Addfoodmorning({super.key});

  @override
  State<Addfoodmorning> createState() => _AddfoodmorningState();
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

class _AddfoodmorningState extends State<Addfoodmorning> {
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
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  foodstatus selectedStatus = foodstatus.all;

  List<DocumentSnapshot> searchResults = []; // เพิ่มตัวแปร searchResults นี้

  void searchInFirebase(String searchtext) {
    // แปลง searchText เป็นตัวพิมพ์เล็กทั้งหมด
    searchtext = searchtext.toLowerCase();
    if (searchtext.isEmpty) {
      setState(() {
        searchResults.clear();
        isSearching = false; // ปรับสถานะการค้นหาเป็น false เมื่อไม่มีการค้นหา
      });
    } else {
      // ใช้คำสั่งค้นหาข้อมูลใน Firestore
      FirebaseFirestore.instance
          .collection("Food")
          .where("Lable", isGreaterThanOrEqualTo: searchtext)
          .where("Lable",
              isLessThan:
                  searchtext + 'z') // เพิ่ม 'z' เพื่อให้เป็นการค้นหาแบบ prefix
          .get()
          .then((QuerySnapshot querySnapshot) {
        // ตรวจสอบว่ามีข้อมูลหรือไม่
        if (querySnapshot.docs.isNotEmpty) {
          // มีข้อมูล
          final documents = querySnapshot.docs;

          // อัปเดต UI โดยการเรียก setState
          setState(() {
            // รีเซ็ตรายการที่แสดงใน ListView.builder เป็นรายการที่ค้นพบ
            searchResults = documents;
            isSearching = true; // ปรับสถานะการค้นหาเป็น true เมื่อมีการค้นหา
          });
        } else {
          // ไม่มีข้อมูลที่ค้นหา
          setState(() {
            // รีเซ็ตรายการที่แสดงใน ListView.builder เป็นรายการว่าง
            searchResults.clear();
            isSearching =
                false; // ปรับสถานะการค้นหาเป็น false เมื่อไม่มีผลลัพธ์การค้นหา
          });
        }
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
          'อาหารเช้า',
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
              final itemsToDisplay = isSearching && searchtext.text.isNotEmpty
                  ? searchResults
                  : documents;
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
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10),
                                hintText: "ค้นหา...",
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.search),
                                  onPressed: () {
                                    // เรียกใช้งานฟังก์ชันค้นหาเมื่อกดปุ่มค้นหา
                                    if (searchtext.text.isEmpty) {
                                      searchInFirebase(
                                          ""); // เรียกด้วยค่าว่างเพื่อให้แสดงทั้งหมด
                                    } else {
                                      searchInFirebase(searchtext
                                          .text); // เรียกด้วยข้อความค้นหา
                                    }
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
                                      style: TextStyle(color: Colors.black),
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

                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: itemsToDisplay.length,
                      itemBuilder: (context, index) {
                        final document = documents[index];
                        final lable1 = document['Lable'] ?? '';
                        final callory = document['Callory'] ?? '';
                        final id = document['Category'] ?? '';
                        final key = document['Foodtype'] ?? '';

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
                          .collection("FoodMorning")
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
