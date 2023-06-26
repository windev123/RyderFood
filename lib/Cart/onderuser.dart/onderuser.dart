import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Cart/onderuser.dart/OrderHistory.dart';
import 'package:flutter_application_3/Home.dart';
import 'package:flutter_application_3/UserShop/ChangePassShop.dart';
import 'package:flutter_application_3/UserShop/ContactScreenShop.dart';
import 'package:flutter_application_3/UserShop/Edit_profileShop.dart';
import 'package:flutter_application_3/download%20page/download_page.dart';
import 'package:flutter_application_3/user/ConTact.dart';
import 'package:flutter_application_3/user/Edit_profile.dart';
import 'package:flutter_application_3/user/change_pass.dart';
import 'package:flutter_application_3/user/historyuser.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class OrderUser extends StatefulWidget {
  const OrderUser({Key? key}) : super(key: key);

  @override
  State<OrderUser> createState() => _OrderUserState();
}

class _OrderUserState extends State<OrderUser> {
  TextEditingController? _statusController;
  // TextEditingController? _marketController;
  setDataToTextField(data) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      SizedBox(
        height: 65,
      ),
      Center(
        child: Column(children: <Widget>[
          Image.network(data["image"], fit: BoxFit.fill),
        ]),
      ),
      Center(
        child: Column(
          children: [
            Container(
              child: Center(
                child: Stack(
                  children: <Widget>[
                    // Stroked text as border.
                    Text(
                      data['status'],
                      style: TextStyle(
                        fontSize: 18,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 4
                          ..color = Colors.grey[700]!,
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      data['status'],
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 220, 220, 0),
              child: Column(
                children: [
                  ElevatedButton(
                      child: Wrap(
                        children: [
                          Text(
                            "ประวัติการสั่งชื้อ",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                          SizedBox(
                            width: 18,
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(215, 188, 187, 187),
                        elevation: 3,
                      ),
                      onPressed: () async => {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => HistoryUser())),
                          }),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(0, 0, 210, 0),
            //   child: Column(
            //     children: [
            //       ElevatedButton(
            //           child: Wrap(
            //             children: [
            //               Text(
            //                 "รายการอาหาร",
            //                 style: TextStyle(
            //                     fontSize: 15,
            //                     color: Color.fromARGB(255, 255, 255, 255)),
            //               ),
            //               SizedBox(
            //                 width: 25,
            //               ),
            //             ],
            //           ),
            //           style: ElevatedButton.styleFrom(
            //             primary: Color.fromARGB(215, 188, 187, 187),
            //             elevation: 3,
            //           ),
            //           onPressed: () async => {
            //                 Navigator.of(context).push(MaterialPageRoute(
            //                     builder: (_) => OrderHistoryyUser())),
            //               }),
            //     ],
            //   ),
            // ),
          ],
        ),
      )
    ]);
  }

  updateData() {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("status");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update({
      "status": _statusController!.text,
    }).then((value) => print("Updated Successfully"));
  }

  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 252, 252, 252),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(215, 188, 187, 187),
          elevation: 10,
          title: Text("รายการ",
              style: TextStyle(
                fontSize: 18,
              )),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.message),
              tooltip: 'Go to the next page',
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              //   child: Image.asset(
              //     'images/15FT.jpg',
              //   ),
              // ),
              Wrap(
                children: [
                  Container(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("status")
                          .doc(FirebaseAuth.instance.currentUser!.email)
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        var data = snapshot.data;

                        if (data == null) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return setDataToTextField(data);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  // Widget _listTiles({
  //   required String title,
  //   String? subtitle,
  //   required IconData icon,
  //   required Function onPressed,
  // }) {
  //   return ListTile(
  //     title: Text(
  //       title,
  //       style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //     ),
  //     subtitle: Text(subtitle == null ? "" : subtitle),
  //     leading: Icon(icon),
  //     trailing: const Icon(Icons.arrow_right),
  //     onTap: () {
  //       onPressed();
  //     },
  //   );
  // }
}
