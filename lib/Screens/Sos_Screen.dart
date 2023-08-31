import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Sos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[300],
        elevation: 0,
        title: Text(
          'เหตุฉุกเฉิน',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  title: Center(child: Text('แจ้งเหตุฉุกเฉินหรือไม่')),
                  actions: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // จัดตำแหน่งซ้าย-ขวาสุด
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(Size(120, 40)),
                          ),
                          child: Text('ใช่'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(Size(120, 40)),
                          ),
                          child: Text('ไม่ใช่'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          },
          child: Image.asset('images/Sos.png'),
        ),
      ),
    );
  }
}
