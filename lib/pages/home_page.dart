import 'package:flutter/material.dart';
import 'package:flutter_woocomerce/pages/dashboard_page.dart';
import 'package:flutter_woocomerce/utlils/cart_icons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> _widgetList = [
    DashboardPage(),
    DashboardPage(),
    DashboardPage(),
    DashboardPage(),
  ];
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              CartIcons.home,
            ),
            title: Text(
              'store',
              style: TextStyle(),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CartIcons.cart,
            ),
            title: Text(
              'My CART',
              style: TextStyle(),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CartIcons.favourite,
            ),
            title: Text(
              'Favourite',
              style: TextStyle(),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CartIcons.account,
            ),
            title: Text(
              ' My Account',
              style: TextStyle(),
            ),
          ),


        ],
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.shifting,
        currentIndex: _index,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
      body: _widgetList[_index],
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      brightness: Brightness.dark,
      elevation: 0,
      backgroundColor: Colors.redAccent,
      automaticallyImplyLeading: false,
      title: Text(
        'Sleem Store',
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        Icon(
          Icons.notifications_none,
          color: Colors.white,
        ),
        SizedBox(
          width: 10,
        ),
        Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
