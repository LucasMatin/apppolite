import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CollectionReference food1 = FirebaseFirestore.instance.collection("Food");
  CollectionReference food2 =
      FirebaseFirestore.instance.collection("NutritionScreen");
  CollectionReference food3 =
      FirebaseFirestore.instance.collection("EatScreen");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firestore Data"),
      ),
      body: Column(
        children: [
          // Example for displaying data from "Food" collection
          StreamBuilder<QuerySnapshot>(
            stream: food1.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Text('No Data');
              }

              final documents = snapshot.data!.docs;
              return Column(
                children: documents.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  return ListTile(
                    title: Text(data['Lable']),
                    subtitle: Text(data['Lable']),
                  );
                }).toList(),
              );
            },
          ),
          // Example for displaying data from "in" collection
          StreamBuilder<QuerySnapshot>(
            stream: food2.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              final documents = snapshot.data!.docs;
              return Column(
                children: documents.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  return ListTile(
                    title: Text(data['Lable']),
                    subtitle: Text(data['Lable']),
                  );
                }).toList(),
              );
            },
          ),
          // Example for displaying data from "into" collection
          StreamBuilder<QuerySnapshot>(
            stream: food3.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              final documents = snapshot.data!.docs;
              return Column(
                children: documents.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  return ListTile(
                    title: Text(data['ID']),
                    subtitle: Text(data['Title1']),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}


  // void _addToFirestore() async {
  //   // สร้างเอกสารย่อยภายใต้คอลเลกชัน "UserID" โดยใช้วันที่ปัจจุบันเป็นชื่อเอกสาร
  //   final FirebaseAuth auth = FirebaseAuth.instance;
  //   var currentUser = auth.currentUser;
  //   String? useruid = currentUser!.uid;

  //   DocumentReference foodTodayDoc = usersCollection
  //       .doc(useruid)
  //       .collection("Foodtoday")
  //       .doc("16-09-2023")
  //       .collection("FoodMorning")
  //       .doc(label);

  //   // เพิ่มข้อมูลลงในเอกสารย่อย
  //   await foodTodayDoc.set({
  //     'Foodname': label,
  //     'Callory': callory,
  //     'Number': number,
  //   });
  // }