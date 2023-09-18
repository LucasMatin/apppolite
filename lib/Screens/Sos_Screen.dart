import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Sos extends StatefulWidget {
  @override
  State<Sos> createState() => _SosState();
}

class _SosState extends State<Sos> {
  // เบอร์โทรฉุกเฉินที่คุณต้องการให้โทรไป
  final String emergencyPhoneNumber = '1669';

  void callEmergency() async {
    final String url = 'tel:$emergencyPhoneNumber';

    try {
      await launch(url);
    } catch (e) {
      // Handle errors here if needed
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Unable to make a call.'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

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
                GestureDetector(
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
                                    minimumSize: MaterialStateProperty.all(
                                        Size(120, 40)),
                                  ),
                                  child: Text('ใช่'),
                                  onPressed: () {
                                    callEmergency();
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

FlatButton({required Text child, required Null Function() onPressed}) {}
