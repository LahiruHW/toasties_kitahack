import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:toasties_flutter/chat.dart';
import 'package:toasties_flutter/base.dart';
import 'package:toasties_flutter/common/settings_page.dart';
import 'package:toasties_flutter/entrance_base.dart';
import 'package:toasties_flutter/home.dart';
import 'package:toasties_flutter/login_select.dart';
import 'package:toasties_flutter/profile.dart';
import 'package:toasties_flutter/saved.dart';

class ToastieRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      // GoRoute(
      //   path: '/',
      //   pageBuilder: (context, state) => const MaterialPage(
      //     child: Base(
      //       bodyWidget: HomePage(),
      //     ),
      //   ),
      // ),
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => const MaterialPage(
          child: LoginTypeSelectPage(),
        ),
      ),

      // ShellRoute for the app BEFORE user login (i.e. during login/signup)
      ShellRoute(
        routes: [
          GoRoute(
            name: 'login-base',
            path: '/login-base',
            pageBuilder: (context, state) =>
                const MaterialPage(child: LoginTypeSelectPage()),
          ),
          // goroute for 
        ],
        builder: (context, state, child) => BaseEntrace(bodyWidget: child),
      ),

      // ShellRoute for the app AFTER the user has logged in
      ShellRoute(
        routes: [
          GoRoute(
            name: 'home',
            path: '/home',
            pageBuilder: (context, state) =>
                const MaterialPage(child: HomePage(), maintainState: true),
          ),
          GoRoute(
            name: "chat",
            path: '/chat',
            pageBuilder: (context, state) =>
                const MaterialPage(child: ChatPage(), maintainState: true),
          ),
          GoRoute(
            name: "saved",
            path: '/saved',
            pageBuilder: (context, state) =>
                const MaterialPage(child: SavedPage(), maintainState: true),
          ),
          GoRoute(
            name: "profile",
            path: '/profile',
            pageBuilder: (context, state) =>
                const MaterialPage(child: ProfilePage(), maintainState: true),
          ),
        ],
        builder: (context, state, child) => Base(bodyWidget: child),
      ),
      GoRoute(
        name: "settings",
        path: '/settings',
        pageBuilder: (context, state) =>
            const MaterialPage(child: SettingsPage(), maintainState: true),
      ),
    ],
  );
}
