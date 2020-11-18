import 'package:flutter/material.dart';
import 'package:flutter_woocomerce/pages/home_page.dart';
import 'package:flutter_woocomerce/pages/login_page.dart';
import 'package:flutter_woocomerce/pages/login_page.dart';
import 'package:flutter_woocomerce/pages/product_page.dart';
import 'package:flutter_woocomerce/pages/signup_page.dart';
import 'package:flutter_woocomerce/provider/product_provider.dart';
import 'package:provider/provider.dart';

import 'pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
          child: ProductPage(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter woostore',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: Colors.white,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            elevation: 0,
            foregroundColor: Colors.white,
          ),
          accentColor: Colors.redAccent,
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 22.0, color: Colors.redAccent),
            headline2: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
              color: Colors.redAccent,
            ),
            bodyText1: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: Colors.blueAccent,
            ),
          ),
        ),
        home: HomePage(),
      ),
    );
  }
}
