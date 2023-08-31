import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class editscreen extends StatelessWidget {
  const editscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new_sharp)),
        backgroundColor: Colors.brown[300],
        elevation: 0,
        title: Text(
          'แก้ไขข้อมูลส่วนตัว',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          // padding: const EdgeInsets.all(DefaulitSize),
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
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color.fromARGB(255, 196, 164, 153)),
                      child: const Icon(
                        LineAwesomeIcons.camera,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),
              Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          label: Text('ชื่อ-นามสกุล'),
                          prefixIcon: Icon(Icons.account_circle_outlined)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          label: Text('อีเมล'),
                          prefixIcon: Icon(Icons.email_rounded)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          label: Text('เบอร์'), prefixIcon: Icon(Icons.call)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          label: Text('รหัสผ่าน'),
                          prefixIcon: Icon(Icons.password_outlined)),
                    ),
                  ),
                ],
              )),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () {},
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
      ),
    );
  }
}
