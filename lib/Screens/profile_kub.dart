import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Editprofile.dart';
import 'Signin.dart';

class ProfileScreenAV extends StatefulWidget {
  const ProfileScreenAV({super.key});

  @override
  State<ProfileScreenAV> createState() => _ProfileScreenAVState();
}

class _ProfileScreenAVState extends State<ProfileScreenAV> {
  CollectionReference user = FirebaseFirestore.instance.collection("UserID");
  TextEditingController userid = TextEditingController();
  final formKey = GlobalKey<FormState>();
  sendUserDataToDB() async {
    if (formKey.currentState!.validate()) {
      return user.doc().set({'name': userid.text});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jsonav();
  }

  Future<void> jsonav() async {
    await Firebase.initializeApp();
    user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        elevation: 0,
        title: Text(
          'ข้อมูลส่วนตัว',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
      ),

      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('UserID')
              .doc('vjNnFBEGGLwcazKcreFz')
              .snapshots(),
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
              final documents = snapshot.data!.data() as Map<String, dynamic>;
              return Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15, left: 20, right: 10),
                    child: Row(
                      children: [Text(documents['name'])],
                    ),
                  )
                ],
              );
            }
            return Text("ไม่มีข้อมูล");
          }),

      //  return SingleChildScrollView(
      //     child: Container(
      //       child: Column(
      //         children: [
      //           const SizedBox(height: 30),
      //           Stack(
      //             children: [
      //               SizedBox(
      //                 width: 130,
      //                 height: 130,
      //                 child: ClipRRect(
      //                   borderRadius: BorderRadius.circular(100),
      //                   child: Image.asset('images/proflie.jpg'),
      //                 ),
      //               ),
      //             ],
      //           ),
      //           const SizedBox(height: 10),
      //           Text(
      //             "LalalisA",
      //             style: TextStyle(fontSize: 21),
      //           ),
      //           const SizedBox(height: 10),
      //           Text(
      //             "Lisa.eiei@gmail.com",
      //             style: TextStyle(fontSize: 22),
      //           ),
      //           Form(
      //             key: formKey,
      //             child: TextFormField(
      //               controller: userid,
      //               decoration: InputDecoration(
      //                   labelText: 'กรอกชื่อ', hintText: 'กรุณากรอกชื่อ'),
      //               validator: (value) {
      //                 if (value == null || value.isEmpty) {
      //                   return 'textwarning';
      //                 }
      //                 return null;
      //               },
      //             ),
      //           ),
      //           OutlinedButton(
      //               onPressed: () {
      //                 sendUserDataToDB();
      //               },
      //               child: const Text('save')),
      //           const SizedBox(height: 20),
      //           SizedBox(
      //               width: 200,
      //               child: ElevatedButton(
      //                 onPressed: () {
      //                   Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                       builder: (context) => const editscreen(),
      //                     ),
      //                   );
      //                 },
      //                 child: const Text("แก้ไขโปรไฟล์"),
      //                 style: ElevatedButton.styleFrom(
      //                     // backgroundColor:
      //                     ),
      //               )),
      //           const SizedBox(height: 10),
      //           SizedBox(
      //               width: 200,
      //               child: ElevatedButton(
      //                 onPressed: () {
      //                   Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                       builder: (context) => const LoginScreen(),
      //                     ),
      //                   );
      //                 },
      //                 child: const Text("ออกจากระบบ"),
      //                 style: ElevatedButton.styleFrom(
      //                     // backgroundColor:
      //                     ),
      //               )),
      //           const SizedBox(height: 10),
      //           const Divider(),
      //         ],
      //       ),
      //     ),
      //   ),
    );
  }
}
