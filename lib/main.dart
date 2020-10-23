import 'package:flutter/material.dart';
import 'package:flutter_woocomerce/pages/login_page.dart';
import 'package:flutter_woocomerce/pages/signup_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter woostore',

      home:LoginPage(),
    );
  }
}
