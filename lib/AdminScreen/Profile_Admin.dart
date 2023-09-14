import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:polite/Screens/Login_Screen.dart';
import 'package:flutter/material.dart';

class Profiladminescreen extends StatelessWidget {
  const Profiladminescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        elevation: 0,
        title: Text(
          'ข้อมูลผู้ดูแล',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('AdminID')
              .doc('ZFqr9SSxQSLpuM2bGhuW')
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
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset('images/proflie.jpg'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(documents['Fullname'],
                              style: TextStyle(fontSize: 21)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(documents['Email'],
                              style: TextStyle(fontSize: 18)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
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
                            child: const Text("ออกจากระบบ"),
                            style: ElevatedButton.styleFrom(
                                // backgroundColor:
                                ),
                          )),
                      const SizedBox(height: 10),
                      const Divider(),
                    ],
                  ),
                ),
              );
            }
            return Text("ไม่มีข้อมูล");
          }),
    );
  }
}
