import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Cart/cart_data.dart';
import 'package:flutter_application_3/constants/colors.dart';
import 'package:flutter_application_3/search/search_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  var _product;
  ProductScreen(this._product);
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  // final TextStyle myStyle = TextStyle(
  //   fontSize: 18,
  // );

  int count = 1;
  int count2 = 2;

  Future addtoCart() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-cart-items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc(widget._product["products-id"])
        .set({
      "id": widget._product["products-id"],
      "name": widget._product["products-name"],
      "price": widget._product["products-price"],
      "images": widget._product["products-image"],
      "market": widget._product["products-market"],
      "time": "",
      "status": "กำลังดำเนินการ",
      "quantity": '${count.toString()}',
      "sumprice": widget._product["products-price"],
    }).then((value) => print("Added to cart"));
  }

  Future addtoFavourite() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-favourite-items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc(widget._product["products-id"])
        .set({
      "id": widget._product["products-id"],
      "name": widget._product["products-name"],
      "price": widget._product["products-price"],
      "images": widget._product["products-image"],
      "market": widget._product["products-market"],
    }).then((value) => print("Added to favourite"));
  }

  // Future addtoQuantity() async {
  //   final FirebaseAuth _auth = FirebaseAuth.instance;
  //   var currentUser = _auth.currentUser;
  //   CollectionReference _collectionRef =
  //       FirebaseFirestore.instance.collection("users-quantity-items");
  //   return _collectionRef
  //       .doc(currentUser!.email)
  //       .collection("quantity")
  //       .doc("Azaq7KKJCoGLCHXnkb2i")
  //       .update({'quantity': '${count.toString()}'});
  // }

  @override
  Widget build(BuildContext context) {
    int TT =
        int.parse('${widget._product['products-price'].toString()}') * count;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 221, 221, 221),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users-favourite-items")
                .doc(FirebaseAuth.instance.currentUser!.email)
                .collection("items")
                .where("name", isEqualTo: widget._product['products-name'])
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Text("");
              }
              return IconButton(
                onPressed: () => snapshot.data.docs.length == 0
                    ? addtoFavourite()
                    : print("กำลังเพิ่มข้อมูล"),
                icon: snapshot.data.docs.length == 0
                    ? Icon(
                        Icons.favorite_outline,
                        color: Color.fromARGB(255, 0, 0, 0),
                      )
                    : Icon(
                        Icons.favorite,
                        color: Color.fromARGB(255, 255, 1, 1),
                      ),
              );
            },
          ),
          IconButton(
              icon: const Icon(
                Icons.local_grocery_store_outlined,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              onPressed: () {
                print('');

                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => Cart()));
              }),
        ],
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
                    widget._product['products-image'].toString(),
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
                            widget._product['products-name'].toString(),
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
                                  '$TT฿',

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

                      SizedBox(
                        height: 12,
                      ),

                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      //   child: SizedBox(
                      //     height: 40,
                      //     width: 220,
                      //     child: ElevatedButton(
                      //         child: Text(
                      //           widget._product['products-market'].toString(),
                      //           textAlign: TextAlign.left,
                      //           style: TextStyle(
                      //             color: Color.fromARGB(255, 0, 0, 0),
                      //             fontSize: 15,
                      //           ),
                      //         ),
                      //         style: ElevatedButton.styleFrom(
                      //           primary: Color.fromARGB(255, 255, 255, 255),
                      //           elevation: 0,
                      //         ),
                      //         onPressed: () async => {
                      //               addtoCart(),
                      //               Fluttertoast.showToast(
                      //                 msg: "เพิ่มสินค้าแล้ว".toString(),
                      //               )
                      //             }),
                      //   ),
                      // ),
                      SizedBox(
                        height: 100,
                      ),
                      SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: ElevatedButton(
                            child: Text(
                              "เพิ่มไปยังตระกร้า",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey,
                              elevation: 3,
                            ),
                            onPressed: () async => {
                                  // Navigator.of(context).pushReplacement(
                                  //     MaterialPageRoute(builder: (_) {
                                  //   return Cart();
                                  // })),
                                  addtoCart(),
                                  Fluttertoast.showToast(
                                    msg: "เพิ่มสินค้าแล้ว".toString(),
                                  )
                                }),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 80,
                              ),
                              // IconButton(
                              //   icon: const Icon(Icons.remove),
                              //   onPressed: () {
                              //     setState(() {
                              //       if (count > 0) {
                              //         count--;
                              //       }
                              //     });
                              //     addtoQuantity();
                              //   },
                              // ),
                              SizedBox(
                                width: 15,
                              ),
                              // Text(
                              //   count.toString(),
                              //   style: TextStyle(
                              //     color: Color.fromARGB(255, 1, 1, 1),
                              //     fontSize: 15,
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              // ),
                              SizedBox(
                                width: 15,
                              ),
                              // IconButton(
                              //   icon: const Icon(Icons.add),
                              //   onPressed: () {
                              //     setState(() {
                              //       count++;
                              //     });
                              //     addtoQuantity();
                              //   },
                              // ),
                              SizedBox(
                                width: 30,
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Row(
                      //   children: [
                      //     Container(
                      //       padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(10),
                      //           color: Color.fromARGB(255, 111, 111, 111)),
                      //       child: Row(
                      //         children: [
                      //           Icon(
                      //             Icons.remove,
                      //             color: Color.fromARGB(255, 255, 255, 255),
                      //           ),
                      //           SizedBox(
                      //             width: 15,
                      //           ),
                      //           Text(
                      //             '0',
                      //             style: TextStyle(
                      //               color: Color.fromARGB(255, 255, 255, 255),
                      //               fontSize: 15,
                      //               fontWeight: FontWeight.bold,
                      //             ),
                      //           ),
                      //           SizedBox(
                      //             width: 15,
                      //           ),
                      //           Icon(
                      //             Icons.add,
                      //             color: Color.fromARGB(255, 255, 254, 254),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
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
