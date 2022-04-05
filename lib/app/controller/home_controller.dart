import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ota_update/ota_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';

import '../../shared/auth/firebase_auth.dart';
import '../../shared/themes/app_colors.dart';
import '../data/model/home_pop_show_widget_model.dart';
import '../data/model/user_data_model.dart';
import '../data/repository/app_monitor_repository.dart';
import '../data/repository/data_itens_repository.dart';
import '../data/repository/user_data_info_repository.dart';
import '../routes/app_routes.dart';
import '../security/encrypt_service.dart';
import '../widgets/home_pop_show.dart';

class HomeController extends GetxController {
  final DataItensRepository _repository = DataItensRepository();
  final UserDataInfoRepository _dataUserInfo = UserDataInfoRepository();
  late PackageInfo packageInfo;

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  final FirebaseRemoteConfig firebaseRmConfig = FirebaseRemoteConfig.instance;
  final AppMonitorRepository _monitorRepository = AppMonitorRepository();

  String appVersionLocal = "";

  @override
  Future<void> onInit() async {
    packageInfo = await PackageInfo.fromPlatform();
    appVersionLocal = packageInfo.version;
    await userCheck();
    super.onInit();
    versionCheck();
   
  }

  @override
  void onReady() async {
    super.onReady();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await getCourseID();
      await _analytics.setUserId(id: user.uid);
      await _fetchSettingsRemoteForAds();
    }
  }

  RxList userCourseId = [].obs;
  RxBool showAdds = true.obs;
  RxString appVerionSever = "1.1.3".obs;
  RxBool updateApp = false.obs;
  RxDouble downloadProgress = 0.0.obs;
  RxString linkApk="".obs;
  RxString ssh="".obs;

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
        Get.offAndToNamed(Routes.INITIAL);
      }
    }
  }

  Future<void> logout() async {
    AuthenticationHelper(auth: FirebaseAuth.instance).signOut().then((value) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove("data001");
      Get.offAndToNamed(Routes.INITIAL);
      dispose();
    });
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

  ///mostra popup para atualizar a versão do app
  Future<void> versionCheck() async {
    _monitorRepository.getApInfo().then(
      (value) {
        appVerionSever.value = value.get("versao");

        if (appVersionLocal != appVerionSever.value) {
          set32or64BitApk(value);
          if (!GetPlatform.isWeb) {
            showAdds.value=false;
            
            Get.defaultDialog(
                title: "Atualização Encontrada",
                buttonColor: AppColors.blue,
                cancelTextColor: Colors.black,
                confirmTextColor: Colors.white,
                content: SizedBox(child: StreamBuilder(
                    stream: downloadProgress.stream,
                    builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                      double value=snapshot.data??00;
                      return Column(
                        children: [
                          LinearProgressIndicator(
                            value:value/100,
                            backgroundColor: AppColors.orange,
                            color: AppColors.blue,
                          ),
                          Text("$value %")
                        ],
                      );
                    })),
                onCancel: () {
                  showAdds.value=true;
                },
                onConfirm: () async {
                  await otaUpdate().then((value) =>    showAdds.value=true);


                },
                textConfirm: "Atualizar",
                textCancel: "Cancelar");
          }
        }
      },
    );
  }
Future<void> set32or64BitApk(DocumentSnapshot data)async{
   final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
   Map deviceData = <String, dynamic>{};
  deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);

List arm32=deviceData["supported32BitAbis"];
List arm64=deviceData["supported64BitAbis"];

  if(arm32.isNotEmpty){
    linkApk.value=data.get("urlApk32");
    ssh.value=data.get("sshApk32");
  }if(arm64.isNotEmpty){
     linkApk.value=data.get("urlApk64");
     ssh.value=data.get("sshApk64");
   }

}
  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };
  }
  Future<void> otaUpdate() async {

    try {
      OtaUpdate()
          .execute(
        linkApk.value,
        destinationFilename: 'easmaterial.apk',
      )
          .listen(
        (OtaEvent event) {
          downloadProgress.value = double.parse(event.value ?? "");
        },
      );
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      throw ("Falha ao atualizar");
    }
  }
}
