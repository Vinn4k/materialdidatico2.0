import 'package:easmaterialdidatico/app/controller/adm_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';


class AdmBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdmController>(() {
      return AdmController();
    });
  }
}