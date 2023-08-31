import 'package:polite/Screens/Editprofile.dart';
import 'package:polite/Screens/Signin.dart';
import 'package:flutter/material.dart';

class Profilescreen extends StatelessWidget {
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
      body: SingleChildScrollView(
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
              Text(
                "LalalisA",
                style: TextStyle(fontSize: 21),
              ),
              const SizedBox(height: 10),
              Text(
                "Lisa.eiei@gmail.com",
                style: TextStyle(fontSize: 22),
              ),
              const SizedBox(height: 20),
              SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const editscreen(),
                        ),
                      );
                    },
                    child: const Text("แก้ไขโปรไฟล์"),
                    style: ElevatedButton.styleFrom(
                        // backgroundColor:
                        ),
                  )),
              const SizedBox(height: 10),
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
              const Divider(
                thickness: 1,
                color: Color.fromARGB(255, 175, 136, 122),
                indent: 25,
                endIndent: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
