import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Cart/cart_data.dart';
import 'package:flutter_application_3/HomeShop/chatscreen.dart';
import 'package:flutter_application_3/HomeShop/models/Products.dart';
import 'package:flutter_application_3/HomeShop/models/homecabdy.dart';
import 'package:flutter_application_3/HomeShop/models/homedrink.dart';
import 'package:flutter_application_3/Login/Messages.dart';
import 'package:flutter_application_3/MySearchDelegate.dart';
import 'package:flutter_application_3/constants/colors.dart';
import 'package:flutter_application_3/product/product.dart';
import 'package:flutter_application_3/HomeShop/homeall.dart';
import 'package:flutter_application_3/search/homesearch.dart';
import 'package:flutter_application_3/search/search_screen.dart';

import '../product/productdrink.dart';

class HomeShop extends StatefulWidget {
  const HomeShop({Key? key}) : super(key: key);

  @override
  State<HomeShop> createState() => _HomeShopState();
}

// class _HomeShopState extends State<HomeShop> {
//   List<Widget> widgets = [];
//   @override
//   void initState() {
//     super.initState();
//     readData();
//   }

//   Future<Null> readData() async {
//     await Firebase.initializeApp().then((value) async {
//       print("initialize Success");
//       await FirebaseFirestore.instance
//           .collection('products')
//           .orderBy('name')
//           .snapshots()
//           .listen((event) {
//         print('snapshot = ${event.docs}');
//         for (var snapshot in event.docs) {
//           Map<String, dynamic> map = snapshot.data();
//           print('map =$map');
//           AllProducts all = AllProducts.fromMap(map);
//           print('name = ${all.name}');
//           setState(() {
//             widgets.add(createWidget(all));
//           });
//         }
//       });
//     });
//   }

//   Widget createWidget(AllProducts all) => Card(
//         elevation: 3,
//         child: Column(
//           children: [
//             Expanded(
//               child: Image.network(all.image,
//                   height: 150, width: 300, fit: BoxFit.fill),
//             ),
//             Container(
//               height: 23,
//               color: Color.fromARGB(255, 255, 255, 255),
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                 child: Wrap(
//                   alignment: WrapAlignment.start,
//                   // spacing: 5,
//                   // runSpacing: 5,
//                   children: <Widget>[
//                     Text(
//                       all.name,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Container(
//               height: 25,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                 child: Row(
//                   children: <Widget>[
//                     Text(
//                       all.price,
//                       textAlign: TextAlign.left,
//                       style: TextStyle(
//                         color: Color.fromARGB(255, 245, 123, 9),
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 255, 255, 255),
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 129, 129, 129),
//         elevation: 10,
//         title: Image.asset(
//           'images/DzenShop.png',
//           height: 200,
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
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.message),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: widgets.length == 0
//           ? Center(child: CircularProgressIndicator())
//           : GridView.extent(maxCrossAxisExtent: 180, children: widgets),
//     );
//   }
// }

class _HomeShopState extends State<HomeShop> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final image = const [
    'images/Artboard1.jpg'
        'images/Versionbro.png'
  ];
  List<String> _carouselImages = [];
  var _dotPosition = 0;

  List _candy = [];
  List _products = [];
  List _drink = [];
  TextEditingController _searchController = TextEditingController();
  var _firestoreInstance = FirebaseFirestore.instance;
  fatchCarouselImages() async {
    QuerySnapshot qn =
        await _firestoreInstance.collection("carousel-slider").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carouselImages.add(
          qn.docs[i]["img"],
        );
      }
    });
  }

  fatchCandy() async {
    QuerySnapshot qn = await _firestoreInstance.collection("candy").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _candy.add({
          "id_product": qn.docs[i]["id_product"],
          "id": qn.docs[i]["id"],
          "name": qn.docs[i]["name"],
          "image": qn.docs[i]["image"],
          "price": qn.docs[i]["price"],
          "market": qn.docs[i]["market"],
          // "products-status": qn.docs[i]["status"]
        });
      }
    });
    return qn.docs;
  }

  fatchDrink() async {
    QuerySnapshot qn = await _firestoreInstance.collection("drink").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _drink.add({
          "id_product": qn.docs[i]["id_product"],
          "id": qn.docs[i]["id"],
          "name": qn.docs[i]["name"],
          "image": qn.docs[i]["image"],
          "price": qn.docs[i]["price"],
          "market": qn.docs[i]["market"],
          // "products-status": qn.docs[i]["status"]
        });
      }
    });
    return qn.docs;
  }

  fetchProducts() async {
    var currentUser = _auth.currentUser;
    QuerySnapshot qn = await _firestoreInstance.collection("products").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          "id_product": qn.docs[i]["id_product"],
          "products-id": qn.docs[i]["id"],
          "products-name": qn.docs[i]["name"],
          "products-image": qn.docs[i]["image"],
          "products-price": qn.docs[i]["price"],
          "products-market": qn.docs[i]["market"],
          // "products-status": qn.docs[i]["status"]
        });
      }
    });
    return qn.docs;
  }

  @override
  void initState() {
    fatchCarouselImages();
    fetchProducts();
    fatchDrink();
    fatchCandy();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(215, 188, 187, 187),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(215, 188, 187, 187),
        elevation: 10,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
          child: Image.asset(
            'images/RF.png',
            height: 73,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.local_grocery_store_outlined),
            onPressed: () {
              print('');

              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => Cart()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {
              print('');
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => Chatscreen()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Wrap(
              children: [
                Container(
                  height: 1200,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Column(
                            children: [
                              CarouselSlider(
                                items: _carouselImages
                                    .map(
                                      (item) => Container(
                                        height: 1000,
                                        width: 1500,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(item),
                                                fit: BoxFit.fill)),
                                      ),
                                    )
                                    .toList(),
                                options: CarouselOptions(
                                  height: 130,
                                  autoPlay: true,
                                  aspectRatio: 16 / 9,
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enableInfiniteScroll: true,
                                  autoPlayAnimationDuration:
                                      Duration(milliseconds: 1300),
                                  viewportFraction: 1,
                                  enlargeCenterPage: true,
                                  scrollDirection: Axis.horizontal,
                                  onPageChanged:
                                      (val, carouselPageChangedReason) {
                                    setState(() {
                                      _dotPosition = val;
                                    });
                                  },
                                ),
                              ),
                              DotsIndicator(
                                dotsCount: _carouselImages.length == 0
                                    ? 1
                                    : _carouselImages.length,
                                position: _dotPosition.toDouble(),
                                decorator: DotsDecorator(
                                  activeColor: Colors.grey,
                                  color: Colors.orange.withOpacity(0.5),
                                  spacing: EdgeInsets.all(2),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 0,
                            ),
                            Container(
                              height: 50,
                              width: 600,
                              child: ElevatedButton(
                                onPressed: () {
                                  showSearch(
                                      context: context,
                                      delegate: SearchScreen());
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'ค้นหา',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                    SizedBox(
                                      width: 270,
                                    ),
                                    Icon(
                                      Icons.search,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 255, 255, 255),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    // <-- Radius
                                  ),
                                ),
                              ),
                              // child: OutlinedButton(
                              //   onPressed: () {
                              //     showSearch(
                              //         context: context,
                              //         delegate: SearchScreen());
                              //   },
                              //   child: Row(
                              //     children: [
                              //       Text(
                              //         'ค้นหา',
                              //         style: TextStyle(color: Colors.black),
                              //       ),
                              //       SizedBox(
                              //         width: 270,
                              //       ),
                              //       Icon(
                              //         Icons.search,
                              //         color: Colors.black,
                              //       ),
                              //     ],
                              //   ),
                              //   style: OutlinedButton.styleFrom(
                              //     shape: StadiumBorder(),
                              //   ),
                              // ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: Color.fromARGB(255, 205, 205, 205),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.fromLTRB(10, 5, 0, 4),
                          child: Row(
                            children: <Widget>[
                              RaisedButton(
                                onPressed: () {
                                  print("โค้ดส่วนลด");
                                },
                                color: Color.fromARGB(255, 255, 255, 255),
                                child: Container(
                                  height: 70,
                                  width: 60,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 3, 0, 0),
                                        child: Container(
                                          height: 50,
                                          width: 60,
                                          color: Color.fromARGB(
                                              255, 192, 192, 192),
                                          child: Column(
                                            children: [
                                              Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 10, 0, 0),
                                                  child: Container(
                                                    height: 35,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                              'images/SL1.png',
                                                            ),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "โค้ดส่วนลด",
                                        style: TextStyle(
                                            fontSize: 9,
                                            color:
                                                Color.fromARGB(255, 0, 0, 0)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              RaisedButton(
                                onPressed: () {
                                  print("โค้ดส่งฟรี");
                                },
                                color: Color.fromARGB(255, 255, 255, 255),
                                child: Container(
                                  height: 70,
                                  width: 60,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 3, 0, 0),
                                        child: Container(
                                          height: 50,
                                          width: 60,
                                          color: Color.fromARGB(
                                              255, 192, 192, 192),
                                          child: Column(
                                            children: [
                                              Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 0),
                                                  child: Container(
                                                    height: 50,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                              'images/RD.png',
                                                            ),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "โค้ดส่งฟรี",
                                        style: TextStyle(
                                            fontSize: 9,
                                            color:
                                                Color.fromARGB(255, 0, 0, 0)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              RaisedButton(
                                onPressed: () {
                                  print("อาหาร");
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => HomeAll()));
                                },
                                color: Color.fromARGB(255, 255, 255, 255),
                                child: Container(
                                  height: 70,
                                  width: 60,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 3, 0, 0),
                                        child: Container(
                                          height: 50,
                                          width: 60,
                                          color: Color.fromARGB(
                                              255, 192, 192, 192),
                                          child: Column(
                                            children: [
                                              Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 0),
                                                  child: Container(
                                                    height: 50,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                              'images/FOOD.png',
                                                            ),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "อาหาร",
                                        style: TextStyle(
                                            fontSize: 9,
                                            color:
                                                Color.fromARGB(255, 0, 0, 0)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              RaisedButton(
                                onPressed: () {
                                  print("เครื่องดื่ม");
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => DrinkALL()));
                                },
                                color: Color.fromARGB(255, 255, 255, 255),
                                child: Container(
                                  height: 70,
                                  width: 60,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 3, 0, 0),
                                        child: Container(
                                          height: 50,
                                          width: 60,
                                          color: Color.fromARGB(
                                              255, 192, 192, 192),
                                          child: Column(
                                            children: [
                                              Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 0),
                                                  child: Container(
                                                    height: 45,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                              'images/D.png',
                                                            ),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "เครื่องดื่ม",
                                        style: TextStyle(
                                            fontSize: 9,
                                            color:
                                                Color.fromARGB(255, 0, 0, 0)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              RaisedButton(
                                onPressed: () {
                                  print("ขนม");
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => CandyALL()));
                                },
                                color: Color.fromARGB(255, 255, 255, 255),
                                child: Container(
                                  height: 70,
                                  width: 60,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 3, 0, 0),
                                        child: Container(
                                          height: 50,
                                          width: 60,
                                          color: Color.fromARGB(
                                              255, 192, 192, 192),
                                          child: Column(
                                            children: [
                                              Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 0),
                                                  child: Container(
                                                    height: 45,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                              'images/K.png',
                                                            ),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "ขนม",
                                        style: TextStyle(
                                            fontSize: 9,
                                            color:
                                                Color.fromARGB(255, 0, 0, 0)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // DotsIndicator(
                      //   dotsCount: _carouselImages.length == 0
                      //       ? 1
                      //       : _carouselImages.length,
                      //   position: _dotPosition.toDouble(),
                      //   decorator: DotsDecorator(
                      //     activeColor: Colors.grey,
                      //     color: Colors.orange.withOpacity(0.5),
                      //     spacing: EdgeInsets.all(2),
                      //   ),
                      // ),
                      SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Container(
                          child: Wrap(
                            children: [
                              SizedBox(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      Stack(
                                        children: <Widget>[
                                          // Stroked text as border.
                                          Text(
                                            'อาหาร',
                                            style: TextStyle(
                                              fontSize: 18,
                                              foreground: Paint()
                                                ..style = PaintingStyle.stroke
                                                ..strokeWidth = 4
                                                ..color = Colors.grey[700]!,
                                            ),
                                          ),
                                          // Solid text as fill.
                                          Text(
                                            'อาหาร',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey[300],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            205, 0, 0, 0),
                                        child: Container(
                                          alignment: Alignment(1, 0),
                                          padding: EdgeInsets.only(
                                              top: 15, right: 15),
                                          child: InkWell(
                                            child: Text(
                                              "อาหารทั้งหมด",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color.fromARGB(
                                                      255, 8, 0, 255),
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Montserrat",
                                                  decoration:
                                                      TextDecoration.underline),
                                            ),
                                            onTap: () {
                                              print('');

                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          HomeAll()));
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 125,
                              ),
                            ],
                          ),
                          color: Color.fromARGB(215, 188, 187, 187),
                          padding: EdgeInsets.all(0.0),
                          margin: EdgeInsets.all(.0),
                        ),
                      ),
                      SizedBox(
                        height: 0.0,
                      ),
                      SingleChildScrollView(
                        child: Container(
                          height: 250,
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: GridView.builder(
                                  itemCount: _products.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 0.750,
                                  ),
                                  itemBuilder: (_, index) {
                                    return GestureDetector(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => ProductScreen(
                                                  _products[index]))),
                                      child: Card(
                                        elevation: 3,
                                        child: Column(
                                          children: [
                                            // Container(
                                            //   height: 23,
                                            //   color: Color.fromARGB(255, 255, 255, 255),
                                            //   child: Padding(
                                            //     padding:
                                            //         const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                            //     child: Wrap(
                                            //       alignment: WrapAlignment.start,
                                            //       // spacing: 5,
                                            //       // runSpacing: 5,
                                            //       children: <Widget>[
                                            //         Text(
                                            //           "${_products[index]["products-market"]}",
                                            //           overflow: TextOverflow.ellipsis,
                                            //           style: TextStyle(fontSize: 10),
                                            //         ),
                                            //       ],
                                            //     ),
                                            //   ),
                                            // ),
                                            Expanded(
                                                child: Image.network(
                                                    _products[index]
                                                        ["products-image"],
                                                    height: 150,
                                                    width: 300,
                                                    fit: BoxFit.fill)),
                                            Container(
                                              height: 23,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 0, 10, 0),
                                                child: Wrap(
                                                  alignment:
                                                      WrapAlignment.start,
                                                  // spacing: 5,
                                                  // runSpacing: 5,
                                                  children: <Widget>[
                                                    Text(
                                                      "${_products[index]["products-name"]}",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              height: 25,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 0, 10, 0),
                                                child: Row(
                                                  children: <Widget>[
                                                    Text(
                                                      "${_products[index]["products-price"].toString()}฿",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 245, 123, 9),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  })),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Container(
                          height: 40,
                          child: Wrap(
                            children: [
                              SizedBox(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  child: Row(
                                    children: [
                                      Stack(
                                        children: <Widget>[
                                          // Stroked text as border.
                                          Text(
                                            'เครื่องดื่ม',
                                            style: TextStyle(
                                              fontSize: 18,
                                              foreground: Paint()
                                                ..style = PaintingStyle.stroke
                                                ..strokeWidth = 4
                                                ..color = Colors.grey[700]!,
                                            ),
                                          ),
                                          // Solid text as fill.
                                          Text(
                                            'เครื่องดื่ม',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey[300],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            165, 0, 0, 0),
                                        child: Container(
                                          alignment: Alignment(1, 0),
                                          padding: EdgeInsets.only(
                                              top: 10, right: 15),
                                          child: InkWell(
                                            child: Text(
                                              "เครื่องดื่มทั้งหมด",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color.fromARGB(
                                                      255, 8, 0, 255),
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Montserrat",
                                                  decoration:
                                                      TextDecoration.underline),
                                            ),
                                            onTap: () {
                                              print('');

                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          DrinkALL()));
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          color: Color.fromARGB(215, 188, 187, 187),
                          padding: EdgeInsets.all(0.0),
                          margin: EdgeInsets.all(.0),
                        ),
                      ),

                      SingleChildScrollView(
                        child: Container(
                          height: 250,
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: GridView.builder(
                                  itemCount: _drink.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 0.750,
                                  ),
                                  itemBuilder: (_, index) {
                                    return GestureDetector(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  ProductDrink(_drink[index]))),
                                      child: Card(
                                        elevation: 3,
                                        child: Column(
                                          children: [
                                            // Container(
                                            //   height: 23,
                                            //   color: Color.fromARGB(255, 255, 255, 255),
                                            //   child: Padding(
                                            //     padding:
                                            //         const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                            //     child: Wrap(
                                            //       alignment: WrapAlignment.start,
                                            //       // spacing: 5,
                                            //       // runSpacing: 5,
                                            //       children: <Widget>[
                                            //         Text(
                                            //           "${_products[index]["products-market"]}",
                                            //           overflow: TextOverflow.ellipsis,
                                            //           style: TextStyle(fontSize: 10),
                                            //         ),
                                            //       ],
                                            //     ),
                                            //   ),
                                            // ),
                                            Expanded(
                                                child: Image.network(
                                                    _drink[index]["image"],
                                                    height: 150,
                                                    width: 300,
                                                    fit: BoxFit.fill)),
                                            Container(
                                              height: 23,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 0, 10, 0),
                                                child: Wrap(
                                                  alignment:
                                                      WrapAlignment.start,
                                                  // spacing: 5,
                                                  // runSpacing: 5,
                                                  children: <Widget>[
                                                    Text(
                                                      "${_drink[index]["name"]}",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              height: 25,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 0, 10, 0),
                                                child: Row(
                                                  children: <Widget>[
                                                    Text(
                                                      "${_drink[index]["price"].toString()}฿",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 245, 123, 9),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  })),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Container(
                          height: 40,
                          child: Wrap(
                            children: [
                              SizedBox(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      Stack(
                                        children: <Widget>[
                                          // Stroked text as border.
                                          Text(
                                            'ขนม',
                                            style: TextStyle(
                                              fontSize: 18,
                                              foreground: Paint()
                                                ..style = PaintingStyle.stroke
                                                ..strokeWidth = 4
                                                ..color = Colors.grey[700]!,
                                            ),
                                          ),
                                          // Solid text as fill.
                                          Text(
                                            'ขนม',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey[300],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            235, 10, 0, 0),
                                        child: Container(
                                          alignment: Alignment(1, 0),
                                          padding: EdgeInsets.only(
                                              top: 13, right: 15),
                                          child: InkWell(
                                            child: Text(
                                              "ขนมทั้งหมด",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color.fromARGB(
                                                      255, 8, 0, 255),
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Montserrat",
                                                  decoration:
                                                      TextDecoration.underline),
                                            ),
                                            onTap: () {
                                              print('');

                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          CandyALL()));
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          color: Color.fromARGB(215, 188, 187, 187),
                          padding: EdgeInsets.all(0.0),
                          margin: EdgeInsets.all(.0),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          height: 258,
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: GridView.builder(
                                  itemCount: _candy.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 0.750,
                                  ),
                                  itemBuilder: (_, index) {
                                    return GestureDetector(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  ProductDrink(_candy[index]))),
                                      child: Card(
                                        elevation: 3,
                                        child: Column(
                                          children: [
                                            // Container(
                                            //   height: 23,
                                            //   color: Color.fromARGB(255, 255, 255, 255),
                                            //   child: Padding(
                                            //     padding:
                                            //         const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                            //     child: Wrap(
                                            //       alignment: WrapAlignment.start,
                                            //       // spacing: 5,
                                            //       // runSpacing: 5,
                                            //       children: <Widget>[
                                            //         Text(
                                            //           "${_products[index]["products-market"]}",
                                            //           overflow: TextOverflow.ellipsis,
                                            //           style: TextStyle(fontSize: 10),
                                            //         ),
                                            //       ],
                                            //     ),
                                            //   ),
                                            // ),
                                            Expanded(
                                                child: Image.network(
                                                    _candy[index]["image"],
                                                    height: 150,
                                                    width: 300,
                                                    fit: BoxFit.fill)),
                                            Container(
                                              height: 23,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 0, 10, 0),
                                                child: Wrap(
                                                  alignment:
                                                      WrapAlignment.start,
                                                  // spacing: 5,
                                                  // runSpacing: 5,
                                                  children: <Widget>[
                                                    Text(
                                                      "${_candy[index]["name"]}",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              height: 25,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 0, 10, 0),
                                                child: Row(
                                                  children: <Widget>[
                                                    Text(
                                                      "${_candy[index]["price"].toString()}฿",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 245, 123, 9),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  })),
                        ),
                      ),

                      SizedBox(
                        width: 0,
                      ),
                      SizedBox(
                        height: 0.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
