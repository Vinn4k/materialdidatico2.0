import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationHelper {
  FirebaseAuth auth;

  AuthenticationHelper({required this.auth});

  get user => auth.currentUser;

  //SIGN UP METHOD
  Future signUp({required String email, required String password}) async {
    try {
      final data=  await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return data;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }


  Future signIn({
    required String email,
    required String password,
  }) async {
    try {
      final data = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return data;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future resetPassword({required String email}) async {
    try {
     await auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
  await auth.signOut();
  }
}
