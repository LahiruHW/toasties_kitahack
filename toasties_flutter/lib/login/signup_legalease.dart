import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:toasties_flutter/common/providers/auth_provider.dart';
import 'package:toasties_flutter/common/providers/state_provider.dart';
import 'package:toasties_flutter/common/utility/toastie_auth.dart';

/// Login page for LegalEase User Accounts, does not validate password for obvious reasons
class SignupLegalEase extends StatefulWidget {
  const SignupLegalEase({
    super.key,
  });

  @override
  State<SignupLegalEase> createState() => _SignupLegalEaseState();
}

class _SignupLegalEaseState extends State<SignupLegalEase> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _unameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  User? user;
  ToastiesAuthService authService = ToastiesAuthService();
  late final StreamSubscription<User?> authStateChangesMonitor;

  String unameText = "";
  String emailText = "";
  String passwordText = "";

  bool isPasswordHidden = true;
  bool isUsernameValid = false;
  bool isEmailValid = false;
  bool isPasswordValid = false;
  final emailRegex = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  /// validate email address
  String? validateUsername(value) {
    String? retVal = "";
    if (value.isEmpty) {
      retVal =
          "if you don't enter an email address, one will be generated for you";
    } else {
      retVal = null;
    }
    return retVal;
  }

  /// validate email address
  String? validateEmail(value) {
    String? retVal = "";
    if (value.isEmpty) {
      retVal = "Please enter an email address";
    } else if (!emailRegex.hasMatch(value)) {
      retVal = "invalid email address";
    } else {
      retVal = null;
    }
    return retVal;
  }

  /// validate password
  String? validatePassword(value) {
    String? retVal = "";
    if (value.isEmpty) {
      retVal = "Please enter a password";
    } else if (value.length < 6) {
      retVal = "Password must be at least 6 characters long";
    } else {
      retVal = null;
    }
    return retVal;
  }

  void getUsernameValidStatus(value) {
    bool retVal = false;
    final result = validateUsername(value);
    retVal = result == null ? true : false;
    isUsernameValid = retVal;
  }

  void getEmailValidStatus(value) {
    bool retVal = false;
    final result = validateEmail(value);
    retVal = result == null ? true : false;
    isEmailValid = retVal;
  }

  void getPasswordValidStatus(value) {
    bool retVal = false;
    final result = validatePassword(value);
    retVal = result == null ? true : false;
    isPasswordValid = retVal;
  }

  togglePasswordVisibility() {
    setState(() => isPasswordHidden = !isPasswordHidden);
  }

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() {
      getEmailValidStatus(_emailController.text);
      emailText = _emailController.text;
      setState(() {});
    });

    _pwdController.addListener(() {
      getPasswordValidStatus(_pwdController.text);
      passwordText = _pwdController.text;
      setState(() {});
    });

    _unameController.addListener(() {
      getUsernameValidStatus(_unameController.text);
      unameText = _unameController.text;
      setState(() {});
    });

    authStateChangesMonitor =
        ToastiesAuthService.auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print("User is currently signed out!");
      } else {
        setState(() => this.user = user);
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _pwdController.dispose();
    authStateChangesMonitor.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ToastieAuthProvider, ToastieStateProvider>(
      builder: (context, authProvider, stateProvider, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "LegalEase",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 40),
              ),
              const SizedBox(height: 60),
              Text(
                "Please enter the details required for a new LegalEase account below",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 25),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Username",
                      // textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextFormField(
                      controller: _unameController,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: Colors.black),
                      decoration: InputDecoration(
                        errorText: isUsernameValid
                            ? null
                            : "Optional (or generate one for yourself with the '?' :D)",
                        errorStyle: const TextStyle(
                          color: Colors.green,
                        ),
                        prefixIcon: IconButton(
                          icon: const Icon(
                            IconData(0xf064c, fontFamily: 'MaterialIcons'),
                            color: Colors.black,
                          ),
                          onPressed: () => setState(() {
                            _unameController.text =
                                ToastiesAuthService.getRandomName();
                          }),
                          color: Colors.black,
                        ),
                        suffixIcon: isUsernameValid
                            ? const Icon(Icons.check, color: Colors.green)
                            : null,
                      ),
                      maxLines: 1,
                      minLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      validator: validateUsername,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Email",
                      // textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextFormField(
                      controller: _emailController,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: Colors.black),
                      decoration: InputDecoration(
                        suffixIcon: isEmailValid
                            ? const Icon(Icons.check, color: Colors.green)
                            : null,
                      ),
                      maxLines: 1,
                      minLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      validator: validateEmail,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Password",
                      // textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextFormField(
                      controller: _pwdController,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: Colors.black),
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          icon: Icon(
                            isPasswordHidden
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: togglePasswordVisibility,
                          color: Colors.black,
                        ),
                        suffixIcon: isPasswordValid
                            ? const Icon(Icons.check, color: Colors.green)
                            : null,
                      ),
                      obscureText: isPasswordHidden,
                      obscuringCharacter: "●",
                      maxLines: 1,
                      minLines: 1,
                      validator: validatePassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            foregroundColor:
                                Theme.of(context).colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text("Sign Up"),
                          onPressed: () {
                            // create the account and update the user display name
                            ToastiesAuthService.signUpWithLegalEaseAccount(
                              emailText,
                              passwordText,
                              unameText,
                            ).then(
                              (userCred) {
                                // after creating the account, sign the user in
                                ToastiesAuthService.signInWithEmailAndPassword(
                                  emailText,
                                  passwordText,
                                ).then(
                                  (userCred) {
                                    authProvider
                                        .setUserInstance(userCred.user!);
                                    // SET STATE PROVIDER SETTINGS HERE (use async function)
                                    GoRouter.of(context).go("/home");
                                  },
                                );
                              },
                            );
                          }),
                    ),
                  ],
                ),
              ),
              user != null
                  ? Text(
                      "User ------- ${user!.uid}",
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  : Text(
                      "User is currently signed out!",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}