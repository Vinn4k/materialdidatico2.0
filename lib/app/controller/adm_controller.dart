import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';

class AdmController extends GetxController{
 final User? user = FirebaseAuth.instance.currentUser;

  @override
  Future<void> onInit() async {
    if (user == null) {
      Get.offAndToNamed(Routes.LOGIN);
    }super.onInit();
  }



}