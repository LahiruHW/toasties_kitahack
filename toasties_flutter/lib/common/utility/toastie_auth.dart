import "package:firebase_auth/firebase_auth.dart";

class ToastiesAuthService {
  // instance of the firebase auth service
  static final FirebaseAuth auth = FirebaseAuth.instance;

  /// Sign-in with email and password - returns a UserCredential object
  static Future<UserCredential> signInWithEmailAndPassword (
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
      UserCredential userCredential = await auth.signInWithProvider(googleProvider);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }
}
