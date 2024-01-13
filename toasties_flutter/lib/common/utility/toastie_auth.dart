
import "package:firebase_auth/firebase_auth.dart";
import "package:word_generator/word_generator.dart";

// TODO:_ FIX THIS CLASS TO BOT BE STATIC, AND TO USE PROVIDERS INSTEAD, REFER TO https://stackoverflow.com/questions/64520543/struggling-with-authstatechanges-in-flutter

class ToastiesAuthService {

  // instance of the firebase auth service
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// observes the auth state changes in the firebase auth service
  Stream<User?> get onAuthStateChanged => _auth.authStateChanges();

  /// observes the user changes in the firebase auth service
  Stream<User?> get onUserChanged => _auth.userChanges();

  /// returns the userID of the current user instance
  Future<String> getCurrentUID() async {
    return _auth.currentUser!.uid;
  }

  /// signs out of the current user instance's session
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Sign-in with email and password - returns a UserCredential object
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  /// Sign in with Google - returns a UserCredential object
  Future<UserCredential> signInWithGoogle() async {
    try {
      // Create a new provider
      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      UserCredential userCredential =
          await _auth.signInWithProvider(googleProvider);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  /// Sign up with LegalEase Account (uses Email & Password) - returns a UserCredential object
  Future<UserCredential> signUpWithLegalEaseAccount(
      String email, String password, String? userName) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
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
    return "$randomName$randString".trim().substring(0, 8);
  }
}
