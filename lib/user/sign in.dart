// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_3/Home.dart';
// import 'package:flutter_application_3/Shop.dart';
// import 'package:flutter_application_3/firebase/profile.dart';
// import 'package:flutter_application_3/user/Registe.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:form_field_validator/form_field_validator.dart';

// class Signin extends StatefulWidget {
//   const Signin({Key? key}) : super(key: key);

//   @override
//   _SigninState createState() => _SigninState();
// }

// class _SigninState extends State<Signin> {
//   final formKey = GlobalKey<FormState>();
//   Profile profile = Profile();
//   final Future<FirebaseApp> firebase = Firebase.initializeApp();

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: firebase,
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Scaffold(
//               appBar: AppBar(
//                 title: Text("Error"),
//               ),
//               body: Center(
//                 child: Text("${snapshot.error}"),
//               ),
//             );
//           }
//           if (snapshot.connectionState == ConnectionState.done) {
//             return Scaffold(
//               body: Container(
//                 height: 850,
//                 width: 650,
//                 decoration: BoxDecoration(
//                   color: Color.fromARGB(255, 255, 255, 255),
//                   border: Border.all(
//                       color: Color.fromARGB(255, 255, 253, 253), width: 8.0),
//                 ),
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: 44.0,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(60, 220, 60, 50),
//                         child: Form(
//                           key: formKey,
//                           child: SingleChildScrollView(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text("E-mail", style: TextStyle(fontSize: 18)),
//                                 TextFormField(
//                                   validator: MultiValidator([
//                                     RequiredValidator(
//                                         errorText: "กรุณาป้อนอีเมลด้วยครับ"),
//                                     EmailValidator(
//                                         errorText: "รูปแบบอีเมล์ไม่ถูกต้อง")
//                                   ]),
//                                   keyboardType: TextInputType.emailAddress,
//                                   onSaved: (String? email) {
//                                     profile.email = email;
//                                   },
//                                 ),
//                                 SizedBox(
//                                   height: 20,
//                                 ),
//                                 Text("Password",
//                                     style: TextStyle(fontSize: 18)),
//                                 TextFormField(
//                                   validator: RequiredValidator(
//                                       errorText: "กรุณาป้อนรหัสผ่านด้วยครับ"),
//                                   obscureText: true,
//                                   onSaved: (String? password) {
//                                     profile.password = password;
//                                   },
//                                 ),
//                                 SizedBox(
//                                   width: double.infinity,
//                                   child: ElevatedButton(
//                                       child: Text("เข้าสู่ระบบ",
//                                           style: TextStyle(
//                                             fontSize: 20,
//                                           )),
//                                       onPressed: () async {
//                                         if (formKey.currentState!.validate()) {
//                                           formKey.currentState?.save();
//                                           try {
//                                             await FirebaseAuth.instance
//                                                 .signInWithEmailAndPassword(
//                                                     email: profile.email
//                                                         .toString(),
//                                                     password: profile.password
//                                                         .toString())
//                                                 .then((value) => {
//                                                       Fluttertoast.showToast(
//                                                           msg:
//                                                               "ยินดีต้อนรับเข้าสู่ระบบ"
//                                                                   .toString(),
//                                                           gravity:
//                                                               ToastGravity.TOP),
//                                                       formKey.currentState
//                                                           ?.reset(),
//                                                       Navigator.of(context)
//                                                           .pushReplacement(
//                                                               MaterialPageRoute(
//                                                                   builder: (_) {
//                                                         return Home();
//                                                       })),
//                                                     });
//                                           } on FirebaseAuthException catch (e) {
//                                             if (e.code == 'user-not-found') {
//                                               Fluttertoast.showToast(
//                                                   msg:
//                                                       "ไม่มีอีเมล์นี้อยู่ในระบบครับ",
//                                                   gravity: ToastGravity.CENTER);
//                                             } else if (e.code ==
//                                                 'wrong-password') {
//                                               Fluttertoast.showToast(
//                                                   msg:
//                                                       "รหัสผ่านผิดโปรดป้อนใหม่ครับ",
//                                                   gravity: ToastGravity.CENTER);
//                                             }
//                                           } catch (e) {
//                                             print(e);
//                                           }
//                                         }
//                                       }),
//                                 ),
//                                 Container(
//                                   alignment: Alignment(1, 0),
//                                   padding: EdgeInsets.only(top: 15, right: 15),
//                                   child: InkWell(
//                                     child: Text(
//                                       "สมัครสมาชิก",
//                                       style: TextStyle(
//                                           fontSize: 10,
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.bold,
//                                           fontFamily: "Montserrat",
//                                           decoration: TextDecoration.underline),
//                                     ),
//                                     onTap: () {
//                                       print('');

//                                       Navigator.of(context).pushReplacement(
//                                         MaterialPageRoute(builder: (_) {
//                                           return RegisterScreen();
//                                         }),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ]),
//               ),
//             );
//           }
//           return Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         });
//   }
// }
