// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toasties_flutter/common/state_provider.dart';
import 'package:toasties_flutter/common/widgets/bottom_nav_bar.dart';
import 'package:toasties_flutter/common/widgets/toasties_appbar.dart';

class Base extends StatefulWidget {
  const Base({
    super.key,
    required this.bodyWidget
  });

  final Widget bodyWidget;

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {

  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ToastieStateProvider>(
      builder: (context, provider, child) => Scaffold(
        appBar: ToastiesAppBar(
          appBarTitle: "LegalEase",
          showBackButton: false,
          showTitle: true,
          trailing: IconButton(
            icon: const Icon(Icons.menu),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: () {},
          ),
        ),

        body: widget.bodyWidget,

        bottomNavigationBar: const ToastiesBottomNavBar()

      ),
    );
  }
}
