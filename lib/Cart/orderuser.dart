// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_3/user/Edit_profile.dart';
// import 'order.dart';

// class orderuser extends StatefulWidget {
//   const orderuser({Key? key}) : super(key: key);

//   @override
//   _orderuserState createState() => _orderuserState();
// }

// class _orderuserState extends State<orderuser> {
//   int count = 1;
//   int coun2 = 2;
//   int sum = 0;
//   int totalx2 = 2;
//   int totalx3 = 20;

//   // Future<Null> readDataaa() async {
//   //   StreamBuilder(
//   //       stream: FirebaseFirestore.instance
//   //           .collection("users-cart-items")
//   //           .doc(FirebaseAuth.instance.currentUser!.email)
//   //           .collection("items")
//   //           .snapshots(),
//   //       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//   //         // DocumentSnapshot _documentSnapshot =
//   //         //               snapshot.data!.docs[index];
//   //         for (int i = 0; i < snapshot.data!.docs.length; i++) {
//   //           sum = sum +
//   //               int.parse('${snapshot.data!.docs[i]['sumprice'].toString()}');
//   //         }
//   //         if (snapshot.data != null) {
//   //           return Text('${sum.toString()}');
//   //         }
//   //         return Text('data');
//   //       });
//   // }

//   final Future<FirebaseApp> firebase = Firebase.initializeApp();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(215, 188, 187, 187),
//         elevation: 10,
//         title: Text("ตระกร้าสินค้า",
//             style: TextStyle(
//               fontSize: 18,
//             )),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.local_grocery_store_outlined),
//             tooltip: 'Go to the next page',
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.message),
//             tooltip: 'Go to the next page',
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Container(
//             color: Color.fromARGB(255, 255, 255, 255),
//             height: 410,
//             width: double.infinity,
//             child: StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection("users-cart-items")
//                   .doc(FirebaseAuth.instance.currentUser!.email)
//                   .collection("items")
//                   .snapshots(),
//               builder: (BuildContext context,
//                   AsyncSnapshot<QuerySnapshot> snapshot) {
//                 for (int i = 0; i < snapshot.data!.docs.length; i++) {
//                   sum = sum +
//                       int.parse(
//                           '${snapshot.data!.docs[i]['sumprice'].toString()}');
//                   // total = total +
//                   //     int.parse(
//                   //         '${snapshot.data!.docs[i]['sumprice'].toString()}');
//                   print('จำนวน');
//                   print(i);
//                   print('ราคาล่าสุด');
//                   print('${snapshot.data!.docs[i]['sumprice'].toString()}');
//                   // print(totalxs.toString().trim());
//                   print('ราคาทั้งหมด');
//                   // print('${snapshot.data!.docs[i]['sumprice'].toString()}');
//                   print(sum.toString().trim());
//                   print('${snapshot.data!.docs[i]['name'].toString()}');
//                   print('isss');
//                   print('จำนวน');
//                   print(i);
//                   print('ราคาทั้งหมด');
//                   print(sum.toString().trim());
//                   print('ราคาล่าสุด');
//                   print('${snapshot.data!.docs[i]['sumprice'].toString()}');
//                 }

//                 if (snapshot.data == null) {
//                   return Center(child: CircularProgressIndicator());
//                 }

//                 return ListView.builder(
//                     itemCount: snapshot.data!.docs.length,
//                     itemBuilder: (_, index) {
//                       DocumentSnapshot _documentSnapshot =
//                           snapshot.data!.docs[index];

//                       return Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(0.0),
//                             child: InkWell(
//                               onTap: () {
//                                 // for (int i = 0; i < 5; i++)
//                                 //   setState(() {
//                                 //     total = total + i;
//                                 //   });

//                                 print(sum.toString().trim());
//                                 print('${_documentSnapshot['name']}');
//                                 print('ขนม');
//                               },
//                               child: Card(
//                                 elevation: 6,
//                                 child: ListTile(
//                                   leading: Container(
//                                     height: 100,
//                                     width: 100,
//                                     child: Image.network(
//                                         _documentSnapshot["images"],
//                                         fit: BoxFit.fill),
//                                   ),
//                                   title: Wrap(
//                                     children: [
//                                       Text(
//                                         _documentSnapshot['name'],
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ],
//                                   ),
//                                   subtitle: Text(
//                                     " ${_documentSnapshot['sumprice']}฿",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color:
//                                             Color.fromARGB(255, 255, 119, 0)),
//                                   ),
//                                   trailing: Wrap(
//                                     children: [],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     });
//               },
//             ),
//           ),
//           Column(
//             children: [
//               Text(sum.toString().trim()),
//               SizedBox(
//                 height: 20,
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Container(
//             color: Color.fromARGB(255, 250, 250, 250),
//             height: 66,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   height: 0,
//                 ),
//                 ElevatedButton(
//                     child: Wrap(
//                       children: [
//                         Text(
//                           "ชำระเงิน",
//                           style: TextStyle(
//                               fontSize: 18,
//                               color: Color.fromARGB(255, 255, 255, 255)),
//                         ),
//                         SizedBox(
//                           width: 0,
//                         ),
//                       ],
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       primary: Color.fromARGB(215, 188, 187, 187),
//                       elevation: 3,
//                     ),
//                     onPressed: () async => {
//                           print(''),
//                           Navigator.of(context).push(
//                               MaterialPageRoute(builder: (_) => totalsreen())),
//                         }),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
