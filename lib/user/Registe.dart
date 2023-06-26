import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Home.dart';
import 'package:flutter_application_3/firebase/profile.dart';
import 'package:flutter_application_3/global_variables.dart';
import 'package:flutter_application_3/user/Login.dart';
import 'package:flutter_application_3/user/UserForm.dart';
import 'package:flutter_application_3/user/reset.dart';
import 'package:flutter_application_3/user/sign%20in.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(seconds: 120));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });
    _animationController.forward();
    super.initState();
  }

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _rolesController = "user";

  singUp() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
      var authCredential = userCredential.user;
      print(authCredential!.uid);
      if (authCredential.uid.isNotEmpty) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => UserForm()));
      } else {
        Fluttertoast.showToast(msg: "Something is wrong");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        Fluttertoast.showToast(msg: "The password provided is too weak,");
      } else if (e.code == 'emil-already-in-use') {
        Fluttertoast.showToast(
            msg: "The accont already exists for that email,");
      }
    } catch (e) {
      print(e);
    }
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              backgroundColor: Color.fromARGB(255, 221, 221, 221),
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                title: Text("สมัครสมาชิก",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 18,
                    )),
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                leading: BackButton(
                  onPressed: () {
                    print('');
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) {
                        return Login();
                      }),
                    );
                  },
                ),
              ),
              body: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: loginUrlImage3,
                    placeholder: (context, url) => Image.asset(
                      'images/wallpaper.jpg',
                      fit: BoxFit.fill,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    alignment: FractionalOffset(_animation.value, 0),
                  ),
                  Container(
                    color: Colors.black54,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 0),
                      child: ListView(
                        children: [
                          SizedBox(
                            height: 190,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Form(
                              key: formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.5)),
                                      child: TextFormField(
                                        controller: _emailController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Email",
                                          prefixIcon: Icon(
                                            Icons.email,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                          hintStyle:
                                              TextStyle(color: Colors.white),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                        ),
                                        style: TextStyle(color: Colors.white),
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText:
                                                  "กรุณาป้อนอีเมลด้วยครับ"),
                                          EmailValidator(
                                              errorText:
                                                  "รูปแบบอีเมล์ไม่ถูกต้อง")
                                        ]),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        onSaved: (String? email) {
                                          profile.email = email;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.5)),
                                      child: TextFormField(
                                        controller: _passwordController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Password",
                                          prefixIcon: Icon(
                                            Icons.lock_outline,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                          hintStyle:
                                              TextStyle(color: Colors.white),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                        ),
                                        style: TextStyle(color: Colors.white),
                                        validator: RequiredValidator(
                                            errorText:
                                                "กรุณาป้อนรหัสผ่านด้วยครับ"),
                                        obscureText: true,
                                        onSaved: (String? password) {
                                          profile.password = password;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          65, 20, 0, 0),
                                      child: SizedBox(
                                        height: 40,
                                        width: 200,
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .all<Color>(Colors.white
                                                          .withOpacity(0.5)),
                                              fixedSize:
                                                  MaterialStateProperty.all(
                                                      Size(100, 50)),
                                            ),
                                            child: Text("ลงทะเบียน",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255))),
                                            onPressed: () async {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                formKey.currentState?.save();
                                                try {
                                                  await _firebaseAuth
                                                      .createUserWithEmailAndPassword(
                                                          email:
                                                              _emailController
                                                                  .text,
                                                          password:
                                                              _passwordController
                                                                  .text)
                                                      .then((value) {
                                                    FirebaseFirestore.instance
                                                        .collection("users")
                                                        .doc(value.user!.uid)
                                                        .set({
                                                      "uid": value.user!.uid,
                                                      "email":
                                                          value.user!.email,
                                                      "password":
                                                          _passwordController
                                                              .text,
                                                      "roles": _rolesController,
                                                    });
                                                  });

                                                  // Fluttertoast.showToast(
                                                  //     msg: "สร้างบัญชีผู้ใช้เสร็จสิ้น"
                                                  //         .toString(),
                                                  //     gravity: ToastGravity.TOP);
                                                  formKey.currentState?.reset();
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              UserForm()));
                                                } on FirebaseAuthException catch (e) {
                                                  print(e.code);
                                                  String message;
                                                  if (e.code ==
                                                      'email-already-in-use') {
                                                    message =
                                                        'มีอีเมลนี้อยู่ในระบบแล้วครับ โปรดใช้อีเมลอื่นแทน';
                                                  } else if (e.code ==
                                                      'weak-password') {
                                                    message =
                                                        'รหัสผ่านต้องมีความยาว 6ตัวอักษรขึ้นไป';
                                                  } else {
                                                    message =
                                                        e.message.toString();
                                                  }

                                                  Fluttertoast.showToast(
                                                      msg: message.toString(),
                                                      gravity:
                                                          ToastGravity.CENTER);
                                                }
                                              }
                                            }),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // body: Container(
              //   child: Padding(
              //     padding: const EdgeInsets.all(20.0),
              //     child: Form(
              //       key: formKey,
              //       child: SingleChildScrollView(
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text("E-mail", style: TextStyle(fontSize: 20)),
              //             TextFormField(
              //   validator: MultiValidator([
              //     RequiredValidator(
              //         errorText: "กรุณาป้อนอีเมลด้วยครับ"),
              //     EmailValidator(
              //         errorText: "รูปแบบอีเมล์ไม่ถูกต้อง")
              //   ]),
              //   keyboardType: TextInputType.emailAddress,
              //   onSaved: (String? email) {
              //     profile.email = email;
              //   },
              // ),
              //             SizedBox(
              //               height: 20,
              //             ),
              //             Text("Password", style: TextStyle(fontSize: 20)),
              //             TextFormField(
              //               validator: RequiredValidator(
              //                   errorText: "กรุณาป้อนรหัสผ่านด้วยครับ"),
              //               obscureText: true,
              //               onSaved: (String? password) {
              //                 profile.password = password;
              //               },
              //             ),
              //             SizedBox(
              //               width: double.infinity,
              //               child: ElevatedButton(
              //                   child: Text("ลงทะเบียน",
              //                       style: TextStyle(
              //                         fontSize: 20,
              //                       )),
              // onPressed: () async {
              //   if (formKey.currentState!.validate()) {
              //     formKey.currentState?.save();
              //     try {
              //       await FirebaseAuth.instance
              //           .createUserWithEmailAndPassword(
              //               email: profile.email.toString(),
              //               password:
              //                   profile.password.toString());
              //       // Fluttertoast.showToast(
              //       //     msg: "สร้างบัญชีผู้ใช้เสร็จสิ้น"
              //       //         .toString(),
              //       //     gravity: ToastGravity.TOP);
              //       formKey.currentState?.reset();
              //       Navigator.pushReplacement(
              //           context,
              //           MaterialPageRoute(
              //               builder: (_) => UserForm()));
              //     } on FirebaseAuthException catch (e) {
              //       print(e.code);
              //       String message;
              //       if (e.code == 'email-already-in-use') {
              //         message =
              //             'มีอีเมลนี้อยู่ในระบบแล้วครับ โปรดใช้อีเมลอื่นแทน';
              //       } else if (e.code == 'weak-password') {
              //         message =
              //             'รหัสผ่านต้องมีความยาว 6ตัวอักษรขึ้นไป';
              //       } else {
              //         message = e.message.toString();
              //       }

              //       Fluttertoast.showToast(
              //           msg: message.toString(),
              //           gravity: ToastGravity.CENTER);
              //     }
              //   }
              // }),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
