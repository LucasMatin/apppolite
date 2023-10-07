// ignore_for_file: sort_child_properties_last, avoid_unnecessary_containers, file_names, avoid_print, empty_catches, use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:polite/Screens/Login_Screen.dart';
import 'package:flutter/material.dart';

class Profiladminescreen extends StatefulWidget {
  const Profiladminescreen({super.key});

  @override
  State<Profiladminescreen> createState() => _ProfiladminescreenState();
}

class _ProfiladminescreenState extends State<Profiladminescreen> {
  final formKey = GlobalKey<FormState>();
  final currrenUser = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseFirestore.instance.collection('AdminID');
  String imageUrl = '';
  List<File> image = [];
  ImagePicker picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        elevation: 0,
        title: const Text(
          'ข้อมูลผู้ดูแล',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('AdminID')
              .doc(currrenUser.uid)
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

              return SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Stack(
                        children: [
                          SizedBox(
                            width: 130,
                            height: 130,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color.fromARGB(
                                      255, 77, 74, 74), // สีขอบ
                                  width: 3.0, // ความหนาขอบ
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: documents["Image"] != null
                                    ? Image.network(documents["Image"])
                                    : Image.asset("images/Proflie.png"),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color:
                                      const Color.fromARGB(255, 196, 164, 153)),
                              child: InkWell(
                                onTap: () {
                                  dialogBuilder(context);
                                },
                                child: const Icon(
                                  LineAwesomeIcons.camera,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(documents['Fullname'],
                              style: const TextStyle(fontSize: 21)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(documents['Email'],
                              style: const TextStyle(fontSize: 18)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("ผู้ดูแล", style: TextStyle(fontSize: 18)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                  255,
                                  112,
                                  86,
                                  77), // Set your desired background color here
                            ),
                            child: const Text(
                              "ออกจากระบบ",
                              style: TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.bold),
                            ),
                          )),
                      const SizedBox(height: 10),
                      const Divider(),
                    ],
                  ),
                ),
              );
            }
            return const Text("ไม่มีข้อมูล");
          }),
    );
  }

  Future<void> dialogBuilder(
    BuildContext context,
  ) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('แก้ไขรูปภาพโปรไฟล์'),
          content: Form(
            key: formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: imageUrl.isNotEmpty
                      ? NetworkImage(imageUrl) as ImageProvider<Object>?
                      : const AssetImage(
                          "images/logo.png"), // Add a default image here // Add a default image here
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  ListTile(
                    onTap: () async {
                      ImagePicker imagePicker = ImagePicker();
                      XFile? file = await imagePicker.pickImage(
                        source: ImageSource.gallery,
                      );

                      print('${file?.path}');

                      if (file == null) return;

                      String uniqueFileName =
                          DateTime.now().millisecondsSinceEpoch.toString();

                      Reference referenceRoot = FirebaseStorage.instance.ref();
                      Reference referenceDirImages =
                          referenceRoot.child('images');

                      Reference referenceImageToUpload =
                          referenceDirImages.child(uniqueFileName);

                      try {
                        await referenceImageToUpload.putFile(File(file.path));

                        imageUrl =
                            await referenceImageToUpload.getDownloadURL();
                        setState(() {});
                      } catch (error) {}
                    },
                    leading: const Icon(Icons.add_a_photo_rounded),
                    title: const Text('เลือกรูปภาพ'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        child: const Text('ยกเลิก'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        child: const Text('เสร็จ'),
                        onPressed: () async {
                          // ignore: unnecessary_null_comparison
                          if (imageUrl == null ||
                              imageUrl.isEmpty ||
                              imageUrl.trim() == "") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('กรุณาอัปโหลดรูปภาพ'),
                              ),
                            );
                            return;
                          }

                          if (formKey.currentState!.validate()) {
                            // Create a Map of data
                            Map<String, String> dataToSend = {
                              'Image': imageUrl,
                            };

                            // Upload the data to Firestore
                            await userCollection
                                .doc(currrenUser.uid)
                                .update(dataToSend);

                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
