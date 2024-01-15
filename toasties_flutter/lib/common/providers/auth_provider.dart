// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toasties_flutter/common/utility/toastie_auth.dart';
import 'package:toasties_flutter/common/utility/toasties_firestore_services.dart';
// import 'package:toasties_flutter/common/constants/login_type.dart';

/// Provider for the current user instance
class ToastieAuthProvider extends ChangeNotifier {
  
  String? userName;
  User? user;
  final authService = ToastiesAuthService();

  ToastieAuthProvider() {
    authService.onAuthStateChanged.listen(
      (User? newUser) => newUser != null ? setUserInstance(newUser) : null,
    );

    // authService.onUserChanged.listen(
    //   (User? newUser) => setUserInstance(newUser!),
    // );

    debugPrint('------------------------------ AuthProvider initialized');
  }

  /// calls the sign in with email and password method from the auth service
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await authService.signInWithEmailAndPassword(email, password).then(
      (userCred) {
        ToastiesFirestoreServices.setupUserProfile(userCred.user!.uid, null);
      },
    ).onError(
      (error, stackTrace) => throw Exception(error),
    );
  }

  // /// calls the sign in with google method from the auth service
  // Future<void> signInWithGoogle() async {
  //   try {
  //     UserCredential userCredential = await authService.signInWithGoogle();
  //     ToastiesFirestoreServices.setupUserProfile(
  //         userCredential.user!.uid, userCredential.user!.displayName);
  //     setUserInstance(userCredential.user!);
  //     debugPrint(
  //         '------------------------------ AuthProvider Google Account user logged in');
  //   } on FirebaseAuthException catch (e) {
  //     throw Exception(e);
  //   }
  // }
  /// calls the sign in with google method from the auth service
  Future<void> signInWithGoogle() async {
    await authService.signInWithGoogle().then(
      (userCred) {
        // wait for the sign in to complete and then setup the user profile
        Future.delayed(
          const Duration(seconds: 1),
          () => ToastiesFirestoreServices.setupUserProfile(
              userCred.user!.uid, null),
        );
      },
    ).onError(
      (error, stackTrace) => throw Exception(error),
    );
  }

  /// calls the sign up with email and password method from the auth service
  /// and then sets the user instance, effectively logging the user in
  Future<void> signUpWithLegalEaseAccount(
      String email, String password, String? userName) async {
    try {
      UserCredential userCredential = await authService
          .signUpWithLegalEaseAccount(email, password, userName);
      setUserInstance(userCredential.user!);
      ToastiesFirestoreServices.setupUserProfile(userCredential.user!.uid,
          userName); // initialize the user profile in firestore
      debugPrint(
          '------------------------------ AuthProvider new LegalEase Account user signed up & logged in');
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  /// set all the user instance data after login or signup
  void setUserInstance(User user) async {
    this.user = user;
    debugPrint('------------------------------ AuthProvider user set');
    notifyListeners();
  }

  Future<void> signOut() async {
    await authService.signOut();
    clearUserInstance();
  }

  /// clear the user instance after sign out
  void clearUserInstance() async {
    user = null;
    debugPrint(
        '------------------------------ AuthProvider user signed out & cleared');
    notifyListeners();
  }

  /// refresh the state of the user
  Future<void> refreshUser() async {
    await user!.reload();
    notifyListeners();
  }
}
