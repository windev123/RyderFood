// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_3/Login/HomeScreen.dart';
// import 'package:flutter_application_3/Login/admin.dart';
// import 'package:flutter_application_3/Login/user_login.dart';

// import 'auth_helper.dart';

// class MainScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData && snapshot.data != null) {
//             UserHelper.saveUser(snapshot.data!);
//             return StreamBuilder<DocumentSnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection("users")
//                   .doc(snapshot.data!.uid)
//                   .snapshots(),
//               builder: (BuildContext context,
//                   AsyncSnapshot<DocumentSnapshot> snapshot) {
//                 if (snapshot.hasData && snapshot.data != null) {
//                   final userDoc = snapshot.data;
//                   final user = userDoc!.data();
//                   if (userDoc['role'] == 'admin') {
//                     return AdminHomePage();
//                   } else {
//                     return HomePage();
//                   }
//                 } else {
//                   return Material(
//                     child: Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   );
//                 }
//               },
//             );
//           }
//           return LoginPage();
//         });
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_3/Login/auth_services.dart';
// import 'package:provider/provider.dart';

// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   TextEditingController emailController = new TextEditingController();
//   TextEditingController passwordController = new TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("LOGIN / SIGN UP"),
//             Container(
//               margin: EdgeInsets.symmetric(
//                 horizontal: 50,
//               ),
//               child: TextFormField(
//                 controller: emailController,
//                 decoration: InputDecoration(
//                   hintText: "EMAIL...",
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.symmetric(
//                 horizontal: 50,
//               ),
//               child: TextFormField(
//                 controller: passwordController,
//                 decoration: InputDecoration(
//                   hintText: "PASSWORD...",
//                 ),
//                 obscureText: true,
//               ),
//             ),
//             Container(
//               height: 40,
//               width: MediaQuery.of(context).size.width / 3,
//               color: Colors.blue,
//               child: FlatButton(
//                 onPressed: () {
//                   final String email = emailController.text.trim();
//                   final String password = passwordController.text.trim();

//                   if (email.isEmpty) {
//                     print("Email is Empty");
//                   } else {
//                     if (password.isEmpty) {
//                       print("Password is Empty");
//                     } else {
//                       context.read<AuthService>().login(
//                             email,
//                             password,
//                           );
//                     }
//                   }
//                 },
//                 child: Text("LOG IN"),
//               ),
//             ),
//             Container(
//               height: 40,
//               width: MediaQuery.of(context).size.width / 3,
//               color: Colors.red,
//               child: FlatButton(
//                 onPressed: () {
//                   final String email = emailController.text.trim();
//                   final String password = passwordController.text.trim();

//                   if (email.isEmpty) {
//                     print("Email is Empty");
//                   } else {
//                     if (password.isEmpty) {
//                       print("Password is Empty");
//                     } else {
//                       context
//                           .read<AuthService>()
//                           .signUp(
//                             email,
//                             password,
//                           )
//                           .then((value) async {
//                         User user = FirebaseAuth.instance.currentUser!;

//                         await FirebaseFirestore.instance
//                             .collection("users")
//                             .doc(user.uid)
//                             .set({
//                           'uid': user.uid,
//                           'email': email,
//                           'password': password,
//                         });
//                       });
//                     }
//                   }
//                 },
//                 child: Text("SIGN UP"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
