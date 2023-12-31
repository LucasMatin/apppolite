// ignore_for_file: file_names, prefer_interpolation_to_compose_strings, sized_box_for_whitespace, use_build_context_synchronously, duplicate_ignore, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:polite/AdminScreen/Add/alert_delete.dart';

class Addvideo extends StatefulWidget {
  const Addvideo({super.key});

  @override
  State<Addvideo> createState() => _AddvideoState();
}

class _AddvideoState extends State<Addvideo> {
  // text field controller
  TextEditingController labal = TextEditingController();
  TextEditingController urlvideo = TextEditingController();

  CollectionReference _items =
      FirebaseFirestore.instance.collection('VideoScreen');
  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    _items = FirebaseFirestore.instance.collection("VideoScreen");
  }

  String searchText = '';
  // for create operation
  // ignore: unused_element
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
                TextField(
                  controller: labal,
                  decoration: const InputDecoration(
                      labelText: 'หัวข้อ', hintText: 'กรุณาหัวข้อ'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: urlvideo,
                  decoration: const InputDecoration(
                      labelText: 'URL วิดีโอ YouTrue',
                      hintText: 'กรุณาURL วิดีโอ YouTrue'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final String name = labal.text;
                    final String urlvideos = urlvideo.text;
                    await _items.doc(name).set({
                      "Lablevideo": name,
                      'URLYoutrue': urlvideos,
                    });
                    labal.text = '';
                    urlvideo.text = '';

                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(
                        255, 86, 167, 89), // กำหนดสีพื้นหลังเป็นสีเขียว
                  ),
                  child: const Text(
                    "ยืนยัน",
                    style: TextStyle(fontSize: 25),
                  ),
                )
              ],
            ),
          );
        });
  }

  // for _update operation
  Future<void> _update(DocumentSnapshot documentSnapshot) async {
    final String initialLabel = documentSnapshot['Lablevideo'];
    final String initialUrl = documentSnapshot['URLYoutrue'];

    labal.text = initialLabel;
    urlvideo.text = initialUrl;

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            right: 20,
            left: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "แก้ไข",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              TextField(
                controller: labal,
                decoration: const InputDecoration(
                  labelText: 'หัวข้อ',
                  hintText: 'กรุณาหัวข้อ',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: urlvideo,
                decoration: const InputDecoration(
                  labelText: 'URL วิดีโอ YouTrue',
                  hintText: 'กรุณา URL วิดีโอ YouTrue',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  final String name = labal.text;
                  final String urlvideos = urlvideo.text;

                  await documentSnapshot.reference.update({
                    "Lablevideo": name,
                    'URLYoutrue': urlvideos,
                  });

                  labal.text = '';
                  urlvideo.text = '';

                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(
                      255, 86, 167, 89), // กำหนดสีพื้นหลังเป็นสีเขียว
                ),
                child: const Text(
                  "ยืนยัน",
                  style: TextStyle(fontSize: 25),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  TextEditingController searchtexts = TextEditingController();
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
          'วิดิโอเพื่อสุขภาพ',
          style: TextStyle(color: Colors.white, fontSize: 25),
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
                          Stack(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: searchtexts,
                                      onChanged: (value) {
                                        EasyDebounce.debounce(
                                            "searchDebounce",
                                            const Duration(milliseconds: 1500),
                                            () => searchtest(value));
                                      },
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10.0, horizontal: 10),
                                        hintText: "ค้นหา...",
                                        suffixIcon: IconButton(
                                          icon: const Icon(Icons.search),
                                          onPressed: () {
                                            searchtexts.clear();
                                            searchtest("");
                                          },
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          borderSide: const BorderSide(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final document = documents[index];
                        final lable1 = document['Lablevideo'] ?? '';
                        final urlvideos = document['URLYoutrue'] ?? '';
                        final lowercaseSearch = search.toLowerCase();

                        if (!lable1.toLowerCase().contains(lowercaseSearch)) {
                          return const SizedBox.shrink();
                        }
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
                                            //     builder: (context) =>
                                            //         VideoListScreen(), // หน้าแสดงรายการวิดีโอ
                                            //   ),
                                            // );
                                          },
                                          subtitle: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(3),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.6,
                                                        child: Text(
                                                          lable1
                                                                      .toString()
                                                                      .length >
                                                                  20
                                                              ? lable1
                                                                      .toString()
                                                                      .substring(
                                                                          0,
                                                                          20) +
                                                                  '...'
                                                              : lable1,
                                                          style: const TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(3),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.6,
                                                        child: Text(
                                                          urlvideos
                                                                      .toString()
                                                                      .length >
                                                                  20
                                                              ? urlvideos
                                                                      .toString()
                                                                      .substring(
                                                                          0,
                                                                          20) +
                                                                  '...'
                                                              : urlvideos,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 15,
                                                          ),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          trailing: SizedBox(
                                            width: 55,
                                            child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    InkWell(
                                                        //TO DO DELETE
                                                        onTap: () async {
                                                          await _update(
                                                              document);
                                                        },
                                                        child: const Icon(
                                                            Icons.edit)),
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
                                                              DialogsAction
                                                                  .yes) {
                                                            setState(() {
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'VideoScreen')
                                                                  .doc(document
                                                                      .id)
                                                                  .delete()
                                                                  .then((_) {})
                                                                  .catchError(
                                                                      (error) {});
                                                            });
                                                          }
                                                        },
                                                        child: const Icon(
                                                            Icons.delete)),
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
                    ),
                  ),
                ],
              );
            }
            return const Text("ไม่มีข้อมูล");
          }),
      // Create new project button
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        backgroundColor: const Color.fromARGB(255, 112, 86, 77),
        child: const Icon(Icons.add),
      ),
    );
  }
}
