import "dart:io";

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ShopTotal extends StatefulWidget {
  const ShopTotal({Key? key}) : super(key: key);

  @override
  State<ShopTotal> createState() => _ShopTotalState();
}

class _ShopTotalState extends State<ShopTotal> {
  int count = 1;
  var now = DateTime.now();
  List _order = [];

  @override
  Widget build(BuildContext context) {
    int totalxs = 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(215, 188, 187, 187),
        elevation: 10,
        title: Text("รายได้ทั้งหมด",
            style: TextStyle(
              fontSize: 18,
            )),
        centerTitle: true,
        actions: [],
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
                              .collection("order-userfood@gmail.com")
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 345),
                                    Text(
                                      "รายได้ทั้งหมด " +
                                          totalxs.toString().trim() +
                                          " บาท",
                                      style: TextStyle(
                                          fontSize: 24, color: Colors.orange),
                                    ),
                                  ],
                                ),
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
