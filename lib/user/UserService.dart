import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Cart/cart_data.dart';
import 'package:flutter_application_3/Cart/onderuser.dart/onderuser.dart';
import 'package:flutter_application_3/Cart/orderuser.dart';
import 'package:flutter_application_3/HomeShop/homeshop.dart';
import 'package:flutter_application_3/Login/model.dart';
import 'package:flutter_application_3/Login/user_login.dart';
import 'package:flutter_application_3/UserShop/MeShop.dart';
import 'package:flutter_application_3/user/Favourite.dart';
import 'package:flutter_application_3/user/Me.dart';

class ServiceUser extends StatefulWidget {
  ServiceUser({required this.id});

  String id;

  @override
  _ServiceUserState createState() => _ServiceUserState(id: id);
}

class _ServiceUserState extends State<ServiceUser> {
  _ServiceUserState({required this.id});

  var emaill;
  String id;
  UserModel loggedInUser = UserModel();
  var rooll;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeShop(),
    FavouriteScreen(),
    Cart(),
    OrderUser(),
    Me(),
  ];

  int _selectedIndex = 0;

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
            icon: Icon(Icons.local_mall_outlined),
            label: 'Shop',
            backgroundColor: Color.fromARGB(215, 188, 187, 187),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Favourite',
            backgroundColor: Color.fromARGB(215, 188, 187, 187),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_grocery_store_outlined),
            label: 'Cart',
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
}


//   int _selectedIndex = 0;
//   static const List<Widget> _widgetOptions = <Widget>[
//     Text("data"),
//     Text("data"),
//     Text("data"),
//     MeShop(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _widgetOptions.elementAt(_selectedIndex),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add_shopping_cart_outlined),
//             label: 'Add',
//             backgroundColor: Color.fromARGB(215, 188, 187, 187),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.message_outlined),
//             label: 'Test',
//             backgroundColor: Color.fromARGB(215, 188, 187, 187),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.local_grocery_store_outlined),
//             label: 'Order',
//             backgroundColor: Color.fromARGB(215, 188, 187, 187),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.account_circle),
//             label: 'Me',
//             backgroundColor: Color.fromARGB(215, 188, 187, 187),
//           ),
//         ],
//         elevation: 0,
//         currentIndex: _selectedIndex,
//         selectedFontSize: 16,
//         unselectedFontSize: 12,
//         selectedItemColor: Color.fromARGB(255, 255, 156, 70),
//         onTap: _onItemTapped,
//       ),
//     );
//   }

//   Future<void> logout(BuildContext context) async {
//     CircularProgressIndicator();
//     await FirebaseAuth.instance.signOut();

//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(
//         builder: (context) => LoginPage(),
//       ),
//     );
//   }
// }
