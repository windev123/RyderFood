// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import '../constants/colors.dart';

// class EmployeeScreen extends StatefulWidget {
//   const EmployeeScreen({Key? key}) : super(key: key);

//   @override
//   State<EmployeeScreen> createState() => _EmployeeScreenState();
// }

// class _EmployeeScreenState extends State<EmployeeScreen> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController ageController = TextEditingController();
//   TextEditingController salaryController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController traitsController = TextEditingController();

//   final _formKey = GlobalKey<FormState>();

//   bool isLoading = false;@override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kBackground,
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('products').snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           return ListView(
//             children: snapshot.data!.docs.map((document) {
//               return Container(
//                 child: Center(child: Text(document['name'])),
//               );
//             }).toList(),
//           );
//         },
//       ),
//    );
// }}