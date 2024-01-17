import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final GlobalKey<NavigatorState> _homeNavKey = GlobalKey<NavigatorState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _homeNavKey,
      body: Center(
        child: Text(
          'Home Page',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
