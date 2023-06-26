import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class total extends StatefulWidget {
  const total({Key? key}) : super(key: key);

  @override
  State<total> createState() => _totalState();
}

class _totalState extends State<total> {
  int totalxs = 0;
  @override
  Widget build(BuildContext context) {
    body:
    return Column(
      children: <Widget>[
        Column(
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Total")
                    .doc(FirebaseAuth.instance.currentUser!.email)
                    .collection("Total")
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  // for (int i = 0; i < snapshot.data!.docs.length; i++)
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
                  // print('${snapshot.data!.docs[i]['name'].toString()}');

                  // print('isss');
                  // print(snapshot.data!.docs.length);
                  // print(snapshot.data!.docs.length);
                  // print(
                  //     '${snapshot.data!.docs[i]['name'].toString()}');
                  // print("Added to Order");
                  // print(
                  //     "${snapshot.data!.docs[i]['name'].toString()}");

                  if (snapshot.data == null) {
                    return Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                        ],
                      ),
                    );
                  }

                  return Text(totalxs.toString().trim());
                }),
          ],
        ),
      ],
    );
  }
}
