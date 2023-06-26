// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_3/HomeShop/homeshop.dart';

// class FirebaseSearch extends StatefulWidget {
//   const FirebaseSearch({Key? key}) : super(key: key);

//   @override
//   State<FirebaseSearch> createState() => _FirebaseSearchState();
// }

// class _FirebaseSearchState extends State<FirebaseSearch> {
//   List seachResult = [];

//   void searchFromFirebase(String query) async {
//     final result = await FirebaseFirestore.instance
//         .collection('products')
//         .where(
//           'name',
//           isEqualTo: query,
//         )
//         .get();
//     setState(() {
//       seachResult = result.docs.map((e) => e.data()).toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: "ค้นหาสินค้า",
//               ),
//               onChanged: (query) {
//                 searchFromFirebase(query);
//               },
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: seachResult.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(seachResult[index]["products-name"]),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
