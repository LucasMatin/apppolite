// ignore_for_file: prefer_interpolation_to_compose_strings, camel_case_types, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:polite/LilbraryScreen/Open_Video_Screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class videoscreen extends StatefulWidget {
  const videoscreen({super.key});

  @override
  State<videoscreen> createState() => _videoscreenState();
}

class _videoscreenState extends State<videoscreen> {
  TextEditingController searchtext = TextEditingController();
  CollectionReference article =
      FirebaseFirestore.instance.collection("VideoScreen");
  bool isSearching = false; // เพิ่มตัวแปร isSearching เพื่อตรวจสอบสถานะการค้นหา
  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    article = FirebaseFirestore.instance.collection("VideoScreen");
  }

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
          .collection("VideoScreen")
          .where("Lablevideo", isGreaterThanOrEqualTo: searchtext)
          .where("Lablevideo",
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
        backgroundColor: const Color.fromARGB(255, 112, 86, 77),
        elevation: 0,
        title: const Text(
          'วิดีโอเพื่อสุขภาพ',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: article.snapshots(),
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
              // สร้างรายการที่จะแสดง
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
                          const SizedBox(height: 15),
                          //text
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: Container(
                              alignment: FractionalOffset.topLeft,
                              child: const Text(
                                'วิดีโอเพื่อสุขภาพ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Colors.brown),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Divider(
                            thickness: 3,
                            color: Color.fromARGB(255, 175, 136, 122),
                            indent: 25,
                            endIndent: 25,
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
                        final lable1 = document['Lablevideo'] ?? '';
                        final url = document['URLYoutrue'] ?? '';

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SafeArea(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Openvideoscreen(
                                      documentSnapshot: document,
                                    ),
                                  ),
                                );
                              },
                              child: SizedBox(
                                width: 400.0,
                                height: 100.0,
                                child: Card(
                                  color:
                                      const Color.fromARGB(255, 143, 113, 102),
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
                                              color: const Color.fromARGB(
                                                  255, 237, 230, 224),
                                              elevation: 2.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(6.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0), // กำหนดขอบของรูปภาพ
                                                  child: YoutubePlayer(
                                                    controller:
                                                        YoutubePlayerController(
                                                      initialVideoId:
                                                          YoutubePlayer
                                                                  .convertUrlToId(
                                                                      url) ??
                                                              '',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 150, right: 15, top: 20),
                                        child: SafeArea(
                                          child: Column(
                                            children: [
                                              Text(
                                                lable1.toString().length > 20
                                                    ? lable1
                                                            .toString()
                                                            .substring(0, 29) +
                                                        '...'
                                                    : lable1,
                                                style: const TextStyle(
                                                    fontSize: 21,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return const Text("ไม่มีข้อมูล");
          }),
    );
  }
}
