import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Cart/cart_data.dart';
import 'package:flutter_application_3/HomeShop/models/Products.dart';
import 'package:flutter_application_3/MySearchDelegate.dart';
import 'package:flutter_application_3/UserShop/AddProduct/EditCandy.dart';
import 'package:flutter_application_3/UserShop/AddProduct/EditDrink.dart';
import 'package:flutter_application_3/UserShop/AddProduct/candy.dart';
import 'package:flutter_application_3/UserShop/Edit_Product_User.dart';
import 'package:flutter_application_3/UserShop/ScreenShop.dart';
import 'package:flutter_application_3/UserShop/product_image_picker.dart';
import 'package:flutter_application_3/constants/colors.dart';
import 'package:flutter_application_3/product/product.dart';
import 'package:flutter_application_3/HomeShop/homeall.dart';
import 'package:flutter_application_3/search/homesearch.dart';
import 'package:flutter_application_3/search/search_screen.dart';
import 'package:image_picker/image_picker.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({Key? key}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
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

class _EditProductState extends State<EditProduct> {
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  var pickedImage;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  var _firestoreInstance = FirebaseFirestore.instance;
  final TextEditingController _imageController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _productnameController = TextEditingController();
  final TextEditingController _productpriceController = TextEditingController();
  final CollectionReference _products =
      FirebaseFirestore.instance.collection("products");

  TextEditingController _searchController = TextEditingController();
  List _userproducts = [];

  // void _pickedImage(File image) {
  //   _userImageFile = image;
  //   print("Image got $_userImageFile");
  // }

  @override
  void initState() {
    fetchProducts();
    super.initState();
  }

  imagePickerOption() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("เพิ่มรูปภาพ"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  print("Camera");
                  pickImage(ImageSource.camera);
                },
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.camera,
                        color: Color.fromARGB(255, 119, 119, 119),
                      ),
                    ),
                    Text(
                      "Camera",
                      style: TextStyle(
                        color: Color.fromARGB(255, 119, 119, 119),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  print("Gallery");
                  pickImage(ImageSource.gallery);
                },
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.image,
                        color: Color.fromARGB(255, 119, 119, 119),
                      ),
                    ),
                    Text(
                      "Gallery",
                      style: TextStyle(
                        color: Color.fromARGB(255, 119, 119, 119),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.close,
                        color: Color.fromARGB(255, 119, 119, 119),
                      ),
                    ),
                    Text(
                      "Cancel",
                      style: TextStyle(
                        color: Color.fromARGB(255, 119, 119, 119),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  pickImage(ImageSource imageType) async {
    final ImagePicker _picker = ImagePicker();
    try {
      final photo = await _picker.pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        this.pickedImage = tempImage;
        print(pickedImage);
      });

      Navigator.pop(context);
    } catch (error) {
      print(error);
    }
  }

  // var _userImageFile;

  // updateproduct() async {
  //   CollectionReference _collectionRef =
  //       _firestoreInstance.collection("products");
  //   return _collectionRef.doc("$_userproducts [products-name]").update({
  //     "name": _productnameController.text,
  //     "price": _productpriceController.text,
  //   }).then((value) => print("id"));
  // }
  //  updateData() async {
  //   CollectionReference _collectionRef =
  //       FirebaseFirestore.instance.collection("products");
  //   return _collectionRef.doc(_userproducts[
  //                                                                   index][
  //                                                               "products-name"]).update({
  //     "name": _productnameController.text,
  //     "surname": _productpriceController.text,

  //   }).then((value) => print("Updated Successfully"));
  // }

  fetchProducts() async {
    var currentUser = _auth.currentUser;
    QuerySnapshot qn = await _firestoreInstance
        .collection("products")
        .where('email', isEqualTo: "${currentUser!.email}")
        .get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _userproducts.add({
          "id_product": qn.docs[i]["id_product"],
          "id": qn.docs[i]["id"],
          "name": qn.docs[i]["name"],
          "image": qn.docs[i]["image"],
          "price": qn.docs[i]["price"],
          "market": qn.docs[i]["market"]
        });
      }
    });
    return qn.docs;
  }

  // Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
  //   if (documentSnapshot != null) {
  //     _productnameController.text = documentSnapshot['name'];
  //     _productpriceController.text = documentSnapshot['price'].toString();
  //   }

  //   await showModalBottomSheet(
  //       isScrollControlled: true,
  //       context: context,
  //       builder: (BuildContext ctx) {
  //         return Padding(
  //           padding: EdgeInsets.only(
  //               top: 20,
  //               left: 20,
  //               right: 20,
  //               bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               TextField(
  //                 controller: _productnameController,
  //                 decoration: const InputDecoration(labelText: "Name"),
  //               ),
  //               TextField(
  //                 keyboardType:
  //                     const TextInputType.numberWithOptions(decimal: true),
  //                 controller: _productpriceController,
  //                 decoration: const InputDecoration(
  //                   labelText: "Price",
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: 20,
  //               ),
  //               ElevatedButton(
  //                 child: const Text("Update"),
  //                 onPressed: () async {
  //                   final String name = _productnameController.text;
  //                   final double? price =
  //                       double.tryParse(_productpriceController.text);
  //                   if (price != null) {
  //                     await _products
  //                         .doc(documentSnapshot!.id)
  //                         .update({"name": name, "price": price});
  //                   }
  //                 },
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }

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
                "EDIT FOOD",
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
              width: 700,
              height: 223,
              child: Image.asset("images/Food01.jpg"),
              color: Color.fromARGB(255, 7, 7, 7),
            ),
            Wrap(
              children: [
                Container(
                  height: 500,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 0,
                      ),
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: GridView.builder(
                                itemCount: _userproducts.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.850,
                                ),
                                itemBuilder: (_, index) {
                                  updateData() async {
                                    CollectionReference _collectionRef =
                                        FirebaseFirestore.instance
                                            .collection("products");
                                    return _collectionRef
                                        .doc(_userproducts[index]["id_product"]
                                            .toString())
                                        .update({
                                      "name": _productnameController.text,
                                      "price": _productpriceController.text,
                                    }).then((value) =>
                                            print("Updated Successfully"));
                                  }

                                  Future<void> _update() async {
                                    _productnameController.text =
                                        _userproducts[index]["name"].toString();
                                    _productpriceController.text =
                                        _userproducts[index]["price"]
                                            .toString();
                                    _imageController.text = _userproducts[index]
                                            ["image"]
                                        .toString();

                                    await showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (BuildContext ctx) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                top: 20,
                                                left: 20,
                                                right: 20,
                                                bottom: MediaQuery.of(ctx)
                                                        .viewInsets
                                                        .bottom +
                                                    20),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Center(
                                                  child: Container(
                                                    width: 180,
                                                    height: 200,
                                                    child: pickedImage != null
                                                        ? Image.file(
                                                            pickedImage!,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Image.network(
                                                            _userproducts[index]
                                                                    ["image"]
                                                                .toString(),
                                                            fit: BoxFit.cover,
                                                          ),
                                                  ),
                                                ),
                                                // ElevatedButton.icon(
                                                //   onPressed: imagePickerOption,
                                                //   icon: Icon(Icons.image),
                                                //   label: Text('แก้ไขรูปภาพ'),
                                                // ),
                                                SizedBox(height: 10),
                                                TextField(
                                                  controller:
                                                      _productnameController,
                                                  decoration: InputDecoration(
                                                      labelText: "ชื่อสินค้า"),
                                                ),
                                                TextField(
                                                  keyboardType: TextInputType
                                                      .numberWithOptions(
                                                          decimal: true),
                                                  controller:
                                                      _productpriceController,
                                                  decoration: InputDecoration(
                                                    labelText: "ราคา",
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  children: [
                                                    ElevatedButton(
                                                        child:
                                                            const Text("แก้ไข"),
                                                        onPressed: () async {
                                                          showDialog(
                                                              context: context,
                                                              builder: (_) =>
                                                                  AlertDialog(
                                                                    title: Text(
                                                                        "คุณแน่ใจจะแก้ไขข้อมูลสินค้า?"),
                                                                    content: Text(
                                                                        "ถ้าแก้ไขข้อมูลสินค้าแล้วข้อมูลเดิมจะหายไป!"),
                                                                    actions: [
                                                                      MaterialButton(
                                                                        onPressed:
                                                                            () async =>
                                                                                {
                                                                          Navigator.pop(
                                                                              context),
                                                                          Navigator.pop(
                                                                              context),
                                                                          updateData(),
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(
                                                                            SnackBar(
                                                                              backgroundColor: Color.fromARGB(255, 0, 0, 0),
                                                                              content: Text(
                                                                                "แก้ไขข้อมูลสินค้าแล้วครับ กรุณาโปรดไปยังหน้าอื่นแล้วกลับมาหน้านี้อีกครั้ง",
                                                                                style: TextStyle(
                                                                                  color: Color.fromARGB(255, 255, 255, 255),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        },
                                                                        child: Text(
                                                                            "ใช่"),
                                                                      ),
                                                                      MaterialButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child: Text(
                                                                            "ไม่"),
                                                                      ),
                                                                    ],
                                                                  ));
                                                          // updateData();
                                                          // Navigator.pop(
                                                          //     context);

                                                          // ScaffoldMessenger.of(
                                                          //         context)
                                                          //     .showSnackBar(
                                                          //         SnackBar(
                                                          //   backgroundColor:
                                                          //       Color.fromARGB(
                                                          //           255,
                                                          //           0,
                                                          //           0,
                                                          //           0),
                                                          //   content: Text(
                                                          //     "แก้ไขเรียบร้อยแล้วครับ กรุณาโปรดไปยังหน้าอื่นแล้วกลับมาหน้านี้อีกครั้ง",
                                                          //     style: TextStyle(
                                                          //       color: Color
                                                          //           .fromARGB(
                                                          //               255,
                                                          //               255,
                                                          //               255,
                                                          //               255),
                                                          //     ),
                                                          //   ),
                                                          // ));
                                                          print(
                                                              "..........................");
                                                          print(
                                                              "..........................");
                                                          print(
                                                              "..........................");
                                                          print(
                                                              "..........................");
                                                          print(
                                                              "..........................");
                                                          print(
                                                              "..........................");
                                                          print(
                                                              "..........................");

                                                          // await _products
                                                          //     .doc(_userproducts[
                                                          //                 index][
                                                          //             "products-name"]
                                                          //         .toString())
                                                          //     .update({
                                                          //   "products-name": name,
                                                          //   "price": price
                                                          // });
                                                        }),
                                                    SizedBox(width: 170),
                                                    ElevatedButton(
                                                        child: Wrap(
                                                          children: [
                                                            Text(
                                                              "ลบ",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary:
                                                              Color.fromARGB(
                                                                  214,
                                                                  250,
                                                                  1,
                                                                  1),
                                                          elevation: 3,
                                                        ),
                                                        onPressed: () async {
                                                          showDialog(
                                                              context: context,
                                                              builder: (_) =>
                                                                  AlertDialog(
                                                                    title: Text(
                                                                        "คุณแน่ใจจะลบสินค้า?"),
                                                                    content: Text(
                                                                        "ถ้าลบแล้วสินค้าจะหายไป!"),
                                                                    actions: [
                                                                      MaterialButton(
                                                                        onPressed:
                                                                            () async =>
                                                                                {
                                                                          Navigator.pop(
                                                                              context),
                                                                          Navigator.pop(
                                                                              context),
                                                                          FirebaseFirestore
                                                                              .instance
                                                                              .collection("products")
                                                                              .doc(_userproducts[index]["id_product"].toString())
                                                                              .delete(),
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(
                                                                            SnackBar(
                                                                              backgroundColor: Color.fromARGB(255, 0, 0, 0),
                                                                              content: Text(
                                                                                "ลบสินค้าแล้วครับ กรุณาโปรดไปยังหน้าอื่นแล้วกลับมาหน้านี้อีกครั้ง",
                                                                                style: TextStyle(
                                                                                  color: Color.fromARGB(255, 255, 255, 255),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        },
                                                                        child: Text(
                                                                            "ใช่"),
                                                                      ),
                                                                      MaterialButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child: Text(
                                                                            "ไม่"),
                                                                      ),
                                                                    ],
                                                                  ));
                                                        }),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  }

                                  return GestureDetector(
                                    // onTap: () => Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (_) => EditProductUser(
                                    //             _userproducts[index]))),
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
                                                  _userproducts[index]["image"],
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
                                                alignment: WrapAlignment.start,
                                                // spacing: 5,
                                                // runSpacing: 5,
                                                children: <Widget>[
                                                  Text(
                                                    "${_userproducts[index]["name"]}",
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
                                          // Container(
                                          //   height: 23,
                                          //   color: Color.fromARGB(
                                          //       255, 255, 255, 255),
                                          //   child: Padding(
                                          //     padding:
                                          //         const EdgeInsets.fromLTRB(
                                          //             10, 0, 10, 0),
                                          //     child: Wrap(
                                          //       alignment: WrapAlignment.start,
                                          //       // spacing: 5,
                                          //       // runSpacing: 5,
                                          //       children: <Widget>[
                                          //         Text(
                                          //           "${_userproducts[index]["price"].toString()}฿",
                                          //           style: TextStyle(
                                          //             fontSize: 14,
                                          //           ),
                                          //           overflow:
                                          //               TextOverflow.ellipsis,
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ),
                                          // ),
                                          Container(
                                            height: 45,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 0, 10, 0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Wrap(
                                                        alignment:
                                                            WrapAlignment.start,
                                                        children: [
                                                          Text(
                                                            "${_userproducts[index]["price"].toString()}฿",
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      245,
                                                                      123,
                                                                      9),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      SizedBox(
                                                        width: 65,
                                                      ),
                                                      Container(
                                                        width: 40,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 0, 0, 0),
                                                          child: IconButton(
                                                            onPressed:
                                                                () async => {
                                                              _update(),
                                                              print(_userproducts[
                                                                          index]
                                                                      [
                                                                      "id_product"]
                                                                  .toString()),
                                                              print(_userproducts[
                                                                          index]
                                                                      ["id"]
                                                                  .toString()),
                                                              print(_userproducts[
                                                                          index]
                                                                      ["name"]
                                                                  .toString()),
                                                              print(_userproducts[
                                                                          index]
                                                                      ["price"]
                                                                  .toString()),
                                                            },
                                                            icon: Icon(
                                                              Icons.edit,
                                                              size: 20,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                      ),
                      Container(
                        color: Color.fromARGB(255, 255, 255, 255),
                        height: 90,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: Row(
                            children: [
                              RaisedButton(
                                onPressed: () {
                                  print("ขนม");
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => EditCandy()));
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
                                width: 205,
                              ),
                              RaisedButton(
                                onPressed: () {
                                  print("เครื่องดื่ม");
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => EditDrink()));
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
                            ],
                          ),
                        ),
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
