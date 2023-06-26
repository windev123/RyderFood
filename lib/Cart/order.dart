import "dart:io";
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Cart/onderuser.dart/idorder.dart';

class totalsreen extends StatefulWidget {
  var _order;

  @override
  State<totalsreen> createState() => _totalsreenState();
}

class _totalsreenState extends State<totalsreen> {
  int count = 1;
  var now = DateTime.now();
  List _order = [];
  Random random = Random();

  @override
  Widget build(BuildContext context) {
    int totalxs = 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(215, 188, 187, 187),
        elevation: 10,
        title: Text("ชำระเงิน",
            style: TextStyle(
              fontSize: 18,
            )),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.message),
            tooltip: 'Go to the next page',
            onPressed: () {
              print('');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Wrap(
              children: [
                Container(
                  child: Column(
                    children: [
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("users-cart-items")
                              .doc(FirebaseAuth.instance.currentUser!.email)
                              .collection("items")
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            // Future addtoOrder() async {
                            //   final FirebaseAuth _auth = FirebaseAuth.instance;
                            //   var currentUser = _auth.currentUser;
                            //   int ID = random.nextInt(10000);
                            //   CollectionReference _collectionRef =
                            //       FirebaseFirestore.instance
                            //           .collection("order");
                            //   for (var i = 0;
                            //       i < snapshot.data!.docs.length;
                            //       i++) {
                            //     print(currentUser!.email);
                            //     print(
                            //         '${snapshot.data!.docs[i]['name'].toString()}');

                            //     _collectionRef.doc(ID.toString()).set({
                            //       "id-order": ID.toString(),
                            //       "email": (currentUser.email),
                            //       "id": [
                            //         for (var i = 0;
                            //             i < snapshot.data!.docs.length;
                            //             i++)
                            //           '${snapshot.data!.docs[i]['id'].toString()}'
                            //       ],
                            //       "name": [
                            //         for (var i = 0;
                            //             i < snapshot.data!.docs.length;
                            //             i++)
                            //           '${snapshot.data!.docs[i]['name'].toString()}'
                            //       ],
                            //       "price": [
                            //         for (var i = 0;
                            //             i < snapshot.data!.docs.length;
                            //             i++)
                            //           '${snapshot.data!.docs[i]['price'].toString()}'
                            //       ],
                            //       "images": [
                            //         for (var i = 0;
                            //             i < snapshot.data!.docs.length;
                            //             i++)
                            //           '${snapshot.data!.docs[i]['images'].toString()}'
                            //       ],
                            //       "quantity": [
                            //         for (var i = 0;
                            //             i < snapshot.data!.docs.length;
                            //             i++)
                            //           " ${snapshot.data!.docs[i]['quantity'].toString()}"
                            //       ],
                            //       "sumprice": [
                            //         for (var i = 0;
                            //             i < snapshot.data!.docs.length;
                            //             i++)
                            //           '${snapshot.data!.docs[i]['sumprice'].toString()}'
                            //       ],
                            //       "total": totalxs.toString().trim(),
                            //     }).then((value) => print("Added to Order"));
                            //   }
                            // }

                            Future addtoidorder() async {
                              final FirebaseAuth _auth = FirebaseAuth.instance;
                              var currentUser = _auth.currentUser;
                              int ran = random.nextInt(10000);
                              CollectionReference _collectionRef =
                                  FirebaseFirestore.instance
                                      .collection("id-order");
                              for (var i = 0;
                                  i < snapshot.data!.docs.length;
                                  i++) {
                                print(currentUser!.email);
                                print(
                                    '${snapshot.data!.docs[i]['name'].toString()}');

                                _collectionRef
                                    .doc("Order" + ran.toString())
                                    .collection("id-product")
                                    .doc(
                                      '${snapshot.data!.docs[i]['id'].toString()}',
                                    )
                                    .set({
                                  "id-order": "Order" + ran.toString(),
                                  "email": (currentUser.email),
                                  "id":
                                      '${snapshot.data!.docs[i]['id'].toString()}',
                                  "name":
                                      '${snapshot.data!.docs[i]['name'].toString()}',
                                  "price":
                                      '${snapshot.data!.docs[i]['price'].toString()}',
                                  "images":
                                      '${snapshot.data!.docs[i]['images'].toString()}',
                                  "market":
                                      '${snapshot.data!.docs[i]['market'].toString()}',
                                  "quantity":
                                      " ${snapshot.data!.docs[i]['quantity'].toString()}",
                                  "sumprice":
                                      '${snapshot.data!.docs[i]['sumprice'].toString()}',
                                  "total": totalxs.toString().trim(),
                                }).then((value) => print("Added to Order"));
                              }
                            }

                            Future adddelete() async {
                              final FirebaseAuth _auth = FirebaseAuth.instance;
                              for (var i = 0;
                                  i < snapshot.data!.docs.length;
                                  i++) {
                                final FirebaseAuth _auth =
                                    FirebaseAuth.instance;
                                var currentUser = _auth.currentUser;
                                FirebaseFirestore.instance
                                    .collection("users-cart-items")
                                    .doc(currentUser!.email)
                                    .collection("items")
                                    .doc(
                                        '${snapshot.data!.docs[i]['id'].toString()}')
                                    .delete();
                              }
                            }

                            Future addtoid() async {
                              final FirebaseAuth _auth = FirebaseAuth.instance;
                              var currentUser = _auth.currentUser;
                              CollectionReference _collectionRef =
                                  FirebaseFirestore.instance
                                      .collection("status");
                              {
                                print(currentUser!.email);

                                _collectionRef.doc(currentUser.email).set({
                                  "status": "กำลังจัดเตรียมอาหาร",
                                  "image":
                                      "https://firebasestorage.googleapis.com/v0/b/dzenshop-1fb49.appspot.com/o/GIF%2Fgiphy.gif?alt=media&token=98f325e1-7395-40bc-b7ff-4645e37d47ae"
                                }).then((value) => print("status"));
                              }
                            }

                            Future addtostatus() async {
                              final FirebaseAuth _auth = FirebaseAuth.instance;
                              var currentUser = _auth.currentUser;
                              CollectionReference _collectionRef =
                                  FirebaseFirestore.instance
                                      .collection("status");
                              {
                                print(currentUser!.email);

                                _collectionRef.doc(currentUser.email).set({
                                  "status": "กำลังจัดเตรียมอาหาร",
                                  "image":
                                      "https://firebasestorage.googleapis.com/v0/b/dzenshop-1fb49.appspot.com/o/GIF%2Fgiphy.gif?alt=media&token=98f325e1-7395-40bc-b7ff-4645e37d47ae"
                                }).then((value) => print("status"));
                              }
                            }

                            Future addtoOrder() async {
                              final FirebaseAuth _auth = FirebaseAuth.instance;
                              var currentUser = _auth.currentUser;
                              CollectionReference _collectionRef =
                                  FirebaseFirestore.instance
                                      .collection("order");
                              for (var i = 0;
                                  i < snapshot.data!.docs.length;
                                  i++) {
                                print(currentUser!.email);
                                print(
                                    '${snapshot.data!.docs[i]['name'].toString()}');

                                _collectionRef
                                    .doc(currentUser.email)
                                    .collection("order")
                                    .doc(
                                      '${snapshot.data!.docs[i]['id'].toString()}',
                                    )
                                    .set({
                                  "email": (currentUser.email),
                                  "id":
                                      '${snapshot.data!.docs[i]['id'].toString()}',
                                  "name":
                                      '${snapshot.data!.docs[i]['name'].toString()}',
                                  "price":
                                      '${snapshot.data!.docs[i]['price'].toString()}',
                                  "images":
                                      '${snapshot.data!.docs[i]['images'].toString()}',
                                  "market":
                                      '${snapshot.data!.docs[i]['market'].toString()}',
                                  "quantity":
                                      " ${snapshot.data!.docs[i]['quantity'].toString()}",
                                  "sumprice":
                                      '${snapshot.data!.docs[i]['sumprice'].toString()}',
                                  "total": totalxs.toString().trim(),
                                }).then((value) => print("Added to Order"));
                              }
                            }

                            for (int i = 0;
                                i < snapshot.data!.docs.length;
                                i++) {
                              totalxs = totalxs +
                                  int.parse(
                                      '${snapshot.data!.docs[i]['sumprice'].toString()}');

                              // total = total +
                              //     int.parse(
                              //         '${snapshot.data!.docs[i]['sumprice'].toString()}');
                              // print('จำนวน');
                              // print(i);
                              // print('ราคาล่าสุด');
                              // print(
                              //     '${snapshot.data!.docs[i]['sumprice'].toString()}');
                              // print(totalxs.toString().trim());
                              // print('ราคาทั้งหมด');
                              // print('${snapshot.data!.docs[i]['sumprice'].toString()}');
                              // print(totalxs.toString().trim());
                              print(
                                  '${snapshot.data!.docs[i]['name'].toString()}');
                              print("Added to Order");

                              // print('isss');
                              // print(snapshot.data!.docs.length);
                              // print(snapshot.data!.docs.length);
                              // print(
                              //     '${snapshot.data!.docs[i]['name'].toString()}');
                              // print("Added to Order");
                              // print(
                              //     "${snapshot.data!.docs[i]['name'].toString()}");

                            }

                            if (snapshot.data == null) {
                              return Center(
                                child: Column(
                                  children: [
                                    CircularProgressIndicator(),
                                  ],
                                ),
                              );
                            }

                            return Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),

                                  for (int i = 0;
                                      i < snapshot.data!.docs.length;
                                      i++)
                                    ListTile(
                                      leading: Container(
                                        height: 70,
                                        width: 70,
                                        child: Image.network(
                                            '${snapshot.data!.docs[i]['images'].toString()} ',
                                            fit: BoxFit.fill),
                                      ),
                                      title: Wrap(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                '${snapshot.data!.docs[i]['name'].toString()}:',
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                " ${snapshot.data!.docs[i]['quantity'].toString()}",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 255, 119, 0)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      subtitle: Text(
                                        " ${snapshot.data!.docs[i]['sumprice'].toString()}฿",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 255, 119, 0)),
                                      ),
                                    ),

                                  // ListTile(
                                  //   leading: Container(
                                  //     height: 100,
                                  //     width: 100,
                                  //     child: Image.network(
                                  //         '${snapshot.data!.docs[0]['name'].toString()}',
                                  //         fit: BoxFit.fill),
                                  //   ),
                                  //   title: Wrap(
                                  //     children: [
                                  //       Text(
                                  //         '${snapshot.data!.docs[0]['sumprice'].toString()}',
                                  //         overflow: TextOverflow.ellipsis,
                                  //       ),
                                  //     ],
                                  //   ),
                                  //   subtitle: Text(
                                  //     '${snapshot.data!.docs[0]['name'].toString()}',
                                  //     style: TextStyle(
                                  //         fontWeight: FontWeight.bold,
                                  //         color:
                                  //             Color.fromARGB(255, 255, 119, 0)),
                                  //   ),
                                  // ),

                                  // Text('${snapshot.data!.docs[0]['name'].toString()}' +
                                  //     '   ${snapshot.data!.docs[0]['quantity'].toString()}' +
                                  //     '   ${snapshot.data!.docs[0]['sumprice'].toString()}'),
                                  // Text(
                                  //     '${snapshot.data!.docs[1]['name'].toString()}'),

                                  SizedBox(height: 20),
                                  SizedBox(height: 20),
                                  SizedBox(height: 20),
                                  Center(
                                    child: Text("ราคาที่ต้องจ่ายทั้งหมด " +
                                        totalxs.toString().trim() +
                                        " บาท"),
                                  ),
                                  SizedBox(height: 2),
                                  Center(
                                    child: ElevatedButton(
                                        child: Wrap(
                                          children: [
                                            Text(
                                              "เก็บเงินปลายทาง",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255)),
                                            ),
                                            SizedBox(
                                              width: 0,
                                            ),
                                          ],
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: Color.fromARGB(
                                              215, 188, 187, 187),
                                          elevation: 3,
                                        ),
                                        onPressed: () async => {
                                              showDialog(
                                                  context: context,
                                                  builder: (_) => AlertDialog(
                                                        content: Text(
                                                            "ยืนยื่นคำสั่งชื้อ"),
                                                        actions: [
                                                          MaterialButton(
                                                            onPressed:
                                                                () async => {
                                                              Navigator.pop(
                                                                  context),
                                                              Navigator.pop(
                                                                  context),
                                                              // for (int i = 0;
                                                              //     i <
                                                              //         snapshot
                                                              //             .data!
                                                              //             .docs
                                                              //             .length;
                                                              //     i++)
                                                              // for (int i = 0;
                                                              //     i <
                                                              //         snapshot
                                                              //             .data!
                                                              //             .docs
                                                              //             .length;
                                                              //     i++)
                                                              // for (int i = 0;
                                                              //     i <=
                                                              //         snapshot
                                                              //             .data!
                                                              //             .docs
                                                              //             .length;
                                                              //     i++)

                                                              addtoOrder(),
                                                              addtostatus(),
                                                              adddelete(),

                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  backgroundColor:
                                                                      Color.fromARGB(
                                                                          255,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  /////////////////////////////ข้อความเตื่อน
                                                                  content: Text(
                                                                    "กรุณาไปยังหน้าOrderเพื่อติดตามการดำเนินการ",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            },
                                                            child: Text("ใช่"),
                                                          ),
                                                          MaterialButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text("ไม่"),
                                                          ),
                                                        ],
                                                      )),
                                            }),
                                  ),
                                  Center(
                                    child: ElevatedButton(
                                        child: Wrap(
                                          children: [
                                            Text(
                                              "ตัดบัตรเครดิต",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255)),
                                            ),
                                            SizedBox(
                                              width: 18,
                                            ),
                                          ],
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: Color.fromARGB(
                                              215, 188, 187, 187),
                                          elevation: 3,
                                        ),
                                        onPressed: () async => {
                                              showDialog(
                                                  context: context,
                                                  builder: (_) => AlertDialog(
                                                        content: Text(
                                                            "ยืนยื่นคำสั่งชื้อ"),
                                                        actions: [
                                                          MaterialButton(
                                                            onPressed:
                                                                () async => {
                                                              Navigator.pop(
                                                                  context),
                                                              Navigator.pop(
                                                                  context),
                                                              // for (int i = 0;
                                                              //     i <
                                                              //         snapshot
                                                              //             .data!
                                                              //             .docs
                                                              //             .length;
                                                              //     i++)
                                                              // for (int i = 0;
                                                              //     i <
                                                              //         snapshot
                                                              //             .data!
                                                              //             .docs
                                                              //             .length;
                                                              //     i++)
                                                              // for (int i = 0;
                                                              //     i <=
                                                              //         snapshot
                                                              //             .data!
                                                              //             .docs
                                                              //             .length;
                                                              //     i++)

                                                              addtoidorder(),
                                                              adddelete(),

                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  backgroundColor:
                                                                      Color.fromARGB(
                                                                          255,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  /////////////////////////////ข้อความเตื่อน
                                                                  content: Text(
                                                                    "กรุณาไปยังหน้าOrderเพื่อติดตามการดำเนินการ",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            },
                                                            child: Text("ใช่"),
                                                          ),
                                                          MaterialButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text("ไม่"),
                                                          ),
                                                        ],
                                                      )),
                                            }),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
