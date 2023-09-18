// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:polite/AdminScreen/test2.dart';

// class AddVideoUrlScreen extends StatefulWidget {
//   @override
//   _AddVideoUrlScreenState createState() => _AddVideoUrlScreenState();
// }

// class _AddVideoUrlScreenState extends State<AddVideoUrlScreen> {
//   TextEditingController videoUrlController = TextEditingController();
//   Future<void> addVideoUrlToFirebase(String videoUrl) async {
//     try {
//       // รับอ้างอิงไปยังคอลเล็กชันใน Firestore ที่คุณสร้างขึ้น
//       CollectionReference videosCollection =
//           FirebaseFirestore.instance.collection('videos');

//       // เพิ่มข้อมูล URL วิดีโอลงใน Firestore
//       await videosCollection.add({
//         'url': videoUrl,
//       });

//       print('บันทึก URL วิดีโอลงใน Firestore สำเร็จ');
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => VideoListScreen(), // หน้าแสดงรายการวิดีโอ
//         ),
//       );
//     } catch (e) {
//       print('เกิดข้อผิดพลาดในการบันทึก URL วิดีโอ: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('เพิ่ม URL วิดีโอจาก YouTrue'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: videoUrlController,
//               decoration: InputDecoration(
//                 labelText: 'URL วิดีโอ YouTrue',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 String videoUrl = videoUrlController.text.trim();
//                 if (videoUrl.isNotEmpty) {
//                   addVideoUrlToFirebase(videoUrl);
//                   videoUrlController.clear();
//                 }
//               },
//               child: Text('บันทึก URL วิดีโอ'),
//             ),
//             // ElevatedButton(
//             //   onPressed: () {
//             //     Navigator.push(
//             //       context,
//             //       MaterialPageRoute(
//             //         builder: (context) =>
//             //             VideoListScreen(), // หน้าแสดงรายการวิดีโอ
//             //       ),
//             //     );
//             //   },
//             //   child: Text('บันทึก URL วิดีโอ'),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
