import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:easmaterialdidatico/main.dart' as app;




void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized(); // NEW

    group("Login teste", (){

      testWidgets("login test example", (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();
        expect(find.byType(TextFormField).first, findsWidgets);
        expect(find.byType(TextFormField).last, findsWidgets);
        await tester.enterText(find.byType(TextFormField).first, "ti@cefops.com.br");
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextFormField).last, "12345678");
        await tester.tap(find.byType(ElevatedButton),warnIfMissed: false);

        await tester.pumpAndSettle();

      });
    });
}