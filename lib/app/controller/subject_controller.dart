
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../data/repository/data_itens_repository.dart';
import '../routes/app_routes.dart';


class SubjectController extends GetxController{
  DataItensRepository repository = DataItensRepository();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Future<void> onInit() async {
    super.onInit();
    if (user == null) {

        Get.offAndToNamed(Routes.INITIAL);


    }
  }

  Future<QuerySnapshot> getSubjects(String courseId,String moduleId){

    return repository.getSubjects(courseId, moduleId);
  }


}