// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:polite/Test/Model/FoodModel.dart'; // ปรับเปลี่ยนชื่อไฟล์ตามที่คุณตั้ง

class FoodService {
  final CollectionReference foodCollection =
      FirebaseFirestore.instance.collection('Food');

  Future<List<FoodModel>> getFoodsForDisease(String diseaseType) async {
    List<FoodModel> foods = [];

    try {
      QuerySnapshot querySnapshot = await foodCollection.get();
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        FoodModel food =
            FoodModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);

        // เช็คว่าอาหารประเภทไหนเหมาะกับโรคที่ระบุ
        if (food.foodType == diseaseType) {
          foods.add(food);
        }
      }
    } catch (e) {
      print("Error fetching foods: $e");
    }

    return foods;
  }
}
