// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:get/get.dart';
// import 'package:get/state_manager.dart';

// class DataController extends GetxController {
//   final firebaseInstance = FirebaseFirestore.instance;

//   void onReady() {
//     super.onReady();
//   }

//   Future<void> addNewProduct(Map productdata, File image) async {
//     var pathimage = image.toString();
//     var temp = pathimage.lastIndexOf('/');
//     var result = pathimage.substring(temp + 1);
//     print(result);
//     final ref =
//         FirebaseStorage.instance.ref().child('product_images').child(result);
//     var response = await ref.putFile(image);
//     print("Updated $response");
//     var imageUrl = await ref.getDownloadURL();

//     try {
//       var response = await firebaseInstance.collection('productlist').add({
//         'products_id': productdata['id'],
//         'product_image': imageUrl,
//         'products_market': productdata['market'],
//         'products_name': productdata['name'],
//         'products_price': productdata['price'],
//       });
//       print("Firebase response1111 $response");
//       Get.back();
//     } catch (exception) {
//       print("Error Saving Data at firestore $exception");
//     }
//   }
// }
