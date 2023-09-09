import 'package:flutter/material.dart';

class Openfoodscreen extends StatefulWidget {
  const Openfoodscreen({super.key});

  @override
  State<Openfoodscreen> createState() => _OpenfoodscreenState();
}

class _OpenfoodscreenState extends State<Openfoodscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        elevation: 0,
        title: Text(
          'อาหารเช้า',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              //search bar
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10),
                      hintText: "ค้นหา...",
                      suffixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide())),
                ),
              ),
              // buttom กรอก และ บันทึก
              Padding(
                padding: const EdgeInsets.only(),
              ),

              textcolumn("textcol", "texts"),
              textview("aaaaaaa"),
              textview("aaaaaaaaaaaaaaa"),
            ],
          ),
        ),
      ),
    );
  }
}

Widget textview(
  textedit,
) {
  int number = 0; // สามารถเปลี่ยนค่าตัวเลขตามต้องการ
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: Container(
          // alignment: FractionalOffset.topLeft,
          child: Stack(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    textedit,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            (() {
                              number--;
                            });
                          },
                        ),
                        Text(
                          '$number',
                          style: TextStyle(fontSize: 24.0),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            (() {
                              number++;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      const Divider(
        thickness: 2,
        color: Colors.grey,
        indent: 25,
        endIndent: 25,
      ),
    ],
  );
}

Widget textcolumn(textcol, texts) {
  return Container(
    child: Column(
      children: [
        // ประเทภของหัวข้อ
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Container(
            alignment: FractionalOffset.topLeft,
            child: Text(
              textcol,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.brown),
            ),
          ),
        ),
        // ประเภทของ อาหาร
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Container(
            alignment: FractionalOffset.topLeft,
            child: Text(
              texts,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Divider(
          thickness: 4,
          color: Color.fromARGB(255, 175, 136, 122),
          indent: 25,
          endIndent: 25,
        ),
      ],
    ),
  );
}
