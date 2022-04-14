import 'package:easmaterialdidatico/app/controller/login_controller.dart';
import 'package:easmaterialdidatico/app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/user_mock.dart';

void main() async {
  UserMock _user = UserMock();
  LoginController _loginController = LoginController();
  TestWidgetsFlutterBinding.ensureInitialized();
  const testKey = Key('Teste');
  Widget loginPageForTest() {
    return MaterialApp(
        home: LoginPage(
      key: testKey,
    ));
  }

  group("Login teste Sucesso", () {
    testWidgets("Insarir email", (WidgetTester tester) async {
      await tester.pumpWidget(loginPageForTest());
      await tester.enterText(
          find.byType(TextField).first, '${_user.user.email}');
      expect(find.text('${_user.user.email}'), findsOneWidget);
    });
    testWidgets("Insarir senha", (WidgetTester tester) async {
      await tester.pumpWidget(loginPageForTest());
      await tester.enterText(find.byType(TextField).last, '123456');
      expect(find.text('123456'), findsOneWidget);
    });
    testWidgets("Ação Clicar em Entrar", (WidgetTester tester) async {
      await tester.pumpWidget(loginPageForTest());
      expect(find.text('Entrar'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);


    });
  });
}
