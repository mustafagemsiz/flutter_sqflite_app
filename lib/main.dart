import 'package:flutter/material.dart';
import 'package:flutter_sqflite_app/screens/product_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: ProductList(),
    );

  }
 
}
