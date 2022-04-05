
import 'package:easmaterialdidatico/app/widgets/reset_password_po_show.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../shared/auth/firebase_auth.dart';

class PasswordResetController extends GetxController{
  RxBool loadingPage=false.obs;


  Future<void> resetPassword({required String email})async{
    loadingPage.value = true;
    await AuthenticationHelper(auth: FirebaseAuth.instance)
        .resetPassword(email: email)
        .then(
          (result) {
            ResetPasswordPopShow().popShowMessage();

      },
    );

    loadingPage.value = false;
  }
}