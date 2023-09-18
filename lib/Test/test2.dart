import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายการวิดีโอ YouTrue'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        // รับข้อมูล URL วิดีโอจาก Firebase Firestore
        stream:
            FirebaseFirestore.instance.collection('VideoScreen').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<QueryDocumentSnapshot> videoDocuments = snapshot.data!.docs;

          return ListView.builder(
            itemCount: videoDocuments.length,
            itemBuilder: (context, index) {
              String videoUrl = videoDocuments[index]['URLYoutrue'];

              // แสดงวิดีโอ YouTube ด้วย URL จาก Firebase Firestore
              return YoutubePlayer(
                controller: YoutubePlayerController(
                  initialVideoId: YoutubePlayer.convertUrlToId(videoUrl) ?? '',
                ),
              );
            },
          );
        },
      ),
    );
  }
}
