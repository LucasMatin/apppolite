// ignore_for_file: unnecessary_null_comparison, file_names, avoid_print, use_build_context_synchronously, library_private_types_in_public_api, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:polite/AdminScreen/Bottom_Admin_Screen.dart';

class EditUserScreen extends StatefulWidget {
  final DocumentSnapshot documentSnapshot; // เพิ่มตัวแปรนี้

  const EditUserScreen({Key? key, required this.documentSnapshot})
      : super(key: key);
  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final formKey = GlobalKey<FormState>();

  final userCollection = FirebaseFirestore.instance.collection('UserID');
  TextEditingController fullname = TextEditingController();
  TextEditingController telno = TextEditingController();
  TextEditingController bisease = TextEditingController();
  TextEditingController sex = TextEditingController();
  TextEditingController birthday = TextEditingController();

  String selectedDisease = 'ไม่มีโรคประจำตัว'; // Default value

  @override
  void initState() {
    super.initState();

    // Set the values from the document to the corresponding controllers
    final document = widget.documentSnapshot;

    // Check if the document is not null before extracting values
    if (document != null && document.exists) {
      fullname.text = document['Fullname'] ?? '';
      telno.text = document['Telno'] ?? '';
      bisease.text = document['Bisease'] ?? '';
      birthday.text = document['Birthday'] ?? '';
      sex.text = document['Sex'] ?? '';
    }
  }

  Future<List<String>> getDiseases() async {
    try {
      QuerySnapshot? querySnapshot = await FirebaseFirestore.instance
          .collection('DiseaseCollection')
          .get();

      // Check if querySnapshot is not null and contains documents
      if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
        List<String> diseases = querySnapshot.docs
            .map((document) => document['Label'].toString())
            .toList();

        // Add "ไม่มีโรคประจำตัว" to the list
        diseases.insert(0, 'ไม่มีโรคประจำตัว');

        return diseases;
      } else {
        print('No documents found in DiseaseCollection.');
        return [];
      }
    } catch (error) {
      print('Error fetching diseases: $error');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final document = widget.documentSnapshot;
    fullname.text = document['Fullname'] ?? '';
    telno.text = document['Telno'] ?? '';
    bisease.text = document['Bisease'] ?? '';
    birthday.text = document['Birthday'] ?? '';
    sex.text = document['Sex'] ?? '';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 112, 86, 77),
        elevation: 0,
        title: const Text(
          'แก้ไขข้อมูลผู้ใช้',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                            prefixIcon: Icon(Icons.account_circle_outlined)),
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
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
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
                      child: TextFormField(
                        controller: birthday,
                        decoration: const InputDecoration(
                            label: Text('วันเดือนปีเกิด'),
                            prefixIcon:
                                Icon(Icons.supervised_user_circle_rounded)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณาวันเดือนปีเกิด';
                          }
                          return null; // ไม่มีข้อผิดพลาด
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 300,
                      child: SexDropdownFormField(
                        controller: sex,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                        width: 300,
                        child: DiseaseDropdownFormField(controller: bisease)),
                    const SizedBox(height: 20),
                  ],
                )),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: 350,
                child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      String name = fullname.text;
                      String phone = telno.text;
                      String passwords = bisease.text;
                      String birthdays = birthday.text;
                      String sexs = sex.text;

                      Map<String, dynamic> updatedData = {
                        'Fullname': name,
                        'Telno': phone,
                        'Bisease': passwords,
                        'Birthday': birthdays,
                        'Sex': sexs,
                      };

                      try {
                        // Use .data() to handle the case where the document might be null
                        await userCollection
                            .doc(widget.documentSnapshot.id)
                            .update(updatedData);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('อัพเดทข้อมูลสำเร็จ'),
                          ),
                        );
                        Navigator.of(context).pop();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('เกิดข้อผิดพลาดในการอัพเดทข้อมูล: $e'),
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
                  child: const Text(
                    'แก้ไขเสร็จสิ้น',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DiseaseDropdownFormField extends StatefulWidget {
  final TextEditingController controller;

  const DiseaseDropdownFormField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _DiseaseDropdownFormFieldState createState() =>
      _DiseaseDropdownFormFieldState();
}

class _DiseaseDropdownFormFieldState extends State<DiseaseDropdownFormField> {
  String selectedDisease = 'ไม่มีโรคประจำตัว'; // Default value

  @override
  void initState() {
    super.initState();
    selectedDisease = widget.controller.text;

    // Set selectedDisease to the first item in the list (if available)
    getDiseases().then((diseases) {
      if (diseases.isNotEmpty) {
        setState(() {
          selectedDisease = widget.controller.text.isNotEmpty
              ? widget.controller.text
              : diseases[0];
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

class SexDropdownFormField extends StatefulWidget {
  final TextEditingController controller;

  const SexDropdownFormField({super.key, required this.controller});

  @override
  _SexDropdownFormFieldState createState() => _SexDropdownFormFieldState();
}

class _SexDropdownFormFieldState extends State<SexDropdownFormField> {
  String selectedGender = 'ชาย'; // Default value

  @override
  void initState() {
    super.initState();
    selectedGender = widget.controller.text; // Set the initial value
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedGender,
      onChanged: (newValue) {
        setState(() {
          selectedGender = newValue!;
          widget.controller.text = newValue;
        });
      },
      decoration: const InputDecoration(
        labelText: 'เพศ',
      ),
      items: <String>['ชาย', 'หญิง'].map((String gender) {
        return DropdownMenuItem<String>(
          value: gender,
          child: Text(gender),
        );
      }).toList(),
    );
  }
}
