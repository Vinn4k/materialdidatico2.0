import 'dart:math';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../shared/auth/firebase_auth.dart';
import '../erroHandler/auth_handdler.dart';
import '../routes/app_routes.dart';
import '../security/encrypt_service.dart';

class LoginController extends GetxController {

  RxBool loadingPage = false.obs;
  RxBool stayConnected = false.obs;
  RxBool showPassord = false.obs;
  RxString errorMessagerForSnack = "".obs;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  ///seta a menssagem que sera mostrada no snackbar
  setErrorMessagerForSnack(String error) {
    errorMessagerForSnack.value = AuthHanddler().errorFilter(error);
  }

  ///envia o evento de login para o analytics
  Future<void> sendLoginEvent() async {
    final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

    await _analytics.logLogin(
      loginMethod: "EmailAndPassword",
    );
  }

  Future<void> login(String email, String passowrd) async {
    await AuthenticationHelper(auth: FirebaseAuth.instance)
        .signIn(email: email, password: passowrd)
        .then((result) async {
      UserCredential _credential;
      try {
        _credential = result;
        sendLoginEvent();
        EncyptService().encryptAndSave(user: email, password: passowrd);
        loadingPage.value = false;
        Get.offAndToNamed(Routes.HOME);
      } catch (e) {
        loadingPage.value = false;
        setErrorMessagerForSnack(result);
        Get.snackbar("Falha na Autenticação", errorMessagerForSnack.value);
      }
    });
  }
}
