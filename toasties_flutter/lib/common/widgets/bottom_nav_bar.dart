import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ToastiesBottomNavBar extends StatefulWidget {
  const ToastiesBottomNavBar({
    super.key,
    this.index,
  });

  final int? index;

  @override
  State<ToastiesBottomNavBar> createState() => _ToastiesBottomNavBarState();
}

class _ToastiesBottomNavBarState extends State<ToastiesBottomNavBar> {
  late int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.index ?? 0;
  }

  void _onTapped(int index) {
    setState(() => selectedIndex = index);

    switch (index) {
      case 0:
        GoRouter.of(context).push('/home');
        break;
      case 1:
        GoRouter.of(context).push('/chat');
        break;
      case 2:
        GoRouter.of(context).push('/saved');
        break;
      case 3:
        GoRouter.of(context).push('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 1,
      currentIndex: selectedIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home_sharp),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_outlined),
          activeIcon: Icon(Icons.chat_rounded),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_border_rounded),
          activeIcon: Icon(Icons.bookmark_rounded),
          label: 'Saved',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_rounded),
          activeIcon: Icon(Icons.person_rounded),
          label: 'Profile',
        ),
      ],
      onTap: _onTapped,
    );
  }
}
