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
  CollectionReference article =
      FirebaseFirestore.instance.collection("VideoScreen");
  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    article = FirebaseFirestore.instance.collection("VideoScreen");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        elevation: 0,
        title: Text(
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
                                  suffixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide: const BorderSide())),
                            ),
                          ),
                          const SizedBox(height: 15),
                          //text
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: Container(
                              alignment: FractionalOffset.topLeft,
                              child: Text(
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
                      itemCount: documents.length,
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
                                  color: Color.fromARGB(255, 143, 113, 102),
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
                                              color: Color.fromARGB(
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
                                                style: TextStyle(
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
            return Text("ไม่มีข้อมูล");
          }),
    );
  }
}
