import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Cart/orderuser.dart';
import 'package:flutter_application_3/user/Edit_profile.dart';

import 'order.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  int count = 1;
  int coun2 = 2;
  int totalx = 0;
  int totalx1 = 0;
  int totalx2 = 2;
  int totalx3 = 20;
  Random random = Random();

  // Future<Null> readDataaa() async {
  //   StreamBuilder(
  //       stream: FirebaseFirestore.instance
  //           .collection("users-cart-items")
  //           .doc(FirebaseAuth.instance.currentUser!.email)
  //           .collection("items")
  //           .snapshots(),
  //       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //         // DocumentSnapshot _documentSnapshot =
  //         //               snapshot.data!.docs[index];
  //         for (int i = 0; i < snapshot.data!.docs.length; i++) {
  //           total = total +
  //               int.parse('${snapshot.data!.docs[i]['sumprice'].toString()}');
  //         }
  //         if (snapshot.data != null) {
  //           return Text('${total.toString()}');
  //         }
  //         return Text('data');
  //       });
  // }
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(215, 188, 187, 187),
        elevation: 10,
        title: Text("ตระกร้าสินค้า",
            style: TextStyle(
              fontSize: 18,
            )),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.local_grocery_store_outlined),
            tooltip: 'Go to the next page',
            onPressed: () {
              print('');

              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => Cart()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.message),
            tooltip: 'Go to the next page',
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Color.fromARGB(255, 255, 255, 255),
            height: 410,
            width: double.infinity,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users-cart-items")
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .collection("items")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                // Future addtoIDOrder() async {
                //   final FirebaseAuth _auth = FirebaseAuth.instance;
                //   var currentUser = _auth.currentUser;
                //   int tt = random.nextInt(10000);
                //   CollectionReference _collectionRef =
                //       FirebaseFirestore.instance.collection("order");
                //   {
                //     _collectionRef
                //         .doc(currentUser!.email)
                //         .collection(tt.toString())
                //         .doc()
                //         .set({
                //       "IDOrder": tt.toString(),
                //     }).then((value) => print("status"));
                //   }
                // }
                // for (int i = 0; i < snapshot.data!.docs.length; i++) {
                //   totalx = ((totalx +
                //       int.parse(
                //           '${snapshot.data!.docs[i]['sumprice'].toString()}')));
                //   // totalx = ((totalx +
                //   //             double.parse(
                //   //                 '${snapshot.data!.docs[i]['sumprice'].toString()}')) *
                //   //         double.parse('0.5')) +
                //   //     20;
                //   // totalx1 = (totalx1 + totalx) + 2;
                //   //     int.parse(
                //   //         '${snapshot.data!.docs[i]['sumprice'].toString()}');
                //   print('จำนวน');
                //   print(i);
                //   print('ราคาทั้งหมด');
                //   print(totalx.toString().trim());
                //   print('ราคาล่าสุด');
                //   print('${snapshot.data!.docs[i]['sumprice'].toString()}');
                // }

                if (snapshot.data == null) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (_, index) {
                      DocumentSnapshot _documentSnapshot =
                          snapshot.data!.docs[index];

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: InkWell(
                              onTap: () {
                                // for (int i = 0; i < 5; i++)
                                //   setState(() {
                                //     total = total + i;
                                //   });

                                print('{_documentSnapshot[index]');
                                print('${_documentSnapshot['name']}');
                                print('${_documentSnapshot['id']}');
                              },
                              child: Card(
                                elevation: 6,
                                child: ListTile(
                                  leading: Container(
                                    height: 70,
                                    width: 70,
                                    child: Image.network(
                                        _documentSnapshot["images"],
                                        fit: BoxFit.fill),
                                  ),
                                  title: Wrap(
                                    children: [
                                      Text(
                                        _documentSnapshot['name'],
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(
                                    " ${_documentSnapshot['sumprice']}฿",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 255, 119, 0)),
                                  ),
                                  trailing: Wrap(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: IconButton(
                                            onPressed: () {
                                              ////////////////////////////////////////---------------------
                                              int TT = int.parse(
                                                      '${_documentSnapshot['sumprice']} ') +
                                                  int.parse(
                                                      '${_documentSnapshot['price']} ');
                                              ////////////////////////////////////////---------------------
                                              int NewQty = int.parse(
                                                      '${_documentSnapshot['quantity']}') +
                                                  1;
                                              ////////////////////////////////////////---------------------
                                              setState(() {
                                                totalx = 0;
                                              });
                                              if (int.parse(
                                                      '${_documentSnapshot['quantity']}') >
                                                  0) {
                                                FirebaseFirestore.instance
                                                    .collection(
                                                        "users-cart-items")
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser!.email)
                                                    .collection("items")
                                                    .doc(
                                                        '${_documentSnapshot['id'].toString().trim()}')
                                                    .update({
                                                  'quantity':
                                                      '${NewQty.toString()}',
                                                  'sumprice':
                                                      '${TT.toString().trim()}'
                                                });

                                                //////////////-------------------------

                                                for (int i = 0;
                                                    i <
                                                        snapshot
                                                            .data!.docs.length;
                                                    i++) {
                                                  setState(() {
                                                    totalx = ((totalx +
                                                        int.parse(
                                                            '${snapshot.data!.docs[i]['sumprice'].toString()}')));
                                                  });
                                                }
                                                if (int.parse(
                                                        '${_documentSnapshot['quantity']}') ==
                                                    1) {
                                                  setState(() {
                                                    totalx = totalx +
                                                        int.parse(
                                                            '${_documentSnapshot['price'].toString()}');
                                                  });
                                                } else {
                                                  // print(
                                                  //     '${snapshot.data!.docs[index]}');
                                                  totalx = totalx +
                                                      int.parse(
                                                          '${_documentSnapshot['price'].toString()}');
                                                }

                                                print('ราคาทั้งหมด');
                                                print(totalx.toString().trim());
                                              } else {
                                                print(
                                                    '  **********************  No  update ');
                                              }
                                            },
                                            icon: Icon(Icons.add)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 14, 0, 0),
                                        child: Text(
                                            '${_documentSnapshot['quantity']}'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: IconButton(
                                            onPressed: () {
                                              int NewQty = 0;
                                              ///////------------------------------
                                              int TT = int.parse(
                                                      '${_documentSnapshot['sumprice']} ') -
                                                  int.parse(
                                                      '${_documentSnapshot['price']} ');
                                              ////////////////////////////////////////---------------------
                                              if (int.parse(
                                                      '${_documentSnapshot['quantity']}') >
                                                  1) {
                                                setState(() {
                                                  NewQty = int.parse(
                                                          '${_documentSnapshot['quantity']}') -
                                                      1;
                                                });
                                                FirebaseFirestore.instance
                                                    .collection(
                                                        "users-cart-items")
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser!.email)
                                                    .collection("items")
                                                    .doc(
                                                        '${_documentSnapshot['id'].toString().trim()}')
                                                    .update({
                                                  'quantity':
                                                      '${NewQty.toString()}',
                                                  'sumprice':
                                                      '${TT.toString().trim()}'
                                                });
                                              } else {
                                                FirebaseFirestore.instance
                                                    .collection(
                                                        "users-cart-items")
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser!.email)
                                                    .collection("items")
                                                    .doc(_documentSnapshot.id)
                                                    .delete();
                                              }

                                              ////////////////////////////////////////---------------------
                                              // (int.parse('${_documentSnapshot['quantity']}') <
                                              //         1)
                                              //     ? FirebaseFirestore.instance
                                              //         .collection(
                                              //             "users-cart-items")
                                              //         .doc(FirebaseAuth.instance
                                              //             .currentUser!.email)
                                              //         .collection("items")
                                              //         .doc(_documentSnapshot.id)
                                              //         .delete()
                                              //     : print(
                                              //         '********************** No delete ');
                                            },
                                            icon: Icon((int.parse(
                                                        '${_documentSnapshot['quantity']}') <
                                                    1)
                                                ? Icons.delete
                                                : Icons.remove_circle)),
                                      ),
                                    ],
                                  ),
                                  // trailing: Wrap(
                                  //   children: [
                                  //     GestureDetector(
                                  //       child: Icon(Icons.add),
                                  //       onTap: () async {
                                  //         print(
                                  //             'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
                                  //         print('{_documentSnapshot[index]');
                                  //         print('${_documentSnapshot['id']}');

                                  //         setState(() {
                                  //           count++;
                                  //         });

                                  //         int TT = int.parse(
                                  //                 '${_documentSnapshot['sumprice']} ') +
                                  //             int.parse(
                                  //                 '${_documentSnapshot['price']} ');

                                  //         final FirebaseAuth _auth =
                                  //             FirebaseAuth.instance;
                                  //         var currentUser = _auth.currentUser;
                                  //         CollectionReference _collectionRef =
                                  //             FirebaseFirestore.instance
                                  //                 .collection(
                                  //                     "users-cart-items");
                                  //         return _collectionRef
                                  //             .doc(currentUser!.email)
                                  //             .collection("items")
                                  //             .doc(
                                  //                 '${_documentSnapshot['id'].toString().trim()}')
                                  //             .update({
                                  //           'quantity': '${count.toString()}',
                                  //           'sumprice':
                                  //               '${TT.toString().trim()}'
                                  //         });
                                  //       },
                                  //     ),
                                  //     SizedBox(width: 10.0),
                                  //     Wrap(
                                  //       children: [
                                  //         Text(
                                  //             '${_documentSnapshot['quantity']}'),
                                  //       ],
                                  //     ),
                                  //     SizedBox(
                                  //       width: 10.0,
                                  //     ),
                                  //     GestureDetector(
                                  //       child: Icon(Icons.remove_circle),
                                  //       onTap: () async {
                                  //         // print(
                                  //         //     'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
                                  //         // print('{_documentSnapshot[index]');
                                  //         // print('${_documentSnapshot['id']}');
                                  //         // setState(() {
                                  //         //   count--;
                                  //         // });
                                  //         // int TT = int.parse(
                                  //         //         '${_documentSnapshot['sumprice']} ') -
                                  //         //     int.parse(
                                  //         //         '${_documentSnapshot['price']} ');
                                  //         // final FirebaseAuth _auth =
                                  //         //     FirebaseAuth.instance;
                                  //         // var currentUser = _auth.currentUser;
                                  //         // CollectionReference _collectionRef =
                                  //         //     FirebaseFirestore.instance
                                  //         //         .collection(
                                  //         //             "users-cart-items");
                                  //         // return _collectionRef
                                  //         //     .doc(currentUser!.email)
                                  //         //     .collection("items")
                                  //         //     .doc(
                                  //         //         '${_documentSnapshot['id'].toString().trim()}')
                                  //         //     .update({
                                  //         //   'quantity': '${count.toString()}',
                                  //         //   'sumprice':
                                  //         //       '${TT.toString().trim()}'
                                  //         // });
                                  //       },
                                  //     ),
                                  //     SizedBox(
                                  //       width: 10.0,
                                  //     ),
                                  //     GestureDetector(
                                  //       child: Icon(Icons.restore_from_trash),
                                  //       onTap: () {
                                  //         FirebaseFirestore.instance
                                  //             .collection("users-cart-items")
                                  //             .doc(FirebaseAuth
                                  //                 .instance.currentUser!.email)
                                  //             .collection("items")
                                  //             .doc(_documentSnapshot.id)
                                  //             .delete();
                                  //       },
                                  //     ),
                                  //   ],
                                  // ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              },
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              // Padding(
              //     padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              //     child: Row(
              //       children: [
              //         Text("ราคาทั้งหมด"),
              //         SizedBox(
              //           width: 170,
              //         ),
              //         StreamBuilder(
              //             stream:
              //                 Stream.periodic(const Duration(milliseconds: 0)),
              //             builder: (
              //               context,
              //               snapshot,
              //             ) {
              //               return Text(
              //                 '${totalx.toString().trim()}฿',
              //                 style: TextStyle(
              //                     fontWeight: FontWeight.bold,
              //                     color: Color.fromARGB(255, 255, 119, 0)),
              //               );

              //               // Text(totalx.toString().trim());
              //             }),
              //       ],
              //     )),
              // SizedBox(
              //   height: 20,
              // ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              //   child: Row(
              //     children: [
              //       Text("data"),
              //       SizedBox(
              //         width: 250,
              //       ),
              //       Text("data"),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              //   child: Row(
              //     children: [
              //       Text("data"),
              //       SizedBox(
              //         width: 250,
              //       ),
              //       Text("data"),
              //     ],
              //   ),
              // ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Color.fromARGB(255, 250, 250, 250),
            height: 66,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 0,
                ),
                ElevatedButton(
                    child: Wrap(
                      children: [
                        Text(
                          "ชำระเงิน",
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        SizedBox(
                          width: 0,
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(215, 188, 187, 187),
                      elevation: 3,
                    ),
                    onPressed: () async => {
                          print(''),
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => totalsreen())),
                        }),
              ],
            ),
          )
        ],
      ),
    );
  }
}



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// class Cart extends StatefulWidget {
//   const Cart({Key? key}) : super(key: key);

//   @override
//   _CartState createState() => _CartState();
// }

// class _CartState extends State<Cart> {
//   int count = 1;
//   int totalx = 0;
//   int totalx1 = 0;
//   int totalx2 = 2;
//   int totalx3 = 20;

//   final Future<FirebaseApp> firebase = Firebase.initializeApp();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(215, 188, 187, 187),
//         elevation: 10,
//         title: const Text("ตระกร้าสินค้า",
//             style: TextStyle(
//               fontSize: 18,
//             )),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.message),
//             tooltip: 'Go to the next page',
//             onPressed: () {
//               print('');
//             },
//           ),
//         ],
//       ),
//       body: SizedBox(
//         child: Column(children: [
//           Container(
//               color: Color.fromARGB(255, 255, 255, 255),
//               height: 410,
//               width: double.infinity,
//               child: StreamBuilder(
//                   stream: FirebaseFirestore.instance
//                       .collection("users-cart-items")
//                       .doc(FirebaseAuth.instance.currentUser!.email)
//                       .collection("items")
//                       .snapshots(),
//                   builder: (BuildContext context,
//                       AsyncSnapshot<QuerySnapshot> snapshot) {
//                     for (int i = 0; i < snapshot.data!.docs.length; i++) {
//                       totalx = ((totalx +
//                           int.parse(
//                               '${snapshot.data!.docs[i]['sumprice'].toString()}')));

//                       print('จำนวน');
//                       print(i);
//                       print('ราคาทั้งหมด');
//                       print(totalx.toString().trim());
//                       print('ราคาล่าสุด');
//                       print('${snapshot.data!.docs[i]['sumprice'].toString()}');
//                     }

//                     if (snapshot.data == null) {
//                       return const Center(child: CircularProgressIndicator());
//                     }

//                     return ListView.builder(
//                         itemCount: snapshot.data!.docs.length,
//                         itemBuilder: (_, index) {
//                           DocumentSnapshot _documentSnapshot =
//                               snapshot.data!.docs[index];

//                           return Card(
//                             elevation: 6,
//                             child: ListTile(
//                                 leading: Image.network(
//                                     _documentSnapshot["images"],
//                                     fit: BoxFit.fill),
//                                 title: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(
//                                     _documentSnapshot['name'],
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                                 subtitle: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(
//                                     " ${_documentSnapshot['sumprice']}฿",
//                                     style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color:
//                                             Color.fromARGB(255, 255, 119, 0)),
//                                   ),
//                                 ),
//                                 trailing: Row(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: IconButton(
//                                           onPressed: () {
//                                             ////////////////////////////////////////---------------------
//                                             int TT = int.parse(
//                                                     '${_documentSnapshot['sumprice']} ') +
//                                                 int.parse(
//                                                     '${_documentSnapshot['price']} ');
//                                             ////////////////////////////////////////---------------------
//                                             int NewQty = int.parse(
//                                                     '${_documentSnapshot['quantity']}') +
//                                                 1;
//                                             ////////////////////////////////////////---------------------

//                                             (int.parse('${_documentSnapshot['quantity']}') !=
//                                                     1)
//                                                 ? FirebaseFirestore.instance
//                                                     .collection(
//                                                         "users-cart-items")
//                                                     .doc(FirebaseAuth.instance
//                                                         .currentUser!.email)
//                                                     .collection("items")
//                                                     .doc(
//                                                         '${_documentSnapshot['id'].toString().trim()}')
//                                                     .update({
//                                                     'quantity':
//                                                         '${NewQty.toString()}',
//                                                     'sumprice':
//                                                         '${TT.toString().trim()}' 
//                                                   })
//                                                 : print(
//                                                     '  **********************  No  update ');
//                                           },
//                                           icon: Icon(Icons.add)),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text(
//                                           '${_documentSnapshot['quantity']}'),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: IconButton(
//                                           onPressed: () {
//                                             int NewQty = 0;
//                                             ///////------------------------------
//                                             int TT = int.parse(
//                                                     '${_documentSnapshot['sumprice']} ') -
//                                                 int.parse(
//                                                     '${_documentSnapshot['price']} ');
//                                             ////////////////////////////////////////---------------------
//                                             if (int.parse(
//                                                     '${_documentSnapshot['quantity']}') >
//                                                 1) {
//                                               setState(() {
//                                                 NewQty = int.parse(
//                                                         '${_documentSnapshot['quantity']}') -
//                                                     1;
//                                               });

//                                               FirebaseFirestore.instance
//                                                   .collection(
//                                                       "users-cart-items")
//                                                   .doc(FirebaseAuth.instance
//                                                       .currentUser!.email)
//                                                   .collection("items")
//                                                   .doc(
//                                                       '${_documentSnapshot['id'].toString().trim()}')
//                                                   .update({
//                                                 'quantity':
//                                                     '${NewQty.toString()}',
//                                                 'sumprice':
//                                                     '${TT.toString().trim()}'
//                                               });
//                                             } else {
//                                               FirebaseFirestore.instance
//                                                   .collection(
//                                                       "users-cart-items")
//                                                   .doc(FirebaseAuth.instance
//                                                       .currentUser!.email)
//                                                   .collection("items")
//                                                   .doc(_documentSnapshot.id)
//                                                   .delete();
//                                             }

//                                             ////////////////////////////////////////---------------------
//                                             // (int.parse('${_documentSnapshot['quantity']}') <
//                                             //         1)
//                                             //     ? FirebaseFirestore.instance
//                                             //         .collection(
//                                             //             "users-cart-items")
//                                             //         .doc(FirebaseAuth.instance
//                                             //             .currentUser!.email)
//                                             //         .collection("items")
//                                             //         .doc(_documentSnapshot.id)
//                                             //         .delete()
//                                             //     : print(
//                                             //         '********************** No delete ');
//                                           },
//                                           icon: Icon((int.parse(
//                                                       '${_documentSnapshot['quantity']}') <
//                                                   1)
//                                               ? Icons.delete
//                                               : Icons.remove_circle)),
//                                     ),
//                                   ],
//                                 )),
//                           );
//                         });
//                   }))
//         ]),
//       ),
//     );
//   }
// }
