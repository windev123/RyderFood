// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_3/Cart/cart_data.dart';
// import 'package:flutter_application_3/user/Edit_profile.dart';

// class Order extends StatefulWidget {
//   const Order({Key? key}) : super(key: key);
//   _OrderState createState() => _OrderState();
// }

// class _OrderState extends State<Order> {
//   int count = 1;
//   int totalx = 0;

//   @override
//   void initState() {
//     super.initState();
//   }

//   final Future<FirebaseApp> firebase = Firebase.initializeApp();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(215, 188, 187, 187),
//         elevation: 10,
//         title: Text("รายการ",
//             style: TextStyle(
//               fontSize: 18,
//             )),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.local_grocery_store_outlined),
//             tooltip: 'Go to the next page',
//             onPressed: () {
//               print('');

//               Navigator.of(context)
//                   .push(MaterialPageRoute(builder: (_) => Cart()));
//             },
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
//                     onPressed: () async => {}),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
