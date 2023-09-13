// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// // ...

// class Editarticle extends StatefulWidget {
//   final DocumentReference documentReference;

//   const Editarticle({Key? key, required this.documentReference})
//       : super(key: key);

//   @override
//   State<Editarticle> createState() => _EditarticleState();
// }

// class _EditarticleState extends State<Editarticle> {
//   // ...

//   // Add a Stream to listen to the "in" subcollection
//   late Stream<QuerySnapshot> inCollectionStream;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize the Stream for the "in" subcollection
//     inCollectionStream = widget.documentReference.collection('in').snapshots();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // ...
//       appBar: AppBar(
//         backgroundColor: Colors.brown[300],
//         elevation: 0,
//         title: Text(
//           'เพิ่มข้อมูลข้างใน',
//           style: TextStyle(color: Colors.white, fontSize: 23),
//         ),
//         centerTitle: true,
//       ),

//       body: StreamBuilder<QuerySnapshot>(
//         stream: inCollectionStream,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           if (snapshot.hasError) {
//             return const Center(
//               child: Text('Error fetching data'),
//             );
//           }

//           final items = snapshot.data?.docs ?? [];

//           return SingleChildScrollView(
//             child: Center(
//               child: Column(
//                 children: [
//                   for (final item in items)
//                     ListTile(
//                       title: Text(item['title'] ?? 'No Title'),
//                       // You can add more widgets to display other data here
//                     ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),

//       // ...
//     );
//   }
// }
