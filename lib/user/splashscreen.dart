import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Home.dart';
import 'package:flutter_application_3/UserShop/ScreenShop.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String role = "user";
  @override
  void initeState() {
    super.initState();
    _checkRole();
  }

  void _checkRole() async {
    User user = FirebaseAuth.instance.currentUser!;
    final DocumentSnapshot snap =
        await FirebaseFirestore.instance.collection("user").doc(user.uid).get();

    setState(() {
      role = snap['role'];
    });
    if (role == 'user') {
      navigateNext(Home());
    } else if (role == 'admin') {
      navigateNext(ScreenShop());
    }
  }

  void navigateNext(Widget route) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => route));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("welcome"),
          ],
        ),
      ),
    );
  }
}
