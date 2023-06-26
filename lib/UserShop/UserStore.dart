import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Cart/cart_data.dart';
import 'package:flutter_application_3/Home.dart';
import 'package:flutter_application_3/HomeShop/homeshop.dart';
import 'package:flutter_application_3/Login/StudentList.dart';
import 'package:flutter_application_3/Login/model.dart';
import 'package:flutter_application_3/Login/posts.dart';
import 'package:flutter_application_3/Login/user_login.dart';
import 'package:flutter_application_3/UserShop/AddProduct.dart';
import 'package:flutter_application_3/UserShop/EditProduct.dart';
import 'package:flutter_application_3/UserShop/MeShop.dart';
import 'package:flutter_application_3/UserShop/user_shop.dart/OrderShop.dart';
import 'package:flutter_application_3/user/Favourite.dart';
import 'package:flutter_application_3/user/Me.dart';

class UserStore extends StatefulWidget {
  String id;
  UserStore({required this.id});
  @override
  _UserStoreState createState() => _UserStoreState(id: id);
}

class _UserStoreState extends State<UserStore> {
  String id;
  var rooll;
  var emaill;
  UserModel loggedInUser = UserModel();

  _UserStoreState({required this.id});
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users") //.where('uid', isEqualTo: user!.uid)
        .doc(id)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
    }).whenComplete(() {
      CircularProgressIndicator();
      setState(() {
        emaill = loggedInUser.email.toString();
        rooll = loggedInUser.wrool.toString();
        id = loggedInUser.uid.toString();
      });
    });
  }

  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    AddProduct(),
    EditProduct(),
    OrderShop(),
    MeShop(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart_outlined),
            label: 'Add',
            backgroundColor: Color.fromARGB(215, 188, 187, 187),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_settings_alt_rounded),
            label: 'Edit',
            backgroundColor: Color.fromARGB(215, 188, 187, 187),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            label: 'Order',
            backgroundColor: Color.fromARGB(215, 188, 187, 187),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Me',
            backgroundColor: Color.fromARGB(215, 188, 187, 187),
          ),
        ],
        elevation: 0,
        currentIndex: _selectedIndex,
        selectedFontSize: 16,
        unselectedFontSize: 12,
        selectedItemColor: Color.fromARGB(255, 255, 156, 70),
        onTap: _onItemTapped,
      ),
    );
  }

  // Future<void> logout(BuildContext context) async {
  //   CircularProgressIndicator();
  //   await FirebaseAuth.instance.signOut();

  //   Navigator.of(context).pushReplacement(
  //     MaterialPageRoute(
  //       builder: (context) => LoginPage(),
  //     ),
  //   );
  // }
}
