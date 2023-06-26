// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_application_3/modles/categories_modle.dart';

// class MyProvider extends ChangeNotifier {
//   List<CategoriesModle> categoriesLiset = [];
//   CategoriesModle categoriesModle;
//   Future<void> getBurgerCategory() async {
//     List<CategoriesModle> newBurgerList = [];
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//         .collection('categories')
//         .doc('XhXjlgjk2ffXtCnAD1Ms')
//         .collection('Burger')
//         .get();
//     querySnapshot.docs.forEach((element) {
//       categoriesModle = CategoriesModle(
//         image: null,
//         name: null,
//       );
//     });
//   }
// }
