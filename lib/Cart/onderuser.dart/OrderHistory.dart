import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Cart/onderuser.dart/idorder.dart';
import 'package:flutter_application_3/Cart/orderuser.dart';
import 'package:flutter_application_3/user/Edit_profile.dart';

class OrderHistoryyUser extends StatefulWidget {
  const OrderHistoryyUser({Key? key}) : super(key: key);

  @override
  _OrderHistoryyUserState createState() => _OrderHistoryyUserState();
}

class _OrderHistoryyUserState extends State<OrderHistoryyUser> {
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
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("id-order").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            final userSnapshot = snapshot.data?.docs;
            if (userSnapshot!.isEmpty) {
              return const Text("no data");
            }
            return ListView.builder(
                itemCount: userSnapshot.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(userSnapshot[index]["order-id"]),
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => idorder()));
                      print(userSnapshot[index]["order-id"]);
                    },
                  );
                });
          }),
    );
  }
}
