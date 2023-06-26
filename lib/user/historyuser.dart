import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Cart/orderuser.dart';
import 'package:flutter_application_3/user/Edit_profile.dart';

class HistoryUser extends StatefulWidget {
  const HistoryUser({Key? key}) : super(key: key);

  @override
  _HistoryUserState createState() => _HistoryUserState();
}

class _HistoryUserState extends State<HistoryUser> {
  int count = 1;
  int coun2 = 2;
  int totalx = 0;
  int totalx1 = 0;
  int totalx2 = 2;
  int totalx3 = 20;

  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(215, 188, 187, 187),
        elevation: 10,
        title: Text("ประวัติการสั่งชื้อ",
            style: TextStyle(
              fontSize: 18,
            )),
        centerTitle: true,
        actions: [],
      ),
      body: Column(
        children: [
          Container(
            color: Color.fromARGB(255, 255, 255, 255),
            height: 736,
            width: double.infinity,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("order-nawinklo@gamil.com")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                // for (int i = 0; i < snapshot.data!.docs.length; i++) {
                //   totalx = ((totalx +
                //       int.parse(
                //           '${snapshot.data!.docs[i]['sumprice'].toString()}')));
                //   // totalx = ((totalx +
                //   //             double.parse(
                //   //                 '${snapshot.data!.docs[i]['sumprice'].toString()}')) *
                //   //         double.parse('0.5')) +
                //   //     20;
                //   // totalx1 = (totalx1 + totalx) + 2;
                //   //     int.parse(
                //   //         '${snapshot.data!.docs[i]['sumprice'].toString()}');
                //   print('จำนวน');
                //   print(i);
                //   print('ราคาทั้งหมด');
                //   print(totalx.toString().trim());
                //   print('ราคาล่าสุด');
                //   print('${snapshot.data!.docs[i]['sumprice'].toString()}');
                // }

                if (snapshot.data == null) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (_, index) {
                      DocumentSnapshot _documentSnapshot =
                          snapshot.data!.docs[index];

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: InkWell(
                              onTap: () {
                                // for (int i = 0; i < 5; i++)
                                //   setState(() {
                                //     total = total + i;
                                //   });

                                print('{_documentSnapshot[index]');
                                print('${_documentSnapshot['name']}');
                                print('${_documentSnapshot['id']}');
                              },
                              child: Card(
                                elevation: 6,
                                child: ListTile(
                                  leading: Container(
                                    height: 70,
                                    width: 70,
                                    child: Image.network(
                                        _documentSnapshot["images"],
                                        fit: BoxFit.fill),
                                  ),
                                  title: Wrap(
                                    children: [
                                      Text(
                                        _documentSnapshot['name'],
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(
                                    " ${_documentSnapshot['sumprice']}฿" +
                                        " ${_documentSnapshot['day']}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 255, 119, 0)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              },
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
