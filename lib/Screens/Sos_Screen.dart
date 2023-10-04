// ignore_for_file: file_names

// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Sos extends StatefulWidget {
  const Sos({super.key});

  @override
  State<Sos> createState() => _SosState();
}

class _SosState extends State<Sos> {
  // เบอร์โทรฉุกเฉินที่คุณต้องการให้โทรไป
  final String emergencyPhoneNumber = '1669';

  void callEmergency() async {
    final String url = 'tel:$emergencyPhoneNumber';

    try {
      // ignore: deprecated_member_use
      await launch(url);
    } catch (e) {
      // Handle errors here if needed
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Unable to make a call.'),
            actions: <Widget>[
              FlatButton(
                child: const Text('OK'),
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
        backgroundColor: const Color.fromARGB(255, 112, 86, 77),
        elevation: 0,
        title: const Text(
          'เหตุฉุกเฉิน',
          style: TextStyle(
              color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
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
                          title: const Center(
                              child: Text('แจ้งเหตุฉุกเฉินหรือไม่')),
                          actions: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween, // จัดตำแหน่งซ้าย-ขวาสุด
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(
                                        const Size(120, 40)),
                                  ),
                                  child: const Text(
                                    'ใช่',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  onPressed: () {
                                    callEmergency();
                                  },
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(
                                        const Size(120, 40)),
                                  ),
                                  child: const Text(
                                    'ไม่ใช่',
                                    style: TextStyle(fontSize: 18),
                                  ),
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

// ignore: non_constant_identifier_names
FlatButton({required Text child, required Null Function() onPressed}) {}
