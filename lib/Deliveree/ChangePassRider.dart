import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_3/Deliveree/ScreenRider.dart';
import 'package:flutter_application_3/Home.dart';
import 'package:flutter_application_3/Login/user_login.dart';
import 'package:flutter_application_3/UserShop/ScreenShop.dart';
import 'package:flutter_application_3/global_variables.dart';
import 'package:flutter_application_3/user/Login.dart';

class ChangePassRider extends StatefulWidget {
  @override
  _ChangePassRiderState createState() => _ChangePassRiderState();
}

class _ChangePassRiderState extends State<ChangePassRider>
    with TickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  var newPassword = " ";
  final newPasswordController = TextEditingController();

  final currentUser = FirebaseAuth.instance.currentUser;
  bool _isObscure2 = true;
  bool visible = false;

  ChangePass() async {
    try {
      await currentUser!.updatePassword(newPassword);
      FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return LoginPage();
      }));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black26,
          content: Text("คุณได้เปลี่ยนรหัสผ่านแล้วครับ"),
        ),
      );
    } catch (error) {}
  }

  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void dispose() {
    newPasswordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
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
                  title: Text("เปลี่ยนรหัสผ่าน",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
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
                          return ScreenRider();
                        }),
                      );
                    },
                  ),
                ),
                body: Stack(children: [
                  CachedNetworkImage(
                    imageUrl: ChangeUrlImage,
                    placeholder: (context, url) => Image.asset(
                      'images/c1.jpg',
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
                          child: ListView(children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Form(
                                key: formKey,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: TextFormField(
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
                                            border: InputBorder.none,
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintText: 'รหัสผ่าน',
                                            enabled: true,
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    left: 14.0,
                                                    bottom: 8.0,
                                                    top: 15.0),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.white),
                                              borderRadius:
                                                  new BorderRadius.circular(10),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.white),
                                              borderRadius:
                                                  new BorderRadius.circular(10),
                                            ),
                                          ),
                                          style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 3, 3, 3)),
                                          controller: newPasswordController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return " กรุณาใส่รหัสผ่าน";
                                            }
                                            return null;
                                          },
                                        ),
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
                                              child: Text("เปลี่ยนรหัสผ่าน",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255))),
                                              onPressed: () {
                                                // showDialog(
                                                //     context: context,
                                                //     builder: (_) => AlertDialog(
                                                //           title: Text(
                                                //               "คุณแน่ใจที่จะเปลี่ยนรหัสผ่าน?"),
                                                //           // content: Text(
                                                //           //     "แก้ไขแล้วข้อมูลเดิมจะหายไป!"),
                                                //           actions: [
                                                //             MaterialButton(
                                                //               onPressed: () {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  setState(() {
                                                    newPassword =
                                                        newPasswordController
                                                            .text;
                                                    ChangePass();
                                                  });
                                                }
                                                //     },
                                                //     child:
                                                //         Text("ใช่"),
                                                //   ),
                                                //   MaterialButton(
                                                //     onPressed: () {
                                                //       Navigator.pop(
                                                //           context);
                                                //     },
                                                //     child:
                                                //         Text("ไม่"),
                                                //   ),
                                                // ],
                                                // ));
                                                // if (formKey.currentState!
                                                //     .validate()) {
                                                //   setState(() {
                                                //     newPassword =
                                                //         newPasswordController
                                                //             .text;
                                                //   });
                                                //   ChangePass();
                                                // }
                                              }),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ])))
                ]));
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
