// import 'package:firebase_auth/firebase_auth.dart';

// class AuthService {
//   final FirebaseAuth _auth;
//   AuthService(this._auth);

//   Stream<User?> get authStateChanges => _auth.idTokenChanges();

//   Future<Object> login(String email, String password) async {
//     try {
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//       return "Logged in";
//     } catch (e) {
//       return e;
//     }
//   }

//   Future<Object> signUp(String email, String password) async {
//     try {
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//       return "Signed Up";
//     } catch (e) {
//       return e;
//     }
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Login/user_login.dart';
import 'package:flutter_application_3/global_variables.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Forgotpass extends StatefulWidget {
  const Forgotpass({Key? key}) : super(key: key);

  @override
  _ForgotpassState createState() => _ForgotpassState();
}

class _ForgotpassState extends State<Forgotpass> with TickerProviderStateMixin {
  // bool showProgress = false;
  bool visible = false;
  final _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
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
                title: Text("ลืมรหัสผ่าน",
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
                      fit: BoxFit.cover,
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
                          SizedBox(
                            height: 40,
                          ),
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
                                    textInputAction: TextInputAction.done,
                                    validator: (value) {
                                      if (value!.length == 0) {
                                        return "กรุณาป้อนอีเมล์ครับ";
                                      }
                                      if (!RegExp(
                                              "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                          .hasMatch(value)) {
                                        return ("กรุณาป้อนอีเมล์ให้ถูกต้องครับ");
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (value) {
                                      // emailController.text = value!;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  SizedBox(
                                    height: 30,
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
                                        height: 40,
                                        onPressed: () {
                                          Forgotpassss(emailController.text);
                                          setState(() {
                                            visible = true;
                                          });
                                        },
                                        child: Text(
                                          "ส่ง",
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
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

  void Forgotpassss(String email) async {
    if (_formkey.currentState!.validate()) {
      await _auth
          .sendPasswordResetEmail(email: email)
          .then((uid) => {
                Fluttertoast.showToast(
                    msg: "ได้ทำการส่งแบบฟอร์มไปยังอีเมล์แล้วครับ".toString(),
                    gravity: ToastGravity.BOTTOM),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()))
              })
          .catchError((e) {});
    }
  }
}
