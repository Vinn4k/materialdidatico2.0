import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';

import '../bindings/home_binding.dart';
import '../bindings/login_binding.dart';
import '../bindings/module_binding.dart';
import '../bindings/passowrd_reset_binding.dart';
import '../bindings/pdf_viewer_binding.dart';
import '../bindings/subject_binding.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../pages/module_page.dart';
import '../pages/password_reset_page.dart';
import '../pages/pdf_view_page.dart';
import '../pages/sjubject_page.dart';
import 'app_routes.dart';

User? user = FirebaseAuth.instance.currentUser;

class AppPages {
  static final routes = [
    GetPage(
        name: Routes.INITIAL,
        page: () => _homeInitialChange(),
        transition: Transition.noTransition,
        binding: _homeInitialChangeBinding()),
    GetPage(
        name: Routes.LOGIN, page: () => LoginPage(), binding: LoginBinding()),

    GetPage(
        name: Routes.PASSWORDRESET,
        page: () => PasswordReset(),
        transition: Transition.noTransition,
        binding: PasswordResetBinding()),
    GetPage(
        name: Routes.HOME,
        page: () => const HomePage(),
        transition: Transition.noTransition,
        binding: HomeBinding()),
    GetPage(
        name: Routes.MODULE,
        page: () => ModulePage(),
        transition: Transition.noTransition,
        binding: ModuleBinding()),
    GetPage(
        name: Routes.SUBJECT,
        page: () => SubjectPage(),
        transition: Transition.noTransition,
        binding: SubjectBinding()),
    GetPage(
        name: Routes.PDFVIEW,
        page: () => PdfViewPage(),
        transition: Transition.noTransition,
        binding: PdfViewerBinding()),
  ];
}

_homeInitialChange() {
  if (user != null) {
    return const HomePage();
  } else {
    return LoginPage();
  }
}

_homeInitialChangeBinding() {
  if (user != null) {
    return HomeBinding();
  } else {
    return LoginBinding();
  }
}
