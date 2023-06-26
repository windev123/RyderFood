// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'auth_helper.dart';

// class SignupPage extends StatefulWidget {
//   @override
//   _SignupPageState createState() => _SignupPageState();
// }

// class _SignupPageState extends State<SignupPage> {
//   TextEditingController? _emailController;
//   TextEditingController? _passwordController;
//   TextEditingController? _confirmPasswordController;

//   @override
//   void initState() {
//     super.initState();
//     _emailController = TextEditingController(text: "");
//     _passwordController = TextEditingController(text: "");
//     _confirmPasswordController = TextEditingController(text: "");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               const SizedBox(height: 100.0),
//               Text(
//                 "Sign Up",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
//               ),
//               const SizedBox(height: 20.0),
//               TextField(
//                 controller: _emailController,
//                 decoration: InputDecoration(hintText: "Enter email"),
//               ),
//               const SizedBox(height: 10.0),
//               TextField(
//                 controller: _passwordController,
//                 obscureText: true,
//                 decoration: InputDecoration(hintText: "Enter password"),
//               ),
//               const SizedBox(height: 10.0),
//               TextField(
//                 controller: _confirmPasswordController,
//                 obscureText: true,
//                 decoration: InputDecoration(hintText: "Confirm password"),
//               ),
//               const SizedBox(height: 10.0),
//               RaisedButton(
//                 child: Text("Signup"),
//                 onPressed: () async {
//                   if (_emailController!.text.isEmpty ||
//                       _passwordController!.text.isEmpty) {
//                     print("Email and password cannot be empty");
//                     return;
//                   }
//                   if (_confirmPasswordController!.text.isEmpty ||
//                       _passwordController!.text !=
//                           _confirmPasswordController!.text) {
//                     print("confirm password does not match");
//                     return;
//                   }
//                   try {
//                     final user = await AuthHelper.signupWithEmail(
//                         email: _emailController!.text,
//                         password: _passwordController!.text);
//                     if (user != null) {
//                       print("signup successful");
//                       Navigator.pop(context);
//                     }
//                   } catch (e) {
//                     print(e);
//                   }
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Login/model.dart';
import 'package:flutter_application_3/Login/user_login.dart';
import 'package:flutter_application_3/global_variables.dart';
import 'package:flutter_application_3/user/UserForm.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> with TickerProviderStateMixin {
  _RegisterState();

  bool showProgress = false;
  bool visible = false;

  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  CollectionReference ref = FirebaseFirestore.instance.collection('users');
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmpassController =
      new TextEditingController();
  final TextEditingController name = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController mobile = new TextEditingController();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void dispose() {
    emailController.dispose();
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

  bool _isObscure = true;
  bool _isObscure2 = true;
  File? file;
  var options = [
    'ผู้ใช้ทั่วไป',
  ];
  var _currentItemSelected = "ผู้ใช้ทั่วไป";
  var rool = "ผู้ใช้ทั่วไป";

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
                  color: Color.fromARGB(255, 255, 255, 255),
                  onPressed: () {
                    print('');
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) {
                        return LoginPage();
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
                      'images/dzen.jpg',
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
                          horizontal: 15, vertical: 50),
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Form(
                              key: _formkey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'อีเมล์',
                                      enabled: true,
                                      contentPadding: const EdgeInsets.only(
                                          left: 14.0, bottom: 8.0, top: 8.0),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.white),
                                        borderRadius:
                                            new BorderRadius.circular(20),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.white),
                                        borderRadius:
                                            new BorderRadius.circular(20),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.length == 0) {
                                        return "กรุณาป้อนอีเมล์ครับ";
                                      }
                                      if (!RegExp(
                                              "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                          .hasMatch(value)) {
                                        return ("กรุณาป้อนอีเมลให้ถูกต้อง");
                                      } else {
                                        return null;
                                      }
                                    },
                                    onChanged: (value) {},
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    obscureText: _isObscure,
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          icon: Icon(_isObscure
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                          onPressed: () {
                                            setState(() {
                                              _isObscure = !_isObscure;
                                            });
                                          }),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'รหัสผ่าน',
                                      enabled: true,
                                      contentPadding: const EdgeInsets.only(
                                          left: 14.0, bottom: 8.0, top: 15.0),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.white),
                                        borderRadius:
                                            new BorderRadius.circular(20),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.white),
                                        borderRadius:
                                            new BorderRadius.circular(20),
                                      ),
                                    ),
                                    validator: (value) {
                                      RegExp regex = new RegExp(r'^.{6,}$');
                                      if (value!.isEmpty) {
                                        return "กรุณาป้อนรหัสผ่าน";
                                      }
                                      if (!regex.hasMatch(value)) {
                                        return ("กรุณาป้อนรหัสผ่านที่ถูกต้องอย่างน้อยต้อง6ตัวอักษร");
                                      } else {
                                        return null;
                                      }
                                    },
                                    onChanged: (value) {},
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    obscureText: _isObscure2,
                                    controller: confirmpassController,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          icon: Icon(_isObscure2
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                          onPressed: () {
                                            setState(() {
                                              _isObscure2 = !_isObscure2;
                                            });
                                          }),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'ยืนยันรหัสผ่าน',
                                      enabled: true,
                                      contentPadding: const EdgeInsets.only(
                                          left: 14.0, bottom: 8.0, top: 15.0),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.white),
                                        borderRadius:
                                            new BorderRadius.circular(20),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.white),
                                        borderRadius:
                                            new BorderRadius.circular(20),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (confirmpassController.text !=
                                          passwordController.text) {
                                        return "รหัสผ่านไม่ตรงกัน";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onChanged: (value) {},
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "สมัคร : ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      DropdownButton<String>(
                                        dropdownColor:
                                            Color.fromARGB(255, 184, 184, 184),
                                        isDense: true,
                                        isExpanded: false,
                                        iconEnabledColor: Colors.white,
                                        focusColor: Colors.white,
                                        items: options
                                            .map((String dropDownStringItem) {
                                          return DropdownMenuItem<String>(
                                            value: dropDownStringItem,
                                            child: Text(
                                              dropDownStringItem,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (newValueSelected) {
                                          setState(() {
                                            _currentItemSelected =
                                                newValueSelected!;
                                            rool = newValueSelected;
                                          });
                                        },
                                        value: _currentItemSelected,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      MaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                        elevation: 5.0,
                                        height: 50,
                                        onPressed: () {
                                          setState(() {
                                            showProgress = true;
                                          });
                                          signUp(emailController.text,
                                              passwordController.text, rool);
                                        },
                                        child: Text(
                                          "ดำเนินการต่อ",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
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
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  void signUp(String email, String password, String rool) async {
    CircularProgressIndicator();
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore(email, rool)})
          .catchError((e) {});
    }
  }

  postDetailsToFirestore(String email, String rool) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    userModel.email = email;
    userModel.uid = user!.uid;
    userModel.wrool = rool;
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    _formkey.currentState?.reset();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => UserForm()));
  }
}
