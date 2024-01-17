import 'package:flutter/material.dart';

class SavedPage extends StatelessWidget{
  SavedPage({
    super.key,
  });

  final GlobalKey<NavigatorState> _savedNavKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _savedNavKey,
      body: Center(
        child: Text(
          'Saved Page',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
