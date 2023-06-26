import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_3/Home.dart';
import 'package:flutter_application_3/firebase/profile.dart';
import 'package:flutter_application_3/global_variables.dart';
import 'package:flutter_application_3/user/Registe.dart';
import 'package:flutter_application_3/user/change_pass.dart';
import 'package:flutter_application_3/user/reset.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

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
                            padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
                            child: Image.asset(
                              "images/logo10.png",
                              height: 110,
                            ),
                          ),
                          SizedBox(
                            height: 20,
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
                                    Container(
                                      alignment: Alignment(1, 0),
                                      padding:
                                          EdgeInsets.only(top: 15, right: 15),
                                      child: InkWell(
                                        child: Text(
                                          "สมัครสมาชิก",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Montserrat",
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                        onTap: () {
                                          print('');

                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(builder: (_) {
                                              return RegisterScreen();
                                            }),
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment(1, 0),
                                      padding:
                                          EdgeInsets.only(top: 15, right: 15),
                                      child: InkWell(
                                        child: Text(
                                          "ลืมรหัสผ่าน",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Montserrat",
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                        onTap: () {
                                          print('');
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(builder: (_) {
                                              return ResetScreen();
                                            }),
                                          );
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
                                            child: Text("เข้าสู่ระบบ",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255))),
                                            onPressed: () async {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                formKey.currentState?.save();
                                                try {
                                                  await FirebaseAuth.instance
                                                      .signInWithEmailAndPassword(
                                                          email: profile.email
                                                              .toString(),
                                                          password: profile
                                                              .password
                                                              .toString())
                                                      .then((value) => {
                                                            Fluttertoast.showToast(
                                                                msg: "ยินดีต้อนรับเข้าสู่ระบบ"
                                                                    .toString(),
                                                                gravity:
                                                                    ToastGravity
                                                                        .CENTER),
                                                            formKey.currentState
                                                                ?.reset(),
                                                            Navigator.of(
                                                                    context)
                                                                .pushReplacement(
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (_) {
                                                              return Home();
                                                            })),
                                                          });
                                                } on FirebaseAuthException catch (e) {
                                                  if (e.code ==
                                                      'user-not-found') {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "ไม่มีอีเมล์นี้อยู่ในระบบครับ",
                                                        gravity: ToastGravity
                                                            .CENTER);
                                                  } else if (e.code ==
                                                      'wrong-password') {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "รหัสผ่านผิดโปรดป้อนใหม่ครับ",
                                                        gravity: ToastGravity
                                                            .CENTER);
                                                  }
                                                } catch (e) {
                                                  print(e);
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
