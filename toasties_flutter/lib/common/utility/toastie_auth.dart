// import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:word_generator/word_generator.dart";

class ToastiesAuthService {
  // instance of the firebase auth service
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<void> signOut() async {
    await auth.signOut();
  }

  /// Sign-in with email and password - returns a UserCredential object
  static Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  /// Sign in with Google - returns a UserCredential object
  static Future<UserCredential> signInWithGoogle() async {
    // static void signInWithGoogle() async {
    try {
      // Create a new provider
      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      UserCredential userCredential =
          await auth.signInWithProvider(googleProvider);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  static Future<UserCredential> signUpWithLegalEaseAccount(
      String email, String password, String? userName) async {
    try {
      // create the username
      UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((userCred) async {
        // set the username
        userName ??= getRandomName();
        await userCred.user!.updateDisplayName(userName);
        return userCred;
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  static String getRandomName() {
    final WordGenerator wordGenerator = WordGenerator();
    final PasswordGenerator passwordGenerator = PasswordGenerator();
    final randomName = wordGenerator.randomName().split(" ")[0];
    final randString = passwordGenerator.generatePassword();
    return "$randomName$randString".trim().substring(0,8);
  }
}
