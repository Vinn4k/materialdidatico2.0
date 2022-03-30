
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';

import '../data/model/user_info_model.dart';
import '../data/repository/user_data_info_repository.dart';
import '../routes/app_routes.dart';



class PdfViewerControllerUi extends GetxController{
  final UserDataInfoRepository _repository = UserDataInfoRepository();
 final User? user=FirebaseAuth.instance.currentUser;
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;



  @override
  void onInit()async {

    if (user == null) {

        Get.offAndToNamed(Routes.INITIAL);

    }
   await getUserInfo();
    await setDevice();

await analytics.setUserId(id: user!.uid);
    super.onInit();
  }


  RxString userCpf="".obs;
  RxString userName = "".obs;
  RxString userID = "".obs;
  RxString userDiviceType="".obs;
  RxString password="O2!iGi%IL6H6Ob0yByjK".obs;

  Future<DocumentSnapshot> getUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid=user?.uid??"";
    DocumentSnapshot snapshot =
    await _repository.getUserInfo(uid);
    var data = snapshot.data();
    UserInfoModel userInfoModel = UserInfoModel.fromJson(data);
    userName.value = userInfoModel.nome!;
    userID.value = uid;
    userCpf.value = userInfoModel.cpf!;
    return snapshot;
  }

  double setZoomInPc(){
  if(GetPlatform.isMobile){
    return 0.0;
  }else{
    return 1.25;
  }

  }



  Future<void> disableScreenCapture() async {
    //disable screenshots and record screen in current screen
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }
 setDevice(){

   if  (GetPlatform.isLinux) {
     userDiviceType.value = "Linux";
   } else {
     if (GetPlatform.isAndroid) {
       userDiviceType.value = "Android";
     } else if (GetPlatform.isIOS) {
       userDiviceType.value = "IOS";
     } else if (GetPlatform.isFuchsia) {
       userDiviceType.value = "Fuchsia";
     } else if(GetPlatform.isMobile) {
       userDiviceType.value = "Mobile";
     } else if (GetPlatform.isMacOS) {
       userDiviceType.value = "MacOS";
     } else if (GetPlatform.isWindows) {
       userDiviceType.value = "Windows";
     }else if (GetPlatform.isWeb) {
       userDiviceType.value = "Web";
     }
   }

 }


}