// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'auth_helper.dart';

// class AdminHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Admin Home'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             StreamBuilder(
//               stream:
//                   FirebaseFirestore.instance.collection("users").snapshots(),
//               builder: (BuildContext context,
//                   AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (snapshot.hasData && snapshot.data != null) {
//                   final docs = snapshot.data!.docs;
//                   return ListView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: docs.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       final user = docs[index].data();
//                       return ListTile(
//                         title: Text(""),
//                       );
//                     },
//                   );
//                 } else {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//               },
//             ),
//             RaisedButton(
//               child: Text("Log out"),
//               onPressed: () {
//                 AuthHelper.logOut();
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
