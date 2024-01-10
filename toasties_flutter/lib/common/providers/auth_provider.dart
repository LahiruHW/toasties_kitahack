import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toasties_flutter/common/utility/toastie_auth.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';

///////////// SIGN IN / LOG IN

// 1. get the user credentials from the login/signup page

// 2. retrieve the user data from the database, including settings, chat data, etc.

// 3. update the state of the app using this data received

///////////// SIGN OUT / LOG OUT

// 1. sign out the user from firebase

class ToastieAuthProvider extends ChangeNotifier {
  User? user;

  // final WordGenerator wordGenerator = WordGenerator();

  ToastieAuthProvider({User? user}) {
    debugPrint('------------------------------ AuthProvider initialized');
  }

  /// set the user instance after login (and sign out previous user if any)
  void setUserInstance(User newUser) async {

    // if the current user is not null, sign out first
    if (user != null) {
      ToastiesAuthService.signOut().then((value) {
        user = null;
        debugPrint(
            '------------------------------ AuthProvider user signed out');
      });
    }

    user = newUser;
    debugPrint('------------------------------ AuthProvider user changed');

    // if the user display name is null, set it to a default random name
    if (user!.displayName == null) {
      final randomName = ToastiesAuthService.getRandomName();
      user!.updateDisplayName(randomName).then(
            (value) => user!.reload().then(
              (value) {
                debugPrint(
                    '------------ user.displayName updated to ${user!.displayName}');
                notifyListeners();
              },
            ),
          );
    }
  }
}
