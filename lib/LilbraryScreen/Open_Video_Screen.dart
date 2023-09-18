import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Openvideoscreen extends StatefulWidget {
  final DocumentSnapshot documentSnapshot; // เพิ่มตัวแปรนี้

  const Openvideoscreen({Key? key, required this.documentSnapshot})
      : super(key: key);

  @override
  State<Openvideoscreen> createState() => _OpenvideoscreenState();
}

class _OpenvideoscreenState extends State<Openvideoscreen> {
  @override
  Widget build(BuildContext context) {
    final document = widget.documentSnapshot;
    final lable = document['Lablevideo'] ?? '';
    final url = document['URLYoutrue'] ?? '';
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70, right: 10, left: 10),
            child: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: YoutubePlayer.convertUrlToId(url) ?? '',
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Text(
                lable,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Text(
                "แหล่งข้อมูล",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Text(
                url,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
