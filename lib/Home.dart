import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Cart/cart_data.dart';
import 'package:flutter_application_3/MySearchDelegate.dart';
import 'package:flutter_application_3/Shop.dart';
import 'package:flutter_application_3/item_description.dart';
import 'package:flutter_application_3/user/Favourite.dart';
import 'package:flutter_application_3/user/Me.dart';

import 'HomeShop/homeshop.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeShop(),
    FavouriteScreen(),
    Text("aaaa"),
    Me(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
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
