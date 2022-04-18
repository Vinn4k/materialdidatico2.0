
import 'package:get/get.dart';

import '../controller/active_account_controller.dart';

class ActiveAccountBiding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActiveAccountController>(() {
      return ActiveAccountController();
    });
  }
}