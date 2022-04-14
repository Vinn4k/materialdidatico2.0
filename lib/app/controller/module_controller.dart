import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../data/interface/user_data_info_interface.dart';
import '../data/repository/data_itens_repository.dart';
import '../data/repository/user_data_info_repository.dart';
import '../routes/app_routes.dart';

class ModuleController extends GetxController {
  DataItensRepository repository = DataItensRepository();
  final UserDataInfoRepository _userApp = UserDataInfoRepository();
  final IUserDataInfo _dataUserInfo = UserDataInfoRepository();

  User? user = FirebaseAuth.instance.currentUser;
  RxList userModule = [].obs;
  @override
  Future<void> onInit() async {

    if (user == null) {
      Get.offAndToNamed(Routes.LOGIN);
    }
    await getModuleID();
    _userApp.getUserInfo(user?.uid ?? "");
    super.onInit();
  }

  Future<QuerySnapshot> getModules(String id) async {
    return repository.getModules(id);
  }
  Future<String> getModuleID() async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user?.uid ?? "";
    DocumentSnapshot data = await _dataUserInfo.getUserInfo(uid);

    List<dynamic> courseList = await data.get("modulos");
    for (var element in courseList) {
      userModule.add(element);
    }
    return "ok";
  }
}
