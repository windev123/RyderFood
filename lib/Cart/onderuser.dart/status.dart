// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class Status extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection("order")
//             .doc(FirebaseAuth.instance.currentUser!.email)
//             .collection("order")
//             .snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           for (int i = 0; i < snapshot.data!.docs.length; i++)
//             // total = total +
//             //     int.parse(
//             //         '${snapshot.data!.docs[i]['sumprice'].toString()}');
//             // print('จำนวน');
//             // print(i);
//             // print('ราคาล่าสุด');
//             // print(
//             //     '${snapshot.data!.docs[i]['sumprice'].toString()}');
//             // print(totalxs.toString().trim());
//             // print('ราคาทั้งหมด');
//             // print('${snapshot.data!.docs[i]['sumprice'].toString()}');
//             // print(totalxs.toString().trim());
//             print('${snapshot.data!.docs[i]['name'].toString()}');
//           // print('isss');
//           // print(snapshot.data!.docs.length);
//           // print(snapshot.data!.docs.length);
//           // print(
//           //     '${snapshot.data!.docs[i]['name'].toString()}');
//           // print("Added to Order");
//           // print(
//           //     "${snapshot.data!.docs[i]['name'].toString()}");

//           if (snapshot.data == null) {
//             return Center(
//               child: Column(
//                 children: [
//                   CircularProgressIndicator(),
//                 ],
//               ),
//             );
//           }

//           return Container(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Stack(
//                     children: <Widget>[
//                       // Stroked text as border.
//                       Text(
//                         'รายการอาหาร',
//                         style: TextStyle(
//                           fontSize: 18,
//                           foreground: Paint()
//                             ..style = PaintingStyle.stroke
//                             ..strokeWidth = 6
//                             ..color = Colors.grey[700]!,
//                         ),
//                       ),
//                       // Solid text as fill.
//                       Text(
//                         'รายการอาหาร',
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.grey[300],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 for (int i = 0; i < snapshot.data!.docs.length; i++)
//                   ListTile(
//                     leading: Container(
//                       height: 70,
//                       width: 70,
//                       child: Image.network(
//                           '${snapshot.data!.docs[i]['images'].toString()} ',
//                           fit: BoxFit.fill),
//                     ),
//                     title: Wrap(
//                       children: [
//                         Row(
//                           children: [
//                             Text(
//                               '${snapshot.data!.docs[i]['name'].toString()}:',
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             Text(
//                               " ${snapshot.data!.docs[i]['quantity'].toString()}",
//                               style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                   color: Color.fromARGB(255, 255, 119, 0)),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     subtitle: Text(
//                       " ${snapshot.data!.docs[i]['sumprice'].toString()}฿",
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Color.fromARGB(255, 255, 119, 0)),
//                     ),
//                   ),
//               ],
//             ),
//           );
//         });
//   }
// }
