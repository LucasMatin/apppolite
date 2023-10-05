// ignore_for_file: file_names

class FoodModel {
  final String id;
  final String label;
  final String calories;
  final String foodType;
  final String category;
  final String image;

  FoodModel({
    required this.id,
    required this.label,
    required this.calories,
    required this.foodType,
    required this.category,
    required this.image,
  });

  // สร้างเมธอดเพื่อแปลงข้อมูลจาก Firestore ให้กลายเป็นอ็อบเจ็กต์ FoodModel
  factory FoodModel.fromMap(Map<String, dynamic> map, String id) {
    return FoodModel(
      id: id,
      label: map['Lable'] ?? '',
      calories: map['Callory'] ?? '',
      foodType: map['Foodtype'] ?? '',
      category: map['Category'] ?? '',
      image: map['Image'] ?? '',
    );
  }
}
