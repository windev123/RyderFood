import 'package:flutter/material.dart';
import 'package:flutter_application_3/Deliveree/MeRider.dart';
import 'package:flutter_application_3/Deliveree/OrderRider.dart';
import 'package:flutter_application_3/UserShop/AddProduct.dart';
import 'package:flutter_application_3/UserShop/EditProduct.dart';
import 'package:flutter_application_3/UserShop/MeShop.dart';
import 'package:flutter_application_3/UserShop/product.dart';
import 'package:flutter_application_3/UserShop/user_shop.dart/OrderShop.dart';

class ScreenRider extends StatefulWidget {
  const ScreenRider({Key? key}) : super(key: key);

  @override
  State<ScreenRider> createState() => _ScreenRiderState();
}

class _ScreenRiderState extends State<ScreenRider> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    MeRider(),
    OrderRider(),
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
            icon: Icon(Icons.article_outlined),
            label: 'Me',
            backgroundColor: Color.fromARGB(215, 188, 187, 187),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Order',
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
