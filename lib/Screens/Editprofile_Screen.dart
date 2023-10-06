// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names, library_private_types_in_public_api, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

// ignore: camel_case_types
class editscreen extends StatefulWidget {
  const editscreen({super.key});

  @override
  State<editscreen> createState() => _editscreenState();
}

// ignore: camel_case_types
class _editscreenState extends State<editscreen> {
  final formKey = GlobalKey<FormState>();

  final currrenUser = FirebaseAuth.instance.currentUser!;

  final userCollection = FirebaseFirestore.instance.collection('UserID');

  TextEditingController fullname = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController telno = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 112, 86, 77),
        elevation: 0,
        title: const Text(
          'แก้ไขข้อมูลส่วนตัว',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('UserID')
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
              final userData = snapshot.data!.data() as Map<String, dynamic>;
              // Update the TextEditingController values with user data
              fullname.text = userData['Fullname'] ?? '';
              telno.text = userData['Telno'] ?? '';
              password.text = userData['Bisease'] ?? '';

              return SingleChildScrollView(
                child: SafeArea(
                  // padding: const EdgeInsets.all(DefaulitSize),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 300,
                                child: TextFormField(
                                  controller: fullname,
                                  decoration: const InputDecoration(
                                      label: Text('ชื่อ-นามสกุล'),
                                      prefixIcon:
                                          Icon(Icons.account_circle_outlined)),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณาป้อนชื่อ-นามสกุล';
                                    }
                                    return null; // ไม่มีข้อผิดพลาด
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: 300,
                                child: TextFormField(
                                  controller: telno,
                                  decoration: const InputDecoration(
                                      label: Text('เบอร์โทรศัพท์'),
                                      prefixIcon: Icon(Icons.call)),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'กรุณาเบอร์โทรศัพท์';
                                    }
                                    return null; // ไม่มีข้อผิดพลาด
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: 300,
                                child: DiseaseDropdownFormField(
                                  controller: password,
                                ),
                              ),
                              // SizedBox(
                              //   width: 300,
                              //   child: TextFormField(
                              //     controller: password,
                              //     decoration: const InputDecoration(
                              //         label: Text('โรคประจำตัว'),
                              //         prefixIcon: Icon(
                              //             Icons.accessibility_new_rounded)),
                              //     validator: (value) {
                              //       if (value == null || value.isEmpty) {
                              //         return 'กรุณาโรคประจำตัว';
                              //       }
                              //       return null; // ไม่มีข้อผิดพลาด
                              //     },
                              //   ),
                              // ),
                            ],
                          )),
                      const SizedBox(height: 20),
                      Center(
                        child: SizedBox(
                          width: 350,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                // ถ้าฟอร์มถูกต้อง คุณสามารถดำเนินการต่อไปได้
                                // ดึงข้อมูลที่ป้อนจากฟอร์ม
                                String name = fullname.text;
                                String phone = telno.text;
                                String passwords = password.text;

                                // สร้าง Map ของข้อมูลที่จะอัพเดทใน Firestore
                                Map<String, dynamic> updatedData = {
                                  'Fullname': name,
                                  'Telno': phone,
                                  'Bisease': passwords,
                                  // เพิ่มข้อมูลอื่น ๆ ที่คุณต้องการอัพเดท
                                };

                                try {
                                  // อัพเดทข้อมูลใน Firestore
                                  await userCollection
                                      .doc(currrenUser.uid)
                                      .update(updatedData);

                                  // อัพเดทข้อมูลสำเร็จ
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('อัพเดทข้อมูลสำเร็จ'),
                                    ),
                                  );
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pop();
                                } catch (e) {
                                  // การอัพเดทข้อมูลผิดพลาด
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'เกิดข้อผิดพลาดในการอัพเดทข้อมูล: $e'),
                                    ),
                                  );
                                }
                              }
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(const Size(
                                double.infinity,
                                48,
                              )),
                            ),
                            child: const Text('แก้ไขเสร็จสิ้น'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const Text("ไม่มีข้อมูล");
          }),
    );
  }
}

class DiseaseDropdownFormField extends StatefulWidget {
  final TextEditingController controller;

  const DiseaseDropdownFormField({Key? key, required this.controller})
      : super(key: key);

  @override
  _DiseaseDropdownFormFieldState createState() =>
      _DiseaseDropdownFormFieldState();
}

class _DiseaseDropdownFormFieldState extends State<DiseaseDropdownFormField> {
  String selectedDisease = 'ไม่มีโรคประจำตัว'; // Default value

  @override
  void initState() {
    super.initState();
    widget.controller.text = selectedDisease;

    // Set selectedDisease to the first item in the list (if available)
    getDiseases().then((diseases) {
      if (diseases.isNotEmpty) {
        setState(() {
          selectedDisease = diseases[0];
          widget.controller.text = selectedDisease;
        });
      }
    });
  }

  Future<List<String>> getDiseases() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('NutritionScreen').get();

      List<String> diseases = querySnapshot.docs
          .map((document) => document['Lable'].toString())
          .toList();

      print(
          'Diseases from Firestore: $diseases'); // Add this line for debugging

      // Add "ไม่มีโรคประจำตัว" to the list
      diseases.insert(0, 'ไม่มีโรคประจำตัว');

      return diseases;
    } catch (error) {
      // Handle errors as needed
      print('Error fetching diseases: $error');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: getDiseases(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No data available');
        } else {
          List<String> diseases = snapshot.data!;

          print(
              'Selected Disease: $selectedDisease'); // Add this line for debugging

          return DropdownButtonFormField<String>(
            value: selectedDisease,
            onChanged: (newValue) {
              setState(() {
                selectedDisease = newValue!;
                widget.controller.text = newValue;
              });
            },
            items: diseases
                .map((String disease) => DropdownMenuItem<String>(
                      value: disease,
                      child: Text(disease),
                    ))
                .toList(),
            decoration: const InputDecoration(
              labelText: 'โรคประจำตัว',
            ),
          );
        }
      },
    );
  }
}
