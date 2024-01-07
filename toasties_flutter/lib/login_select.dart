import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:toasties_flutter/common/utility/toastie_auth.dart';
import 'package:toasties_flutter/common/widgets/colour_switch_toggle.dart';
import 'package:toasties_flutter/common/widgets/google_action_button.dart';
import 'package:toasties_flutter/common/widgets/legalease_action_button.dart';

class LoginTypeSelectPage extends StatefulWidget {
  const LoginTypeSelectPage({
    super.key,
  });

  @override
  State<LoginTypeSelectPage> createState() => _LoginTypeSelectPageState();
}

class _LoginTypeSelectPageState extends State<LoginTypeSelectPage> {
  User? user;
  ToastiesAuthService authService = ToastiesAuthService();
  late final StreamSubscription<User?> authStateChangesMonitor;

  @override
  void initState() {
    super.initState();
    authStateChangesMonitor =
        ToastiesAuthService.auth.authStateChanges().listen((User? user) {
      setState(() => this.user = user);
    });
  }

  @override
  void dispose() {
    authStateChangesMonitor.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "LegalEase",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 40,
                    ),
              ),
              const SizedBox(height: 15),
              GoogleActionButton(
                onPressed: () => ToastiesAuthService.signInWithGoogle(),
                title: "Login with Google",
                titleColor: Theme.of(context)
                            .colorScheme
                            .background
                            .computeLuminance() <
                        0.5
                    ? Colors.black
                    : Colors.white,
              ),
              const SizedBox(height: 15),
              LegalEaseActionButton(
                onPressed: () {},
                title: "Login with LegalEase account",
                titleColor: Theme.of(context)
                            .colorScheme
                            .background
                            .computeLuminance() <
                        0.5
                    ? Colors.black
                    : Colors.white,
              ),
              const SizedBox(height: 15),
              RichText(
                textWidthBasis: TextWidthBasis.longestLine,
                maxLines: 2,
                textAlign: TextAlign.center,
                softWrap: false,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "No user account? ",
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            fontSize: 14,
                          ),
                    ),
                    TextSpan(
                      text: "Click here",
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 14,
                          ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print("Sign-up clicked");
                        },
                    ),
                    TextSpan(
                      text: " to Sign-Up ",
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(),
              ),
              const ToastiesThemeModeToggle()
            ],
          ),
        ),
      ),
    );
  }
}
