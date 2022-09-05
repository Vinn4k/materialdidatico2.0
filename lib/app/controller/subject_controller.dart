import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easmaterialdidatico/app/services/file_service.dart';
import 'package:easmaterialdidatico/app/widgets/all_progress_indicator_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:get/get.dart';

import '../data/repository/data_itens_repository.dart';
import '../routes/app_routes.dart';

class SubjectController extends GetxController {
  DataItensRepository repository = DataItensRepository();
  User? user = FirebaseAuth.instance.currentUser;
  final FileService _service = FileService();

  @override
  Future<void> onInit() async {
    super.onInit();
    if (user == null) {
      Get.offAndToNamed(Routes.LOGIN);
    }
  }

  RxBool loading = false.obs;

  Future<QuerySnapshot> getSubjects(String courseId, String moduleId) {
    return repository.getSubjects(courseId, moduleId);
  }

  Future<String> pdfIsSync(
      {required String id, required Map<String, String> data}) async {
    loading.value = true;

    final String offline = await _service.pdfIsSync(id: id);

    if (offline != "nd") {
      data["path"] = offline;
      loading.value = false;
      Get.back();

      Get.toNamed(Routes.PDFVIEW, parameters: data);

    } else {
      var result = await Connectivity().checkConnectivity();

      if (result != ConnectivityResult.none) {
        data["path"] = "not";
        loading.value = false;
        Get.back();
        Get.toNamed(Routes.PDFVIEW, parameters: data);
      }else{
        Get.back();
        Get.snackbar("Sem conexão", "Não há arquivos sincronizados ");

      }
    }


    return offline;
  }
}
