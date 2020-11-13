import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key key, this.categoryId});

  int categoryId;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(this.widget.categoryId.toString()),
    );
  }
}
