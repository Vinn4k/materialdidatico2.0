import 'package:easmaterialdidatico/app/data/interface/user_data_info_interface.dart';
import 'package:easmaterialdidatico/app/data/repository/course_repository.dart';
import 'package:easmaterialdidatico/app/data/repository/singup_repository.dart';
import 'package:easmaterialdidatico/app/data/repository/user_data_info_repository.dart';
import 'package:easmaterialdidatico/app/erroHandler/auth_handdler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easmaterialdidatico/shared/themes/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/auth/firebase_auth.dart';
import '../routes/app_routes.dart';



class SingUpController extends GetxController {
  final SingUpRepository repository = SingUpRepository();
  final CourseRepository _courseRepository = CourseRepository();
  final IUserDataInfo _userDataInfo=UserDataInfoRepository();
  final courseId = Get.parameters;

  @override
  void onReady() {
    super.onReady();

    getAndSetCourseInfoById(courseId["courseId"].toString());
  }

  RxBool loadingPage = false.obs;
  RxBool showPassword = false.obs;
  RxString password = "".obs;
  RxString name = "".obs;
  RxString cpf = "".obs;
  RxString email = "".obs;
  RxString errorMessengerForSnack = "".obs;
  RxString courseName = "Carregando...".obs;
  RxString courseIdForSingUp = "".obs;
  RxString moduleIdForSingUp = "".obs;
  RxBool buttonEnabled = false.obs;

  Future<void> getAndSetCourseInfoById(String id) async {
    DocumentSnapshot snapshot = await _courseRepository.getCourseInfoById(id);
    if (snapshot.data() != null) {
      courseName.value = snapshot.get("nome");
      courseIdForSingUp.value = snapshot.get("id");
      moduleIdForSingUp.value = snapshot.get("firstModule");
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

  setErrorMessengerForSnack(String error) {
    errorMessengerForSnack.value = AuthHanddler().errorFilter(error);
  }

  Future<void> singUp({required String email,required String password}) async {
    loadingPage.value=true;
    String cpf0= cpf.value.replaceAll(".", "");
    String cpfFormatted=cpf0.removeAllWhitespace.replaceAll("-", "");
    bool userExist=await _userDataInfo.checkUserExist(cpfFormatted);

    userExist? Get.snackbar("Erro", "CPF já Cadastrado",colorText: Colors.red):await AuthenticationHelper(auth: FirebaseAuth.instance)
        .signUp(
        email: email, password: password)
        .then((result) async {
      if (result is UserCredential) {
        await AuthenticationHelper(auth: FirebaseAuth.instance)
            .signIn(
            email: email,
            password: password)
            .then(
                (value) async {
              User? user = FirebaseAuth.instance.currentUser;
              String uid = user!.uid;
              await repository.singUp(name.value,cpfFormatted, email, uid,
                  courseIdForSingUp.value, moduleIdForSingUp.value);}
        );
        loadingPage.value = false;
        Get.offAndToNamed(Routes.HOME);
      } else {
        loadingPage.value = false;
        setErrorMessengerForSnack(result);
        Get.snackbar(
            "Falha no Cadastro",
            errorMessengerForSnack.value);
      }
    });
    loadingPage.value = false;




  }
}
