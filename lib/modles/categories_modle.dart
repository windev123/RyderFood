// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dots_indicator/dots_indicator.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_3/Cart/cart_data.dart';
// import 'package:flutter_application_3/HomeShop/models/Products.dart';
// import 'package:flutter_application_3/MySearchDelegate.dart';
// import 'package:flutter_application_3/constants/colors.dart';
// import 'package:flutter_application_3/product/product.dart';
// import 'package:flutter_application_3/HomeShop/homeall.dart';
// import 'package:flutter_application_3/search/homesearch.dart';
// import 'package:flutter_application_3/search/search_screen.dart';

// class Categories extends StatefulWidget {
//   const Categories({Key? key}) : super(key: key);

//   @override
//   State<Categories> createState() => _CategoriesState();
// }

// // class _HomeShopState extends State<HomeShop> {
// //   List<Widget> widgets = [];
// //   @override
// //   void initState() {
// //     super.initState();
// //     readData();
// //   }

// //   Future<Null> readData() async {
// //     await Firebase.initializeApp().then((value) async {
// //       print("initialize Success");
// //       await FirebaseFirestore.instance
// //           .collection('products')
// //           .orderBy('name')
// //           .snapshots()
// //           .listen((event) {
// //         print('snapshot = ${event.docs}');
// //         for (var snapshot in event.docs) {
// //           Map<String, dynamic> map = snapshot.data();
// //           print('map =$map');
// //           AllProducts all = AllProducts.fromMap(map);
// //           print('name = ${all.name}');
// //           setState(() {
// //             widgets.add(createWidget(all));
// //           });
// //         }
// //       });
// //     });
// //   }

// //   Widget createWidget(AllProducts all) => Card(
// //         elevation: 3,
// //         child: Column(
// //           children: [
// //             Expanded(
// //               child: Image.network(all.image,
// //                   height: 150, width: 300, fit: BoxFit.fill),
// //             ),
// //             Container(
// //               height: 23,
// //               color: Color.fromARGB(255, 255, 255, 255),
// //               child: Padding(
// //                 padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
// //                 child: Wrap(
// //                   alignment: WrapAlignment.start,
// //                   // spacing: 5,
// //                   // runSpacing: 5,
// //                   children: <Widget>[
// //                     Text(
// //                       all.name,
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //             SizedBox(
// //               height: 5,
// //             ),
// //             Container(
// //               height: 25,
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.circular(16),
// //               ),
// //               child: Padding(
// //                 padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
// //                 child: Row(
// //                   children: <Widget>[
// //                     Text(
// //                       all.price,
// //                       textAlign: TextAlign.left,
// //                       style: TextStyle(
// //                         color: Color.fromARGB(255, 245, 123, 9),
// //                         fontSize: 12,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       );

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Color.fromARGB(255, 255, 255, 255),
// //       appBar: AppBar(
// //         backgroundColor: Color.fromARGB(255, 129, 129, 129),
// //         elevation: 10,
// //         title: Image.asset(
// //           'images/DzenShop.png',
// //           height: 200,
// //         ),
// //         actions: <Widget>[
// //           IconButton(
// //             icon: const Icon(Icons.search),
// //             onPressed: () {
// //               showSearch(context: context, delegate: SearchScreen());
// //             },
// //           ),
// //           IconButton(
// //             icon: const Icon(Icons.local_grocery_store_outlined),
// //             onPressed: () {},
// //           ),
// //           IconButton(
// //             icon: const Icon(Icons.message),
// //             onPressed: () {},
// //           ),
// //         ],
// //       ),
// //       body: widgets.length == 0
// //           ? Center(child: CircularProgressIndicator())
// //           : GridView.extent(maxCrossAxisExtent: 180, children: widgets),
// //     );
// //   }
// // }

// class _CategoriesState extends State<Categories> {
//   final image = const [
//     'images/Artboard1.jpg'
//         'images/Versionbro.png'
//   ];
//   List<String> _carouselImages = [];
//   var _dotPosition = 0;

//   List _products = [];
//   TextEditingController _searchController = TextEditingController();
//   var _firestoreInstance = FirebaseFirestore.instance;
//   fatchCarouselImages() async {
//     QuerySnapshot qn =
//         await _firestoreInstance.collection("carousel-slider").get();
//     setState(() {
//       for (int i = 0; i < qn.docs.length; i++) {
//         _carouselImages.add(
//           qn.docs[i]["img"],
//         );
//       }
//     });
//   }

//   fetchProducts() async {
//     QuerySnapshot qn = await _firestoreInstance.collection("products").get();
//     setState(() {
//       for (int i = 0; i < qn.docs.length; i++) {
//         _products.add({
//           "products-id": qn.docs[i]["id"],
//           "products-name": qn.docs[i]["name"],
//           "products-image": qn.docs[i]["image"],
//           "products-price": qn.docs[i]["price"],
//           "products-market": qn.docs[i]["market"],
//           "products-quantity": qn.docs[i]["quantity"]
//         });
//       }
//     });
//     return qn.docs;
//   }

//   @override
//   void initState() {
//     fatchCarouselImages();
//     fetchProducts();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 255, 255, 255),
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(215, 188, 187, 187),
//         elevation: 10,
//         title: Padding(
//           padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
//           child: Image.asset(
//             'images/logo10.png',
//             height: 73,
//           ),
//         ),
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {
//               showSearch(context: context, delegate: SearchScreen());
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.local_grocery_store_outlined),
//             onPressed: () {
//               print('');

//               Navigator.of(context)
//                   .push(MaterialPageRoute(builder: (_) => Cart()));
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.message),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Wrap(
//               children: [
//                 Container(
//                   height: 950,
//                   child: Column(
//                     children: [
//                       Container(
//                         color: Color.fromARGB(255, 232, 232, 232),
//                         child: SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           padding: const EdgeInsets.fromLTRB(10, 5, 0, 4),
//                           child: Row(
//                             children: <Widget>[
//                               RaisedButton(
//                                 onPressed: () {
//                                   print("โค้ดส่วนลด");
//                                 },
//                                 color: Color.fromARGB(255, 255, 255, 255),
//                                 child: Text(
//                                   "โค้ดส่วนลด",
//                                   style: TextStyle(
//                                       fontSize: 10,
//                                       color: Color.fromARGB(255, 0, 0, 0)),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 4,
//                               ),
//                               RaisedButton(
//                                 onPressed: () {
//                                   print("โค้ดส่งฟรี");
//                                 },
//                                 color: Color.fromARGB(255, 255, 255, 255),
//                                 child: Text(
//                                   "โค้ดส่งฟรี",
//                                   style: TextStyle(
//                                       fontSize: 10,
//                                       color: Color.fromARGB(255, 0, 0, 0)),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 4,
//                               ),
//                               RaisedButton(
//                                 onPressed: () {
//                                   print("เครื่องครัว");
//                                 },
//                                 color: Color.fromARGB(255, 255, 255, 255),
//                                 child: Text(
//                                   "เครื่องครัว",
//                                   style: TextStyle(
//                                       fontSize: 10,
//                                       color: Color.fromARGB(255, 0, 0, 0)),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 4,
//                               ),
//                               RaisedButton(
//                                 onPressed: () {
//                                   print("ทำสวน");
//                                 },
//                                 color: Color.fromARGB(255, 255, 255, 255),
//                                 child: Text(
//                                   "ทำสวน",
//                                   style: TextStyle(
//                                       fontSize: 10,
//                                       color: Color.fromARGB(255, 0, 0, 0)),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 4,
//                               ),
//                               RaisedButton(
//                                 onPressed: () {
//                                   print("ภายใน");
//                                 },
//                                 color: Color.fromARGB(255, 255, 255, 255),
//                                 child: Text(
//                                   "ภายใน",
//                                   style: TextStyle(
//                                       fontSize: 10,
//                                       color: Color.fromARGB(255, 0, 0, 0)),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 4,
//                               ),
//                               RaisedButton(
//                                 onPressed: () {
//                                   print("ภายนอก");
//                                 },
//                                 color: Color.fromARGB(255, 255, 255, 255),
//                                 child: Text(
//                                   "ภายนอก",
//                                   style: TextStyle(
//                                       fontSize: 10,
//                                       color: Color.fromARGB(255, 0, 0, 0)),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 6,
//                       ),
//                       SizedBox(
//                         child: Padding(
//                           padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//                           child: Column(
//                             children: [
//                               CarouselSlider(
//                                 items: _carouselImages
//                                     .map(
//                                       (item) => Container(
//                                         decoration: BoxDecoration(
//                                             image: DecorationImage(
//                                                 image: NetworkImage(item),
//                                                 fit: BoxFit.fill)),
//                                       ),
//                                     )
//                                     .toList(),
//                                 options: CarouselOptions(
//                                   height: 130,
//                                   autoPlay: true,
//                                   aspectRatio: 16 / 9,
//                                   autoPlayCurve: Curves.fastOutSlowIn,
//                                   enableInfiniteScroll: true,
//                                   autoPlayAnimationDuration:
//                                       Duration(milliseconds: 1300),
//                                   viewportFraction: 0.8,
//                                   enlargeCenterPage: true,
//                                   scrollDirection: Axis.horizontal,
//                                   onPageChanged:
//                                       (val, carouselPageChangedReason) {
//                                     setState(() {
//                                       _dotPosition = val;
//                                     });
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10.0,
//                       ),
//                       DotsIndicator(
//                         dotsCount: _carouselImages.length == 0
//                             ? 1
//                             : _carouselImages.length,
//                         position: _dotPosition.toDouble(),
//                         decorator: DotsDecorator(
//                           activeColor: Colors.grey,
//                           color: Colors.orange.withOpacity(0.5),
//                           spacing: EdgeInsets.all(2),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 20,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
//                         child: Container(
//                           child: Wrap(
//                             children: [
//                               SizedBox(
//                                 child: Text(
//                                   "สินค้าทั้งหมด",
//                                   style: TextStyle(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 95,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
//                                 child: Container(
//                                   alignment: Alignment(1, 0),
//                                   padding: EdgeInsets.only(top: 15, right: 15),
//                                   child: InkWell(
//                                     child: Text(
//                                       "All View",
//                                       style: TextStyle(
//                                           fontSize: 10,
//                                           color: Color.fromARGB(255, 8, 0, 255),
//                                           fontWeight: FontWeight.bold,
//                                           fontFamily: "Montserrat",
//                                           decoration: TextDecoration.underline),
//                                     ),
//                                     onTap: () {
//                                       print('');

//                                       Navigator.of(context).push(
//                                           MaterialPageRoute(
//                                               builder: (_) => HomeAll()));
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           color: Color.fromARGB(255, 255, 254, 253),
//                           padding: EdgeInsets.all(0.0),
//                           margin: EdgeInsets.all(.0),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 0.0,
//                       ),
//                       Expanded(
//                         child: Padding(
//                             padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//                             child: GridView.builder(
//                                 itemCount: _products.length,
//                                 gridDelegate:
//                                     SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 3,
//                                   childAspectRatio: 0.750,
//                                 ),
//                                 itemBuilder: (_, index) {
//                                   return GestureDetector(
//                                     onTap: () => Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (_) => ProductScreen(
//                                                 _products[index]))),
//                                     child: Card(
//                                       elevation: 3,
//                                       child: Column(
//                                         children: [
//                                           // Container(
//                                           //   height: 23,
//                                           //   color: Color.fromARGB(255, 255, 255, 255),
//                                           //   child: Padding(
//                                           //     padding:
//                                           //         const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                                           //     child: Wrap(
//                                           //       alignment: WrapAlignment.start,
//                                           //       // spacing: 5,
//                                           //       // runSpacing: 5,
//                                           //       children: <Widget>[
//                                           //         Text(
//                                           //           "${_products[index]["products-market"]}",
//                                           //           overflow: TextOverflow.ellipsis,
//                                           //           style: TextStyle(fontSize: 10),
//                                           //         ),
//                                           //       ],
//                                           //     ),
//                                           //   ),
//                                           // ),
//                                           Expanded(
//                                               child: Image.network(
//                                                   _products[index]
//                                                       ["products-image"],
//                                                   height: 150,
//                                                   width: 300,
//                                                   fit: BoxFit.fill)),
//                                           Container(
//                                             height: 23,
//                                             color: Color.fromARGB(
//                                                 255, 255, 255, 255),
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.fromLTRB(
//                                                       10, 0, 10, 0),
//                                               child: Wrap(
//                                                 alignment: WrapAlignment.start,
//                                                 // spacing: 5,
//                                                 // runSpacing: 5,
//                                                 children: <Widget>[
//                                                   Text(
//                                                     "${_products[index]["products-name"]}",
//                                                     style: TextStyle(
//                                                       fontSize: 14,
//                                                     ),
//                                                     overflow:
//                                                         TextOverflow.ellipsis,
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             height: 5,
//                                           ),
//                                           Container(
//                                             height: 25,
//                                             decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               borderRadius:
//                                                   BorderRadius.circular(16),
//                                             ),
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.fromLTRB(
//                                                       10, 0, 10, 0),
//                                               child: Row(
//                                                 children: <Widget>[
//                                                   Text(
//                                                     "${_products[index]["products-price"].toString()}฿",
//                                                     textAlign: TextAlign.left,
//                                                     style: TextStyle(
//                                                       color: Color.fromARGB(
//                                                           255, 245, 123, 9),
//                                                       fontSize: 12,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                     ),
//                                                   ),
//                                                   SizedBox(
//                                                     height: 10,
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 })),
//                       ),
//                       SizedBox(
//                         width: 20,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
//                         child: Container(
//                           child: Wrap(
//                             children: [
//                               SizedBox(
//                                 child: Text(
//                                   "ร้านขายดี",
//                                   style: TextStyle(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 95,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
//                                 child: Container(
//                                   alignment: Alignment(1, 0),
//                                   padding: EdgeInsets.only(top: 15, right: 15),
//                                   child: InkWell(
//                                     child: Text(
//                                       "All View",
//                                       style: TextStyle(
//                                           color: Color.fromARGB(255, 8, 0, 255),
//                                           fontSize: 10,
//                                           fontWeight: FontWeight.bold,
//                                           fontFamily: "Montserrat",
//                                           decoration: TextDecoration.underline),
//                                     ),
//                                     onTap: () {},
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           color: Color.fromARGB(255, 255, 254, 253),
//                           padding: EdgeInsets.all(0.0),
//                           margin: EdgeInsets.all(0.0),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 0.0,
//                       ),
//                       Expanded(
//                         child: Padding(
//                             padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//                             child: GridView.builder(
//                                 itemCount: _products.length,
//                                 gridDelegate:
//                                     SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 3,
//                                   childAspectRatio: 0.750,
//                                 ),
//                                 itemBuilder: (_, index) {
//                                   return GestureDetector(
//                                     onTap: () => Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (_) => ProductScreen(
//                                                 _products[index]))),
//                                     child: Card(
//                                       elevation: 3,
//                                       child: Column(
//                                         children: [
//                                           Expanded(
//                                               child: Image.network(
//                                                   _products[index]
//                                                       ["products-image"],
//                                                   height: 150,
//                                                   width: 300,
//                                                   fit: BoxFit.fill)),
//                                           Container(
//                                             height: 23,
//                                             color: Color.fromARGB(
//                                                 255, 255, 255, 255),
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.fromLTRB(
//                                                       10, 0, 10, 0),
//                                               child: Wrap(
//                                                 alignment: WrapAlignment.start,
//                                                 // spacing: 5,
//                                                 // runSpacing: 5,
//                                                 children: <Widget>[
//                                                   Text(
//                                                     "${_products[index]["products-name"]}",
//                                                     overflow:
//                                                         TextOverflow.ellipsis,
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             height: 5,
//                                           ),
//                                           Container(
//                                             height: 25,
//                                             decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               borderRadius:
//                                                   BorderRadius.circular(16),
//                                             ),
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.fromLTRB(
//                                                       10, 0, 10, 0),
//                                               child: Row(
//                                                 children: <Widget>[
//                                                   Text(
//                                                     "${_products[index]["products-price"].toString()}฿",
//                                                     textAlign: TextAlign.left,
//                                                     style: TextStyle(
//                                                       color: Color.fromARGB(
//                                                           255, 245, 123, 9),
//                                                       fontSize: 12,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 })),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';

class CategoryPage extends StatefulWidget {
  final String? title;
  final String? catImage;
  final String? tag;
  const CategoryPage({Key? key, this.title, this.catImage, this.tag})
      : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
