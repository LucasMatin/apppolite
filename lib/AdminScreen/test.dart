// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:polite/Screens/wiget.dart';

// //ส่วนแก้ไข
// class Editeatsreeen extends StatefulWidget {
//   const Editeatsreeen({super.key});

//   @override
//   State<Editeatsreeen> createState() => _EditeatsreeenState();
// }

// class _EditeatsreeenState extends State<Editeatsreeen> {
//   final formKey = GlobalKey<FormState>();
//   late TextEditingController title1;
//   late TextEditingController title2;
//   @override
//   void initState() {
//     super.initState();
//     title1 = TextEditingController(text: widget.document['title1']);
//     title2 = TextEditingController(text: widget.document['title2']);
//   }

//   @override
//   void dispose() {
//     title1.dispose();
//     title2.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.brown[300],
//         elevation: 0,
//         title: Text(
//           'แก้ไข',
//           style: TextStyle(color: Colors.white, fontSize: 23),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Form(
//             key: formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 textbox(title1, "text", "labal", "hint"),
//                 textbox(title2, "text", "labal", "hint")
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
