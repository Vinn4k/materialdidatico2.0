import 'package:easmaterialdidatico/app/data/repository/course_repository.dart';
import 'package:easmaterialdidatico/app/data/repository/singup_repository.dart';
import 'package:easmaterialdidatico/app/erroHandler/auth_handdler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

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
  RxBool buttonEnabled = true.obs;

  Future<void> getAndSetCourseInfoById(String id) async {
    DocumentSnapshot snapshot = await _courseRepository.getCourseInfoById(id);
    if (snapshot.data() != null) {
      courseName.value = snapshot.get("nome");
      courseIdforSingup.value = snapshot.get("id");
      moduleIdforSingup.value = snapshot.get("firstModule");

    } else {
      courseName.value = "Curso não Encontrado";
      buttonEnabled.value = false;
    }
  }

  setErrorMessagerForSnack(String error) {
    errorMessagerForSnack.value = AuthHanddler().errorFilter(error);
  }

  Future<void> singup() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user?.emailVerified == false) {
      user?.sendEmailVerification();
    }
    String uid = user!.uid;
    String cpf0= cpf.value.replaceAll(".", "");
    String cpf1=cpf0.removeAllWhitespace.replaceAll("-", "");

    await repository.singUp(name.value,cpf1, email.value, uid,
        courseIdforSingup.value, moduleIdforSingup.value);
  }
}
