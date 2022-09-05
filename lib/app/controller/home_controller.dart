import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easmaterialdidatico/app/data/interface/data_itens_interface.dart';
import 'package:easmaterialdidatico/app/data/interface/user_data_info_interface.dart';
import 'package:easmaterialdidatico/app/services/user_account_check_service.dart';
import 'package:easmaterialdidatico/app/widgets/group_seclect_pop_show_widget.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/auth/firebase_auth.dart';
import '../data/model/home_pop_show_widget_model.dart';
import '../data/model/user_data_model.dart';
import '../data/repository/app_monitor_repository.dart';
import '../data/repository/data_itens_repository.dart';
import '../data/repository/user_data_info_repository.dart';
import '../routes/app_routes.dart';
import '../security/encrypt_service.dart';
import '../widgets/home_pop_show_widget.dart';

class HomeController extends GetxController {
  final IDataItens _repository = DataItensRepository();
  final IUserDataInfo _dataUserInfo = UserDataInfoRepository();

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  final FirebaseRemoteConfig firebaseRmConfig = FirebaseRemoteConfig.instance;


  @override
  Future<void> onInit() async {
    await userCheck();
    super.onInit();

  }

  @override
  void onReady() async {
    super.onReady();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await getCourseID();
      await _analytics.setUserId(id: user.uid);
      await _fetchSettingsRemoteForAds();
      UserAccountCheckService(firebaseAuth: FirebaseAuth.instance).chekIsAccountActive();
       userGroupVerify();
    }
  }


  RxList userCourseId = [].obs;
  RxBool showAdds = true.obs;


  Future<String> getCourseID() async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user?.uid ?? "";
    DocumentSnapshot data = await _dataUserInfo.getUserInfo(uid);

    List<dynamic> courseList = await data.get("cursos");
    for (var element in courseList) {
      userCourseId.add(element);

    }
    return "ok";
  }

  Future<QuerySnapshot> getCourses() async {
    return _repository.getCourses();
  }

  Future<void> reAuth() async {
    UserDataModel dataModel =
        await EncyptService().readLocalDatabaseAndDecrypt();
    String email = dataModel.email ?? "";
    String password = dataModel.password ?? "";
    try {
      await AuthenticationHelper(auth: FirebaseAuth.instance).signIn(email: email, password: password);
    } catch (error) {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove("data001");
    }
  }

  Future<void> userCheck() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      final prefs = await SharedPreferences.getInstance();
      String? localData = prefs.getString("data001");
      if (localData != null) {
        await reAuth();
      } else {
        Get.offAndToNamed(Routes.LOGIN);


      }
    }
  }

  Future<void> logout() async {

   await AuthenticationHelper(auth: FirebaseAuth.instance).signOut();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove("data001");
    dispose();
      Get.offAndToNamed(Routes.LOGIN);


  }

  Future<void> _fetchSettingsRemoteForAds() async {
    try {
      await firebaseRmConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 15),
          minimumFetchInterval: const Duration(minutes: 30),
        ),
      );
      await firebaseRmConfig.fetchAndActivate();

      HomePopShowWidgetModel dataAds = HomePopShowWidgetModel.fromJson(
        jsonDecode(
          firebaseRmConfig.getString("Anuncio_Tela_Inicial"),
        ),
      );
      if (dataAds.mostrar == true) {

       showAdds.value? HomePopShowWidget().showDialog(data: dataAds):null;
      }
    } catch (exception) {
      throw ("Falha ao buscar configuração remota");
    }
  }
Future<void> userGroupVerify()async{
  User? user = FirebaseAuth.instance.currentUser;
  String uid = user?.uid ?? "";
  DocumentSnapshot data = await _dataUserInfo.getUserInfo(uid);
  try{
    ///tem que da erro aqui
    String? groupeId=data.get("turma");
  }catch(e){

      GroupSelectPopShowWidget().showDialog();


  }



}
  


}
