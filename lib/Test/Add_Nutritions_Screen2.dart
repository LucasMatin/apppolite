// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DiseaseDetailsScreen extends StatelessWidget {
  final String diseaseId;

  DiseaseDetailsScreen({required this.diseaseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายละเอียดโรค'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('NutritionScreen')
            .doc(diseaseId)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Text('ไม่พบข้อมูลโรค'),
            );
          }

          final data = snapshot.data!;
          final label = data['Lable'] ?? '';
          final symptoms = data['symptoms'] ?? '';
          final suitableFoods = data['suitableFoods'] as List<dynamic>? ?? [];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ชื่อโรค: $label',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'อาการ: $symptoms',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                const Text(
                  'อาหารที่เหมาะกับโรค:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Column(
                  children: suitableFoods
                      .map<Widget>((foodId) => FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                .collection('Food')
                                .doc(foodId)
                                .get(),
                            builder: (context, foodSnapshot) {
                              if (foodSnapshot.hasError) {
                                return Center(
                                  child: Text('Error: ${foodSnapshot.error}'),
                                );
                              }

                              if (foodSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (!foodSnapshot.hasData ||
                                  !foodSnapshot.data!.exists) {
                                return const Center(
                                  child: Text('ไม่พบข้อมูลอาหาร'),
                                );
                              }

                              final foodData = foodSnapshot.data!;
                              final foodName = foodData['name'] ?? '';
                              return ListTile(
                                title: Text(foodName),
                              );
                            },
                          ))
                      .toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
