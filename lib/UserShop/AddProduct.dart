import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/UserShop/AddProduct/Drink.dart';
import 'package:flutter_application_3/UserShop/ScreenShop.dart';
import 'package:flutter_application_3/UserShop/data_controller.dart';
import 'package:flutter_application_3/UserShop/product_image_picker.dart';
import 'package:get/get.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);
  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
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
          .collection('products')
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
          "เพิ่มอาหารเรียบร้อย",
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
            "กรุณาเลือกรูปภาพอาหารครับ",
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
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(215, 188, 187, 187),
        elevation: 10,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
          child: Row(
            children: [
              Image.asset(
                'images/RF.png',
                height: 73,
              ),
              SizedBox(
                width: 50,
              ),
              Text(
                "ADD FOOD",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 248, 247, 247)),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Container(
              width: 600,
              height: 223,
              child: Image.asset("images/Food01.jpg"),
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
                            labelText: 'ID:อาหาร',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากำหนดIDอาหาร';
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
                            labelText: 'ชื่อ:อาหาร',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณาป้อนชื่ออาหาร';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            productData['name'] = value!;
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: 'ราคา:อาหาร'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณาป้อนราคาอาหาร';
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
                        ProductImagePicker(_pickedImage),
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
                                      "เพิ่มอาหาร",
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
                            // Container(
                            //   height: 100,
                            //   width: 900,
                            //   color: Color.fromARGB(255, 255, 255, 255),
                            //   child: Padding(
                            //     padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            //     child: Padding(
                            //       padding:
                            //           const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            //       child: Row(
                            //         children: [
                            //           ElevatedButton(
                            //             style: ElevatedButton.styleFrom(
                            //               primary: Color.fromARGB(
                            //                   255, 148, 148, 148), // background
                            //               onPrimary: Color.fromARGB(
                            //                   255, 255, 255, 255), // foreground
                            //             ),
                            //             onPressed: () {},
                            //             child: Text('ขนม'),
                            //           ),
                            //           // RaisedButton(
                            //           //   onPressed: () {
                            //           //     print("ขนม");
                            //           //   },
                            //           //   color:
                            //           //       Color.fromARGB(255, 255, 255, 255),
                            //           //   child: Container(
                            //           //     height: 70,
                            //           //     width: 60,
                            //           //     child: Column(
                            //           //       children: [
                            //           //         Padding(
                            //           //           padding:
                            //           //               const EdgeInsets.fromLTRB(
                            //           //                   0, 3, 0, 0),
                            //           //           child: Container(
                            //           //             height: 50,
                            //           //             width: 60,
                            //           //             color: Color.fromARGB(
                            //           //                 255, 192, 192, 192),
                            //           //             child: Column(
                            //           //               children: [
                            //           //                 Container(
                            //           //                   child: Padding(
                            //           //                     padding:
                            //           //                         const EdgeInsets
                            //           //                                 .fromLTRB(
                            //           //                             0, 0, 0, 0),
                            //           //                     child: Container(
                            //           //                       height: 45,
                            //           //                       width: 100,
                            //           //                       decoration: BoxDecoration(
                            //           //                           image: DecorationImage(
                            //           //                               image: AssetImage(
                            //           //                                 'images/K.png',
                            //           //                               ),
                            //           //                               fit: BoxFit.cover)),
                            //           //                     ),
                            //           //                   ),
                            //           //                 ),
                            //           //               ],
                            //           //             ),
                            //           //           ),
                            //           //         ),
                            //           //         Text(
                            //           //           "ขนม",
                            //           //           style: TextStyle(
                            //           //               fontSize: 9,
                            //           //               color: Color.fromARGB(
                            //           //                   255, 0, 0, 0)),
                            //           //         ),
                            //           //       ],
                            //           //     ),
                            //           //   ),
                            //           // ),
                            //           SizedBox(
                            //             width: 200,
                            //           ),
                            //           ElevatedButton(
                            //             style: ElevatedButton.styleFrom(
                            //               primary: Color.fromARGB(
                            //                   255, 148, 148, 148), // background
                            //               onPrimary: Color.fromARGB(
                            //                   255, 255, 255, 255), // foreground
                            //             ),
                            //             onPressed: () {
                            //               print("เครื่องดื่ม");
                            //               Navigator.pushReplacement(
                            //                   context,
                            //                   MaterialPageRoute(
                            //                       builder: (_) => Drink()));
                            //             },
                            //             child: Text('เครื่องดื่ม'),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
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
