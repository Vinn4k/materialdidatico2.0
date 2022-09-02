
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';

import '../data/model/user_info_model.dart';
import '../data/repository/user_data_info_repository.dart';
import '../routes/app_routes.dart';
import '../services/file_service.dart';



class PdfViewerControllerUi extends GetxController{
  final UserDataInfoRepository _repository = UserDataInfoRepository();
 final User? user=FirebaseAuth.instance.currentUser;
  final FileService _service=FileService();
  final data = Get.parameters;
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;


  @override
  void onInit()async {
    await pdfIsSync();
    if (user == null) {
        Get.offAndToNamed(Routes.LOGIN);
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
  RxBool pdfIsSynced=false.obs;
  RxString offPdfBase64="".obs;


  Future<DocumentSnapshot> getUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid=user?.uid??"";
    DocumentSnapshot snapshot =
    await _repository.getUserInfo(uid);
    var data = snapshot.data();
    UserInfoModel userInfoModel = UserInfoModel.fromJson(data);
    userName.value = userInfoModel.nome!;
    userID.value = uid;
    cpfFormatterForPage(userInfoModel.cpf!);

    return snapshot;
  }
  void cpfFormatterForPage(String cpf){
    String cpf0=cpf .substring(0,3);
    String cpf2=cpf .substring(3,6);
    String cpf3=cpf .substring(6,9);
    String cpf4=cpf .substring(9,11);
    userCpf.value="$cpf0.$cpf2.$cpf3-$cpf4";


  }

  double setZoomInPc(){
  if(GetPlatform.isMobile){
    return 0.0;
  }else{
    return 1.25;
  }

  }
  Future<void> automaticDownload()async{
    if(GetPlatform.isAndroid){
      String offlinePath=data["path"]??"not";
      if(offlinePath=="not"){
        String pdf = data["linkPdf"]??"error";
        String id = data["id"] ?? "error";
        downloadPdf(url: pdf, fileName: id);
      }
    }
  }
Future<void> downloadPdf({required String url,required String fileName})async{
  await _service.downloadPdf(url:url,fileName: fileName);
}

Future<bool> pdfIsSync()async{
    String id=data['id']??"ERROR";
    final isOffline= await _service.pdfIsSync(id: id);
    pdfIsSynced.value=isOffline;
    if(isOffline){
      String base64Pdf=await _service.getOffPdf(id: id);
      offPdfBase64.value=base64Pdf;

    }

    return isOffline;
}
  Future<void> startTrace(Trace trace) async {
    await trace.start();
  }
  Future<void> stopTrace(Trace trace) async {
    await trace.stop();
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