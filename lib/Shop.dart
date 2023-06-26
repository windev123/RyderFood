// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_application_3/constants/colors.dart';
// import 'package:flutter_application_3/item.dart';
// import 'package:flutter_application_3/item_description.dart';

// class Shop extends StatefulWidget {
//   const Shop({Key? key}) : super(key: key);

//   @override
//   State<Shop> createState() => _ShopState();
// }

// class _ShopState extends State<Shop> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kBackground,
//       body: SafeArea(
//         child: Container(
//           width: double.infinity,
//           padding: EdgeInsets.symmetric(horizontal: 12.25),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               SizedBox(
//                 height: 20,
//               ),
//               TextField(
//                 decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                         borderSide: BorderSide.none),
//                     hintText: "ค้นหาสินค้า"),
//               ),
//               Container(
//                 color: Color.fromARGB(255, 92, 92, 92),
//                 height: 40,
//                 width: double.infinity,
//                 child: Row(
//                   children: <Widget>[
//                     Container(
//                       width: 100,
//                       height: 20,
//                       child: Padding(
//                         padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
//                         child: Row(
//                           children: <Widget>[
//                             RaisedButton(
//                               onPressed: () {
//                                 print("โค้ดส่วนลด");
//                               },
//                               color: Color.fromARGB(255, 180, 180, 180),
//                               child: Text(
//                                 "โค้ดส่วนลด",
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     color: Color.fromARGB(255, 0, 0, 0)),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 4,
//                     ),
//                     Container(
//                       width: 100,
//                       height: 20,
//                       child: Padding(
//                         padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
//                         child: Row(
//                           children: <Widget>[
//                             RaisedButton(
//                               onPressed: () {
//                                 print("โค้ดส่งฟรี");
//                               },
//                               color: Color.fromARGB(255, 180, 180, 180),
//                               child: Text(
//                                 "โค้ดส่งฟรี",
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     color: Color.fromARGB(255, 0, 0, 0)),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 4,
//                     ),
//                     Container(
//                       width: 100,
//                       height: 20,
//                       child: Padding(
//                         padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
//                         child: Row(
//                           children: <Widget>[
//                             RaisedButton(
//                               onPressed: () {
//                                 print("เครื่องครัว");
//                               },
//                               color: Color.fromARGB(255, 180, 180, 180),
//                               child: Text(
//                                 "เครื่องครัว",
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     color: Color.fromARGB(255, 0, 0, 0)),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 2,
//               ),
//               Expanded(
//                 child: GridView.count(
//                   physics: BouncingScrollPhysics(),
//                   childAspectRatio: 500 / 600,
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 5,
//                   mainAxisSpacing: 5,
//                   children: getGridItems()
//                       .map((item) => renderGridItem(item))
//                       .toList(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget renderGridItem(Item item) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => ItemDescription(item: item)));
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: item.color,
//           borderRadius: BorderRadius.all(
//             Radius.circular(16.0),
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             Expanded(
//               child: Image.network(item.imageUrl,
//                   height: 150, width: 300, fit: BoxFit.fill),
//             ),
//             Container(
//               height: 30,
//               color: Color.fromARGB(255, 255, 255, 255),
//               child: Row(
//                 children: <Widget>[
//                   Text(
//                     item.title,
//                     textAlign: TextAlign.left,
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 9,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 8,
//                   ),
//                   Text(
//                     item.price + r" บาท",
//                     textAlign: TextAlign.left,
//                     style: TextStyle(
//                       color: Color.fromARGB(255, 245, 123, 9),
//                       fontSize: 9,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
