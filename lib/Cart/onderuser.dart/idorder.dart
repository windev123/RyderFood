import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class idorder extends StatefulWidget {
  @override
  State<idorder> createState() => _idorderState();
}

class _idorderState extends State<idorder> {
  int totalxs = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(215, 188, 187, 187),
        elevation: 10,
        title: Text("รายการ",
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
                              .collection("id-order")
                              .doc()
                              .collection("id-product")
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
                                  SizedBox(height: 20),
                                  SizedBox(height: 20),
                                  SizedBox(height: 20),
                                  Center(
                                    child: Text("ราคาที่ต้องจ่ายทั้งหมด " +
                                        totalxs.toString().trim() +
                                        " บาท"),
                                  ),
                                  SizedBox(height: 2),
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
