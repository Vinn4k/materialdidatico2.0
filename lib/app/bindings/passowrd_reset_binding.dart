

import 'package:get/get.dart';

import '../controller/password_reset_controller.dart';

class PasswordResetBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PasswordResetController>((){

      return PasswordResetController();
    });
  }

}