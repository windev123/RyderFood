import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_3/Login/user_login.dart';
import 'package:flutter_application_3/user/Login.dart';
import 'package:flutter_application_3/user/sign%20in.dart';

class DownloadPage extends StatefulWidget {
  @override
  _DownloadPageState createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  @override
  void initState() {
    Timer(
        Duration(
          seconds: 3,
        ),
        () => Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (_) {
              return LoginPage();
            })));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 164, 158, 158),
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                width: 3000,
                height: 3000,
                decoration: const BoxDecoration(
                  gradient: RadialGradient(radius: 0.69, colors: [
                    Color.fromARGB(255, 252, 252, 252),
                    Colors.black,
                  ]),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Center(
                child: Container(
                  padding: EdgeInsets.fromLTRB(35, 0, 0, 0),
                  height: 2000,
                  width: 2500,
                  child: Image.asset(
                    'images/RF.png',
                  ),
                ),
              ),
            ),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     SizedBox(
            //       height: 220.0,
            //       width: 450,
            //     ),
            //     CircularProgressIndicator(
            //       color: Colors.white,
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
      // body: SafeArea(
      //   child: Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         Text(
      //           "DzenShop",
      //           style: TextStyle(
      //               color: Colors.white,
      //               fontWeight: FontWeight.bold,
      //               fontSize: 44),
      //         ),
      // SizedBox(height: 20.0),
      // CircularProgressIndicator(
      //   color: Colors.white,
      // ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
