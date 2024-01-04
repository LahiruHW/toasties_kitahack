// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toasties_flutter/common/state_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDarkMode = false;

  // int _selectedIndex = 0;

  void switchColourMode(ToastieStateProvider provider) {
    final temp = !isDarkMode;
    provider.updateSettings(
      isDarkMode: temp,
    );
    setState(() {
      isDarkMode = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ToastieStateProvider>(
      builder: (context2, provider, child) => Scaffold(        
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Nigga mode:',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Text(
                '${isDarkMode ? "ON" : "NAH"}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
  
    floatingActionButton: FloatingActionButton(
      onPressed: () => switchColourMode(provider),
    ),


      ),
    );
  }
}
