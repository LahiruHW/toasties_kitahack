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
                '${provider.settings.isDarkMode ? "ON" : "NAH"}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),

      ),
    );
  }
}
