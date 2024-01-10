import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:word_generator/word_generator.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';

///////////// SIGN IN / LOG IN

// 1. get the user credentials from the login/signup page

// 2. retrieve the user data from the database, including settings, chat data, etc.

// 3. update the state of the app using this data received

///////////// SIGN OUT / LOG OUT

// 1. sign out the user from firebase

class ToastieAuthProvider extends ChangeNotifier {
  late User user;

  final WordGenerator wordGenerator = WordGenerator();

  ToastieAuthProvider({User? user}) {
    debugPrint('------------------------------ AuthProvider initialized');
  }

  /// set the user instance after login
  void setUserInstance(User newUser) async {
    user = newUser;
    debugPrint('------------------------------ AuthProvider user changed');

    // if the user display name is null, set it to a default random name
    if (user.displayName == null) {
      final randomVerb = wordGenerator.randomVerb();
      final randomNoun = wordGenerator.randomNoun();
      user.updateDisplayName("$randomVerb $randomNoun").then(
            (value) => user.reload().then(
              (value) {
                debugPrint(
                    '------------ user.displayName updated to ${user.displayName}');
                notifyListeners();
              },
            ),
          );
    }

    // ToastieStateProvider(initSettings: settings); // do this later to update the settings
  }

}
