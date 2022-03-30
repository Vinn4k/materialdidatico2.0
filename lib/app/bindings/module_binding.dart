import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../controller/module_controller.dart';

class ModuleBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ModuleController>(() {
      return ModuleController();
    });
  }
}