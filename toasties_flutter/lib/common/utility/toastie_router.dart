import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:toasties_flutter/chat.dart';
import 'package:toasties_flutter/base.dart';
import 'package:toasties_flutter/common/settings_page.dart';
import 'package:toasties_flutter/home.dart';
import 'package:toasties_flutter/login/entrance_base.dart';
import 'package:toasties_flutter/login/login_legalease.dart';
import 'package:toasties_flutter/login/login_select.dart';
import 'package:toasties_flutter/profile.dart';
import 'package:toasties_flutter/saved.dart';

class ToastieRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login-base',
    routes: <RouteBase>[
      // GoRoute(
      //   path: '/',
      //   pageBuilder: (context, state) => const MaterialPage(
      //     child: Base(
      //       bodyWidget: HomePage(),
      //     ),
      //   ),
      // ),

      // ShellRoute for the app BEFORE user login (i.e. during login/signup)
      ShellRoute(
        routes: [
          GoRoute(
            name: "login-base",
            path: '/login-base',
            pageBuilder: (context, state) =>
                const MaterialPage(child: LoginTypeSelectPage()),
          ),
          GoRoute(
            name: "login-uac",
            path: '/login-uac',
            // custom page transition to slide the page in from the right side
            pageBuilder: (context, state) => CustomTransitionPage(
              barrierColor:
                  Theme.of(context).colorScheme.background.computeLuminance() <
                          0.5
                      ? Colors.black.withOpacity(0.5)
                      : Colors.white.withOpacity(0.5),
              transitionDuration: const Duration(milliseconds: 500),
              reverseTransitionDuration: const Duration(milliseconds: 500),
              child: const LoginLegalEase(),
              transitionsBuilder: (context, anim1, anim2, child) {
                // ideally I prefer a PageView-like slide transition,
                // but I got no idea how to do that within GoRouter()
                // (the normal SlideTransition only works for the incoming page)
                return FadeTransition(opacity: anim1, child: child);
              },
              maintainState: true,
            ),
          ),
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
