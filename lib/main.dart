import "dart:io";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Home.dart';
import 'package:flutter_application_3/HomeShop/homeshop.dart';
import 'package:flutter_application_3/Login/HomeScreen.dart';
import 'package:flutter_application_3/Login/Forgotpass.dart';
import 'package:flutter_application_3/Login/mainscreen.dart';
import 'package:flutter_application_3/Login/user_Signup.dart';
import 'package:flutter_application_3/Login/user_login.dart';
import 'package:flutter_application_3/Shop.dart';
import 'package:flutter_application_3/download%20page/download_page.dart';
import 'package:flutter_application_3/firebase/FirebaseScreen.dart';
import 'package:flutter_application_3/user/Login.dart';
import 'package:flutter_application_3/user/UserForm.dart';
import 'package:flutter_application_3/user/image.dart';
import 'package:flutter_application_3/user/sign%20in.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    // providers: [
    //   Provider<AuthService>(
    //     create: (_) => AuthService(FirebaseAuth.instance),
    //   ),
    //   StreamProvider(
    //     create: ((context) => context.read<AuthService>().authStateChanges),
    //     initialData: null,
    //   ),
    // ],
    // child:
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RyderFood',
      home: DownloadPage(),
    );
    // );
  }
}
