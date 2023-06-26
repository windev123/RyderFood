import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProductUser extends StatefulWidget {
  var _userproducts;
  EditProductUser(this._userproducts);

  @override
  State<EditProductUser> createState() => _EditProductUserState();
}

class _EditProductUserState extends State<EditProductUser> {
  TextEditingController? _productsnameController;
  TextEditingController? _productspriController;
  var _firestoreInstance = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 221, 221, 221),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, bottom: 0, top: 0),
              child: Row(
                children: <Widget>[],
              ),
            ),
            Center(
              child: Container(
                width: double.infinity,
                child: Image.network(
                    widget._userproducts['products-image'].toString(),
                    height: 300,
                    width: 500,
                    fit: BoxFit.fill),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(70),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Wrap(
                        alignment: WrapAlignment.start,
                        children: [
                          Text(
                            widget._userproducts['products-name'].toString(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              alignment: WrapAlignment.start,
                              children: [
                                Text(
                                  "${widget._userproducts['products-price'].toString()}฿",

                                  // "${widget._product['products-price'].toString()}฿",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 245, 123, 9),
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color.fromARGB(
                                              255, 255, 254, 254)),
                                      child: Row(
                                        children: [],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
