import 'package:flutter/material.dart';

import 'home.dart';

void main() => runApp(new MyApp());



class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: Home(),
      
    );
  }
}