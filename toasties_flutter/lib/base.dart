// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:toasties_flutter/common/providers/state_provider.dart';
import 'package:toasties_flutter/common/widgets/bottom_nav_bar.dart';
import 'package:toasties_flutter/common/widgets/side_nav_drawer.dart';
import 'package:toasties_flutter/common/widgets/toasties_appbar.dart';

class Base extends StatefulWidget {
  const Base({super.key, required this.bodyWidget});

  final StatefulNavigationShell bodyWidget;

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  final GlobalKey<ScaffoldState> globalKey = GlobalKey();

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
        key: globalKey,
        drawerEnableOpenDragGesture: true,
        drawerEdgeDragWidth: MediaQuery.of(context).size.width / 2,
        appBar: ToastiesAppBar(
          showBackButton: true,
          showTitle: true,
          trailing: IconButton(
            icon: const Icon(Icons.menu),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: MaterialStateProperty.all<Color>(
                Colors.transparent,
              ),
            ),
            onPressed: () => globalKey.currentState!.openEndDrawer(),
          ),
        ),

        body: widget.bodyWidget,

        endDrawer: const ToastiesSideNavMenu(),

        // bottomNavigationBar: const ToastiesBottomNavBar(),
        bottomNavigationBar: const ToastiesBottomNavBar(
        ),

        // floatingActionButton: FloatingActionButton(
        //   child: provider.settings.isDarkMode ? const Icon(Icons.dark_mode) : const Icon(Icons.light_mode),
        //   onPressed: () => switchColourMode(provider),
        // )
      ),
    );
  }
}
