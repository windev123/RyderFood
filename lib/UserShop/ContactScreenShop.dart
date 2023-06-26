import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Home.dart';
import 'package:flutter_application_3/UserShop/ScreenShop.dart';
import 'package:flutter_application_3/global_variables.dart';

class ContactScreen2 extends StatefulWidget {
  @override
  State<ContactScreen2> createState() => _ContactScreen2State();
}

class _ContactScreen2State extends State<ContactScreen2>
    with TickerProviderStateMixin {
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
                  title: Text("ติดต่อฝ่ายสนับสนุน",
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
                          return ScreenShop();
                        }),
                      );
                    },
                  ),
                ),
                body: Stack(children: [
                  CachedNetworkImage(
                    imageUrl: ContactUrlImage,
                    placeholder: (context, url) => Image.asset(
                      'images/food2.jpg',
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
                              horizontal: 50, vertical: 160),
                          child: ListView(children: [
                            Container(
                              height: 350,
                              color: Colors.white.withOpacity(0.7),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            "images/logo3.png",
                                            height: 40,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Winta Nawin Yarangsee",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      // Text(
                                      //   "data",
                                      //   style: TextStyle(fontSize: 20),
                                      // ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.phone_android,
                                            size: 40,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "095665478",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      // Text(
                                      //   "data",
                                      //   style: TextStyle(fontSize: 20),
                                      // ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            "images/logo4.png",
                                            height: 40,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "nawin3690",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      // Text(
                                      //   "data",
                                      //   style: TextStyle(fontSize: 20),
                                      // ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            "images/logo5.png",
                                            height: 25,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "nawin5310@gmail.com",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                            // Padding(
                            //   padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
                            //   child: Image.asset(
                            //     "images/logo1.png",
                            //     height: 180,
                            //   ),
                            // ),
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
