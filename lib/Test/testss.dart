import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubePlayerScreen extends StatelessWidget {
  final String videoUrl; // URL ของวิดีโอ YouTube

  YouTubePlayerScreen({required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    // แปลง URL ของวิดีโอ YouTube เป็น videoId
    String videoId = YoutubePlayer.convertUrlToId(videoUrl) ?? '';

    // สร้าง YoutubePlayerController ด้วย videoId
    final YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true, // เล่นอัตโนมัติเมื่อแสดง
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('แสดงวิดีโอ YouTube'),
      ),
      body: Center(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          onReady: () {
            // เมื่อวิดีโอพร้อมใช้งาน
            // คุณสามารถใส่การกระทำหรือโค้ดที่ต้องการเมื่อวิดีโอพร้อมเล่นได้ที่นี่
          },
        ),
      ),
    );
  }
}
