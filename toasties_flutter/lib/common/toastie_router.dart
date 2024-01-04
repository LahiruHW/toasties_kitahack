import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:toasties_flutter/chat.dart';
import 'package:toasties_flutter/base.dart';
import 'package:toasties_flutter/home.dart';
import 'package:toasties_flutter/profile.dart';
import 'package:toasties_flutter/saved.dart';

class ToastieRouter {
  static final GoRouter router = GoRouter(
    
    initialLocation: '/',

    routes: <RouteBase>[
      // StatefulShellRoute.indexedStack(branches: branches)

      GoRoute(
        path: '/',
        pageBuilder: (context, state) => const MaterialPage(
          child: Base(
            bodyWidget: HomePage(),
          ),
        ),
      ),

      ShellRoute(
        routes: [
          GoRoute(
            name: 'home',
            path: '/home',
            pageBuilder: (context, state) =>
                const MaterialPage(child: HomePage()),
          ),
          GoRoute(
            name: "chat",
            path: '/chat',
            pageBuilder: (context, state) =>
                const MaterialPage(child: ChatPage()),
          ),
          GoRoute(
            name: "saved",
            path: '/saved',
            pageBuilder: (context, state) =>
                const MaterialPage(child: SavedPage()),
          ),
          GoRoute(
            name: "profile",
            path: '/profile',
            pageBuilder: (context, state) =>
                const MaterialPage(child: ProfilePage()),
          ),
        ],
        builder: (context, state, child) => Base(bodyWidget: child),
      ),
    ],
  );
}
