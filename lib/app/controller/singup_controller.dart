import 'package:easmaterialdidatico/app/data/repository/course_repository.dart';
import 'package:easmaterialdidatico/app/data/repository/singup_repository.dart';
import 'package:easmaterialdidatico/app/erroHandler/auth_handdler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easmaterialdidatico/shared/themes/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/auth/firebase_auth.dart';
import '../routes/app_routes.dart';

class SingupController extends GetxController {
  final SingUpRepository repository = SingUpRepository();
  final CourseRepository _courseRepository = CourseRepository();
  final courseId = Get.parameters;

  @override
  void onReady() {
    super.onReady();

    getAndSetCourseInfoById(courseId["courseId"].toString());
  }

  RxBool loadingPage = false.obs;
  RxBool showPassord = false.obs;
  RxString password = "".obs;
  RxString name = "".obs;
  RxString cpf = "".obs;
  RxString email = "".obs;
  RxString errorMessagerForSnack = "".obs;
  RxString courseName = "Carregando...".obs;
  RxString courseIdforSingup = "".obs;
  RxString moduleIdforSingup = "".obs;
  RxBool buttonEnabled = false.obs;

  Future<void> getAndSetCourseInfoById(String id) async {
    DocumentSnapshot snapshot = await _courseRepository.getCourseInfoById(id);
    if (snapshot.data() != null) {
      courseName.value = snapshot.get("nome");
      courseIdforSingup.value = snapshot.get("id");
      moduleIdforSingup.value = snapshot.get("firstModule");
      buttonEnabled.value=snapshot.get("receberCadastro");
      if(snapshot.get("receberCadastro")==false){
       Get.showSnackbar(const GetSnackBar(
         title: "Curso Desabilitado Para Cadastro",
         message: "Por favor entre em contato com 2745-2390",
         snackPosition: SnackPosition.TOP,
         icon: Icon(Icons.error_outline,color: AppColors.orange,),
       ));
      }

    } else {
      courseName.value = "Curso não Encontrado";
      buttonEnabled.value = false;
    }
  }

  setErrorMenssagerForSnack(String error) {
    errorMessagerForSnack.value = AuthHanddler().errorFilter(error);
  }

  Future<void> singUp({required String email,required String passowrd}) async {
    String cpf0= cpf.value.replaceAll(".", "");
    String cpf1=cpf0.removeAllWhitespace.replaceAll("-", "");
      loadingPage.value=true;
    await AuthenticationHelper(auth: FirebaseAuth.instance)
        .signUp(
        email: email, password: passowrd)
        .then((result) async {
      if (result is UserCredential) {
        await AuthenticationHelper(auth: FirebaseAuth.instance)
            .signIn(
            email: email,
            password: passowrd)
            .then(
              (value) async {
                User? user = FirebaseAuth.instance.currentUser;
                String uid = user!.uid;
                await repository.singUp(name.value,cpf1, email, uid,
                  courseIdforSingup.value, moduleIdforSingup.value);}
        );
        loadingPage.value = false;
        Get.offAndToNamed(Routes.HOME);
      } else {
        loadingPage.value = false;
        setErrorMenssagerForSnack(result);
        Get.snackbar(
            "Falha no Cadastro",
            errorMessagerForSnack.value);
      }
    });




  }
}
