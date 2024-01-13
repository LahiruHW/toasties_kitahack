import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toasties_flutter/common/utility/toastie_auth.dart';

/// Provider for the current user instance
class ToastieAuthProvider extends ChangeNotifier {
  
  String? userName;
  User? user;
  final authService = ToastiesAuthService();

  // final WordGenerator wordGenerator = WordGenerator();

  ToastieAuthProvider() {

    authService.onAuthStateChanged.listen((User? newUser) {
      if (newUser == null) {
        debugPrint('------------------------------ No user has currently logged in');
        user = null;
        notifyListeners();
      } else {
        setUserInstance(newUser);
      }
    });

    authService.onUserChanged.listen((User? newUser) {
      if (newUser == null) {
        debugPrint('------------------------------ AuthProvider user signed out');
        user = null;
        notifyListeners();
      } else {
        setUserInstance(newUser);
      }
    });

    debugPrint('------------------------------ AuthProvider initialized');
  }

  /// calls the sign in with email and password method from the auth service
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await authService.signInWithEmailAndPassword(email, password);
      setUserInstance(userCredential.user!);
      debugPrint('------------------------------ AuthProvider LegalEase Account user logged in');
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  /// calls the sign in with google method from the auth service
  Future<void> signInWithGoogle() async {
    try {
      UserCredential userCredential = await authService.signInWithGoogle();
      setUserInstance(userCredential.user!);
      debugPrint('------------------------------ AuthProvider Google Account user logged in');
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  /// calls the sign up with email and password method from the auth service
  /// and then sets the user instance, effectively logging the user in
  Future<void> signUpWithLegalEaseAccount(String email, String password, String? userName) async {
    try {
      UserCredential userCredential = await authService.signUpWithLegalEaseAccount(email, password, userName);
      setUserInstance(userCredential.user!);
      debugPrint('------------------------------ AuthProvider new LegalEase Account user signed up & logged in');
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  /// set all the user instance data after login or signup
  void setUserInstance(User user) async {
    user = user;
    debugPrint('------------------------------ AuthProvider user set');
    notifyListeners();
  }


  /// clear the user instance after sign out
  Future<void> clearUserInstance() async {
    await authService.signOut();
    user = null;
    debugPrint('------------------------------ AuthProvider user signed out & cleared');
    notifyListeners();
  }

  /// refresh the state of the user
  Future<void> refreshUser() async {
    await user!.reload();
    notifyListeners();
  }

}
