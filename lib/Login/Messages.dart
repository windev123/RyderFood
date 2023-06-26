// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_3/Login/chat_detail.dart';

// class Messages extends StatelessWidget {
//   Messages({Key? key}) : super(key: key);
//   var currentUser = FirebaseAuth.instance.currentUser?.uid;

//   void callChatDetailScreen(BuildContext context, String email, String uid) {
//     Navigator.push(
//         context,
//         CupertinoPageRoute(
//             builder: (context) =>
//                 ChatDetail(frienduid: uid, friendemail: email)));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection("users")
//             .where('uid', isNotEqualTo: currentUser)
//             .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return Center(
//               child: Text("Something went wrong"),
//             );
//           }

//           if (snapshot.hasData) {
//             return CustomScrollView(
//               slivers: [
//                 CupertinoSliverNavigationBar(
//                   largeTitle: Text("Messages"),
//                 ),
//                 SliverList(
//                   delegate: SliverChildListDelegate(
//                       snapshot.data!.docs.map((DocumentSnapshot document) {
//                     Map<String, dynamic> data = document.data()!;
//                     return CupertinoListTile(
//                       onTap: () =>
//                           callChatDetailScreen(contextdata['email'], data['uid']),
//                       title: Text(data['email']),
//                     );
//                   },
//                   ).toList(),
//                   ),
//                 ),
//               ],
//             );
//           }
//         });
//   }
// }
