import 'package:flutter/material.dart';
import 'package:flutter_woocomerce/utlils/progressHUD.dart';

class BasePage extends StatefulWidget {
  BasePage({Key key}) : super(key: key);

  @override
  BasePageState createState() => BasePageState();
}

class BasePageState<T extends BasePage> extends State<T> {
  bool isApiCallProcess = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ProgressHUD(
        child: PageUI(),
        inAsyncCall: isApiCallProcess,
        opacity: .3,
      ),
    );
  }
  Widget PageUI(){
    return null;
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
  @override
  void dispose() {
    super.dispose();
  }
}

