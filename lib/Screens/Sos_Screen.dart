import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Sos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 161, 136, 127),
        elevation: 0,
        title: Text(
          'เหตุฉุกเฉิน',
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            title:
                                Center(child: Text('แจ้งเหตุฉุกเฉินหรือไม่')),
                            actions: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, // จัดตำแหน่งซ้าย-ขวาสุด
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      minimumSize: MaterialStateProperty.all(
                                          Size(120, 40)),
                                    ),
                                    child: Text('ใช่'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      minimumSize: MaterialStateProperty.all(
                                          Size(120, 40)),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 260,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const Foodscreen(),
                        //   ),
                        // );
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(const Size(
                          double.infinity,
                          48,
                        )),
                      ),
                      child: const Text(
                        'เปิดใช้งานฟังชั่นSOS',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
