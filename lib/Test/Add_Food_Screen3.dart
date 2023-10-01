// ignore_for_file: file_names
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:polite/AdminScreen/Add/alert_delete.dart';

// class AddFood3 extends StatefulWidget {
//   final DocumentReference documentReference;

//   const AddFood3({Key? key, required this.documentReference}) : super(key: key);

//   @override
//   State<AddFood3> createState() => _AddFood3State();
// }

// class _AddFood3State extends State<AddFood3> {
//   // ...

//   // Add a Stream to listen to the "in" subcollection
//   late Stream<QuerySnapshot> inCollectionStream;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize the Stream for the "in" subcollection
//     inCollectionStream = widget.documentReference.collection('in').snapshots();
//     inCollectionStream =
//         widget.documentReference.collection('into').snapshots();
//   }

//   // text field controller
//   TextEditingController title = TextEditingController();

//   TextEditingController callory = TextEditingController();

//   CollectionReference _items = FirebaseFirestore.instance.collection('Food');

//   String searchText = '';
//   // for create operation
//   Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
//     await showModalBottomSheet(
//         isScrollControlled: true,
//         context: context,
//         builder: (BuildContext ctx) {
//           return SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.only(
//                   top: 20,
//                   right: 20,
//                   left: 20,
//                   bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Center(
//                     child: Text(
//                       "เพิ่มหัวข้อหัว",
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   TextField(
//                     controller: title,
//                     decoration: const InputDecoration(
//                       labelText: 'อาหาร',
//                       hintText: 'ชื่ออาหาร',
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   TextField(
//                     controller: callory,
//                     decoration: const InputDecoration(
//                         labelText: 'จำนวนแคลอรี่', hintText: 'แคลอรี่'),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   ElevatedButton(
//                     onPressed: () async {
//                       final String name = title.text;
//                       final String callorys = callory.text;

//                       {
//                         // ตรวจสอบว่าชื่อไม่ว่างเปล่า
//                         await _items.doc();
//                         widget.documentReference.collection('in').doc();
//                         widget.documentReference
//                             .collection('into')
//                             .doc(name)
//                             .set({
//                           "Title": name,
//                           "Callory": callorys,
//                         });

//                         title.text = '';
//                         callory.text = '';

//                         Navigator.of(context)
//                             .pop(); // เมื่อบันทึกสำเร็จให้ปิดหน้าต่างปัจจุบัน
//                       }
//                     },
//                     child: const Text("ยืนยัน"),
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // ...
//       appBar: AppBar(
//         backgroundColor: Colors.brown[300],
//         elevation: 0,
//         title: Text(
//           'เพิ่มข้อมูลอาหาร',
//           style: TextStyle(color: Colors.white, fontSize: 23),
//         ),
//         centerTitle: true,
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//           stream: inCollectionStream,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }

//             if (snapshot.hasError) {
//               return const Center(
//                 child: Text('Error fetching data'),
//               );
//             }
//             if (snapshot.hasData) {
//               final documents = snapshot.data!.docs;
//               if (documents.isEmpty) {
//                 return const Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [Text('ยังไม่มีข้อมูล')],
//                   ),
//                 );
//               }
//               return ListView.builder(
//                 itemCount: documents.length,
//                 itemBuilder: (context, index) {
//                   final document = documents[index];
//                   final lable1 = document['Title'] ?? '';

//                   final callory = document['Callory'] ?? '';

//                   return Padding(
//                     padding: const EdgeInsets.only(
//                       left: 15,
//                       right: 12,
//                       top: 10,
//                     ),
//                     child: Card(
//                       elevation: 1,
//                       child: SizedBox(
//                         height: 90,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Stack(
//                                 children: [
//                                   ListTile(
//                                     isThreeLine: false,
//                                     onTap: () {},
//                                     subtitle: Column(
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.only(),
//                                           child: Row(
//                                             children: [
//                                               Text(
//                                                 lable1,
//                                                 style: TextStyle(
//                                                     fontSize: 18,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.only(),
//                                           child: Row(
//                                             children: [
//                                               Text(
//                                                 "$callory แคลลอรี่",
//                                                 style: TextStyle(
//                                                   fontSize: 15,
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     trailing: SizedBox(
//                                       width: 40,
//                                       child: Column(
//                                         children: [
//                                           Row(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             children: [
//                                               InkWell(
//                                                   //TO DO DELETE
//                                                   onTap: () async {
//                                                     // await _update();
//                                                   },
//                                                   child:
//                                                       const Icon(Icons.edit)),
//                                             ],
//                                           ),
//                                           Row(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             children: [
//                                               InkWell(
//                                                   //TO DO DELETE
//                                                   onTap: () async {
//                                                     final action =
//                                                         await AlertDialogs
//                                                             .yesorCancel(
//                                                                 context,
//                                                                 'ลบ',
//                                                                 'คุณต้องการลบข้อมูลนี้หรือไม่');
//                                                     if (action ==
//                                                         DialogsAction.yes) {
//                                                       setState(() {
//                                                         FirebaseFirestore
//                                                             .instance
//                                                             .collection(
//                                                                 'ArticleScreen')
//                                                             .doc();
//                                                         widget.documentReference
//                                                             .collection("in")
//                                                             .doc();
//                                                         widget.documentReference
//                                                             .collection("into")
//                                                             .doc(document.id)
//                                                             .delete()
//                                                             .then((value) {})
//                                                             .catchError(
//                                                                 (error) {
//                                                           print(error);
//                                                         });
//                                                       });
//                                                     }
//                                                   },
//                                                   child:
//                                                       const Icon(Icons.delete)),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }
//             return Text("ไม่มีข้อมูล");
//           }),
//       // Create new project button
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _create(),
//         backgroundColor: const Color.fromARGB(255, 161, 136, 127),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
