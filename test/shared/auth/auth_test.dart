import 'package:easmaterialdidatico/shared/auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import '../../mocks/user_mock.dart';





void main() async {
final userMocked=UserMock().user;
  final auth = MockFirebaseAuth(mockUser: userMocked);

  group("Auth test", () {

    test("SingIn test", () async {
      final UserCredential result = await AuthenticationHelper(auth: auth)
          .signIn(email: "teste@gmail.com", password: "12345678");
      final user=result.user;
      expect("Teste Login", user?.displayName);
      expect("teste1@gmail.com", user?.email);
    });

    test("SingUp test", () async {
      final UserCredential  result = await AuthenticationHelper(auth: auth)
          .signUp(email: "teste1@gmail.com", password: "12345678");
      final user=result.user;
      expect("teste1@gmail.com", user?.email);
    });


    test("SingOut test", () async {
     User? user=auth.currentUser;
      final   result = await AuthenticationHelper(auth: auth)
          .signOut();
    user=result;
    expect(null, user);

    });

  });
}
