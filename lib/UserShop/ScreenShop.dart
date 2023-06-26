import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/UserShop/AddProduct.dart';
import 'package:flutter_application_3/UserShop/EditProduct.dart';
import 'package:flutter_application_3/UserShop/MeShop.dart';
import 'package:flutter_application_3/UserShop/product.dart';
import 'package:flutter_application_3/UserShop/user_shop.dart/OrderShop.dart';

class ScreenShop extends StatefulWidget {
  const ScreenShop({Key? key}) : super(key: key);

  @override
  State<ScreenShop> createState() => _ScreenShopState();
}

class _ScreenShopState extends State<ScreenShop> {
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
}
