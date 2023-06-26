import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/UserShop/AddProduct/drink_image.dart';
import 'package:flutter_application_3/UserShop/ScreenShop.dart';
import 'package:flutter_application_3/UserShop/data_controller.dart';
import 'package:flutter_application_3/UserShop/product_image_picker.dart';
import 'package:get/get.dart';

class Drink extends StatefulWidget {
  const Drink({Key? key}) : super(key: key);
  @override
  State<Drink> createState() => _DrinkState();
}

class _DrinkState extends State<Drink> {
  TextEditingController _marketController = TextEditingController();
  final firebaseInstance = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addNewProduct(Map productdata, File image) async {
    //  Map <String,dynamic> = map.Map();

    var pathimage = image.toString();
    var temp = pathimage.lastIndexOf('/');
    var result = pathimage.substring(temp + 1);
    print(result);
    final ref =
        FirebaseStorage.instance.ref().child('product_images').child(result);
    var response = await ref.putFile(image);
    print("Updated $response");
    var imageUrl = await ref.getDownloadURL();
    var currentUser = _auth.currentUser;
    Random random = Random();
    int tt = random.nextInt(10000);
    Map<String, dynamic> map = Map();
    map['id'] = productdata['id'];
    map['id_product'] = tt.toString();
    map['email'] = currentUser!.email;
    map["market"] = currentUser.email;
    map['image'] = imageUrl;
    map['name'] = productdata['name'];
    map['price'] = productdata['price'];

    try {
      var currentUser = _auth.currentUser;
      var response = await firebaseInstance
          .collection('drink')
          .doc(tt.toString())
          .set(map)
          .then(
        (value) {
          print(tt);
        },
      );
      print("Firebase response1111 $response");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        content: Text(
          "เพิ่มเครื่องดื่มเรียบร้อย",
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ));
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) {
          return ScreenShop();
        }),
      );
    } catch (exception) {
      print("Error Saving Data at firestore $exception");
    }
  }

  var _userImageFile;
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> productData = {
    "id": "",
    "market": "",
    "name": "",
    "price": "",
    "quantity": "",
    "email": "",
  };

  void _pickedImage(File image) {
    _userImageFile = image;
    print("Image got $_userImageFile");
  }

  addProduct() {
    if (_userImageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color.fromARGB(255, 250, 0, 0),
          content: Text(
            "กรุณาเลือกรูปภาพเครื่องดื่ม ครับ",
            style: TextStyle(
              fontSize: 13,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
      );
      return;
    }

    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      print("Form is vaid ");

      print('Data for for new product $productData');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 172, 172, 172),
        elevation: 10,
        title: Row(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 0, 0, 0),
            child: Text("ADD DRINK"),
          )
        ]),
        leading: BackButton(
          onPressed: () {
            print('');
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) {
                return ScreenShop();
              }),
            );
          },
        ),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 600,
              height: 223,
              child: Image.asset("images/AD.jpg"),
              color: Color.fromARGB(255, 7, 7, 7),
            ),
            Container(
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        SizedBox(
                          height: 0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'ID:เครื่องดื่ม',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากำหนดID:เครื่องดื่ม';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            productData['id'] = value!;
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'ชื่อ:เครื่องดื่ม',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณาป้อนชื่อ:เครื่องดื่ม';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            productData['name'] = value!;
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration:
                              InputDecoration(labelText: 'ราคา:เครื่องดื่ม'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณาป้อนราคา:เครื่องดื่ม';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            productData['price'] = value!;
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        DrinkImagePicker(_pickedImage),
                        SizedBox(
                          height: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 45,
                              width: 300,
                              child: ElevatedButton(
                                child: Wrap(
                                  children: [
                                    Text(
                                      "เพิ่มเครื่องดื่ม",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(215, 188, 187, 187),
                                  elevation: 3,
                                ),
                                onPressed: () {
                                  addProduct();
                                  addNewProduct(productData, _userImageFile);
                                },
                              ),
                              // child: ElevatedButton(
                              //   onPressed: () {
                              //     addProduct();
                              //     addNewProduct(productData, _userImageFile);
                              //   },
                              //   child: Text('ดำเนินการต่อ'),
                              // ),
                            ),
                            SizedBox(
                              height: 0,
                            ),
                          ],
                        ),
                      ],
                    ),
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
