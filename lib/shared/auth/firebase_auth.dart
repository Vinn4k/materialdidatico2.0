import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get user => _auth.currentUser;

  //SIGN UP METHOD
  Future signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.replaceAll(' ', ''),
        password: password.replaceAll(' ', ''),

      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN IN METHOD
  Future signIn({required String email, required String password,}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email.replaceAll(' ', ''),
        password: password.replaceAll(' ', ''),);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }Future resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.replaceAll(' ', ''));
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();
  }
}