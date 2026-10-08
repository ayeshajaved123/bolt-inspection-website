import 'package:firebase_auth/firebase_auth.dart';

/// Wraps FirebaseAuth for the admin panel.
/// Admin users must be created manually in the Firebase Console
/// (Authentication -> Users -> Add user). There is no public sign-up flow
/// on purpose — this is an internal admin panel, not a customer account system.
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future<String?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null; // null = success
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'Sign-in failed. Please check your credentials.';
    }
  }

  Future<void> signOut() => _auth.signOut();
}
