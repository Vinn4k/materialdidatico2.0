import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:easmaterialdidatico/main.dart' as app;




void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized(); // NEW
    app.main();
  testWidgets("failing test example", (WidgetTester tester) async {
    expect(2 + 2, equals(5));
  });
}