import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:polite/AdminScreen/Add/alert_delete.dart';

class Adminuser extends StatefulWidget {
  const Adminuser({super.key});

  @override
  State<Adminuser> createState() => _AdminuserState();
}

class _AdminuserState extends State<Adminuser> {
  // text field controller
  TextEditingController labal = TextEditingController();

  CollectionReference _items = FirebaseFirestore.instance.collection('AdminID');
  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    _items = FirebaseFirestore.instance.collection("AdminID");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown[300],
          elevation: 0,
          title: Text(
            'เช็คแอดมิน',
            style: TextStyle(color: Colors.white, fontSize: 23),
          ),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: _items.snapshots(),
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
                final documents = snapshot.data!.docs;
                if (documents.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text('ยังไม่มีข้อมูล')],
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final document = documents[index];
                    final email = document['Email'] ?? '';
                    final name = document['Fullname'] ?? '';
                    final user = document['UserAdminID'] ?? '';

                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 12,
                        top: 10,
                      ),
                      child: Card(
                        elevation: 1,
                        child: SizedBox(
                          height: 90,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    ListTile(
                                      isThreeLine: false,
                                      onTap: () {},
                                      subtitle: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "ID : $user",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "ชื่อพัฒนา : $name",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(),
                                            child: Row(
                                              children: [
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.6,
                                                    child: Text(
                                                      email.toString().length >
                                                              20
                                                          ? email
                                                                  .toString()
                                                                  .substring(
                                                                      0, 20) +
                                                              '...'
                                                          : email,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: SizedBox(
                                        width: 40,
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                    //TO DO DELETE
                                                    onTap: () async {
                                                      // await _update();
                                                    },
                                                    child:
                                                        const Icon(Icons.edit)),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                    //TO DO DELETE
                                                    onTap: () async {
                                                      final action =
                                                          await AlertDialogs
                                                              .yesorCancel(
                                                                  context,
                                                                  'ลบ',
                                                                  'คุณต้องการลบข้อมูลนี้หรือไม่');
                                                      if (action ==
                                                          DialogsAction.yes) {
                                                        setState(() {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'AdminID')
                                                              .doc(document.id)
                                                              .delete()
                                                              .then((_) {})
                                                              .catchError(
                                                                  (error) {});
                                                        });
                                                      }
                                                    },
                                                    child: const Icon(
                                                        Icons.delete)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              return Text("ไม่มีข้อมูล");
            }));
  }
}
