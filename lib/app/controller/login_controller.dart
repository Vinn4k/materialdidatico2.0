
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

  Future<void> login(String emailParam, String passwordParam) async {
      String email=emailParam.removeAllWhitespace;
      String password=passwordParam.removeAllWhitespace;
    await AuthenticationHelper(auth: FirebaseAuth.instance)
        .signIn(email: email, password: password)
        .then((result) async {

        if(result is UserCredential){
          sendLoginEvent();
          EncyptService().encryptAndSave(user: email, password: password);
          loadingPage.value = false;
          Get.offAndToNamed(Routes.HOME);
        }else{
          loadingPage.value = false;
          setErrorMessagerForSnack(result);
          Get.snackbar("Falha na Autenticação", errorMessagerForSnack.value);
        }


    });
  }
}
