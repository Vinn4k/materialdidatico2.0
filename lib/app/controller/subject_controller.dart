
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easmaterialdidatico/app/services/file_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../data/repository/data_itens_repository.dart';
import '../routes/app_routes.dart';


class SubjectController extends GetxController{
  DataItensRepository repository = DataItensRepository();
  User? user = FirebaseAuth.instance.currentUser;
  final FileService _service=FileService();


  @override
  Future<void> onInit() async {
    super.onInit();
    if (user == null) {
        Get.offAndToNamed(Routes.LOGIN);
    }
  }
  RxString offFilePath="".obs;




  Future<QuerySnapshot> getSubjects(String courseId,String moduleId){

    return repository.getSubjects(courseId, moduleId);
  }

  Future<bool> pdfIsSync({required String id})async{
    final offline= await _service.pdfIsSync(id: id);
    if(offline){
      String base64Pdf=await _service.getOffPdf(id: id);
      offFilePath.value=base64Pdf;

    }

    return offline;
  }

}