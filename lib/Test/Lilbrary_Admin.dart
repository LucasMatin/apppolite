// import 'package:polite/AdminScreen/Add/Add_Article_Screen.dart';
// import 'package:polite/AdminScreen/Add/Add_Eat_Screen.dart';
// import 'package:polite/AdminScreen/Add/Add_Nutrition_Screen.dart';
// import 'package:polite/AdminScreen/Add/Add_Video_Screen.dart';

// import 'package:flutter/material.dart';

// class Lilbraryadminscreen extends StatelessWidget {
//   const Lilbraryadminscreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.brown[300],
//         elevation: 0,
//         title: Text(
//           'จัดการห้องสมุด',
//           style: TextStyle(color: Colors.white, fontSize: 23),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: SafeArea(
//             child: Column(
//           children: [
//             const SizedBox(height: 14),
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Center(
//                 child: Wrap(
//                   spacing: 20.0,
//                   runSpacing: 20.0,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => Addnutrition()));
//                       },
//                       child: SizedBox(
//                         width: 400.0,
//                         height: 140.0,
//                         child: Card(
//                           color: Color.fromARGB(255, 143, 113, 102),
//                           elevation: 2.0,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                           child: Center(
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 children: [
//                                   Image.asset(
//                                     "images/nutrition.png",
//                                     width: 65.0,
//                                   ),
//                                   SizedBox(height: 10.0),
//                                   Text(
//                                     "แนะนำเกี่ยวกับโภชนาการ",
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 20.0,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) => Saveeat()));
//                       },
//                       child: SizedBox(
//                         width: 400.0,
//                         height: 140.0,
//                         child: Card(
//                           color: Color.fromARGB(255, 143, 113, 102),
//                           elevation: 2.0,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                           child: Center(
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 children: [
//                                   Image.asset(
//                                     "images/eat.png",
//                                     width: 65.0,
//                                   ),
//                                   SizedBox(height: 10.0),
//                                   Text(
//                                     "กินอย่างไรให้สุภาพดี",
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 20.0,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => Addarticale()));
//                       },
//                       child: SizedBox(
//                         width: 400.0,
//                         height: 140.0,
//                         child: Card(
//                           color: Color.fromARGB(255, 143, 113, 102),
//                           elevation: 2.0,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                           child: Center(
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 children: [
//                                   Image.asset(
//                                     "images/article.png",
//                                     width: 98.0,
//                                   ),
//                                   SizedBox(height: 10.0),
//                                   Text(
//                                     "บทความเพื่อสุขภาพ",
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 20.0,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => Addvideo()));
//                       },
//                       child: SizedBox(
//                         width: 400.0,
//                         height: 140.0,
//                         child: Card(
//                           color: Color.fromARGB(255, 143, 113, 102),
//                           elevation: 2.0,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                           child: Center(
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 children: [
//                                   Image.asset(
//                                     "images/exercise.png",
//                                     width: 67.0,
//                                   ),
//                                   SizedBox(height: 10.0),
//                                   Text(
//                                     "วิดิโอเพื่อสุภาพ",
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 20.0,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         )),
//       ),
//     );
//   }
// }
