import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Openfoodscreen extends StatefulWidget {
  const Openfoodscreen({super.key});

  @override
  State<Openfoodscreen> createState() => _OpenfoodscreenState();
}

class _OpenfoodscreenState extends State<Openfoodscreen> {
  String formattedDate = DateFormat.yMMMd().format(DateTime.now());
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
              MyWidget(textedit: "aaaaaaaaaaaa"),
              MyWidget(textedit: "aaaaaaaaaaaa"),
            ],
          ),
        ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  final String textedit;

  MyWidget({required this.textedit});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int number = 0; // สามารถเปลี่ยนค่าตัวเลขตามต้องการ

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.textedit,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25, left: 250),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
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
                          setState(() {
                            number++;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 2,
            color: Colors.grey,
            indent: 25,
            endIndent: 25,
          ),
        ],
      ),
    );
  }
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
