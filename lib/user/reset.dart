import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Home.dart';
import 'package:flutter_application_3/Login/user_login.dart';
import 'package:flutter_application_3/firebase/profile.dart';
import 'package:flutter_application_3/global_variables.dart';
import 'package:flutter_application_3/user/Login.dart';
import 'package:flutter_application_3/user/Registe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ResetScreen extends StatefulWidget {
  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen>
    with TickerProviderStateMixin {
  Future resetPassword() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black26,
          content: Text("รีเซ็ตรหัสผ่านได้ถูกส่งไปที่อีเมล์แล้วครับ"),
        ),
      );
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e);

      Navigator.of(context).pop();
    }
  }

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  Profile profile = Profile();
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
                          horizontal: 15, vertical: 50),
                      child: ListView(
                        children: [
                          SizedBox(
                            height: 0,
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
                                        textInputAction: TextInputAction.done,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller: emailController,
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
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          80, 0, 0, 0),
                                      child: SizedBox(
                                        height: 35,
                                        width: 170,
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .all<Color>(Colors.white
                                                          .withOpacity(0.5)),
                                              fixedSize:
                                                  MaterialStateProperty.all(
                                                      Size(100, 40)),
                                            ),
                                            child: Text("ส่ง",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Color.fromARGB(
                                                        255, 253, 253, 253))),
                                            onPressed: () {
                                              resetPassword();
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
