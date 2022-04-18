import 'dart:async';

import 'package:easmaterialdidatico/app/routes/app_routes.dart';
import 'package:easmaterialdidatico/shared/auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ActiveAccountController extends GetxController {
  late final FirebaseAuth _auth;
  late final AuthenticationHelper _authenticationHelper;
  late StreamSubscription _sub;
  late Stream userReloadCheck;
  StreamController streamController=StreamController();
  RxString email = "teste@teste.com".obs;
  RxBool loading = false.obs;

  @override
  void onInit() {
    _auth = FirebaseAuth.instance;
    _authenticationHelper = AuthenticationHelper(auth: _auth);
    email.value = "${_auth.currentUser?.email}";
    super.onInit();
    _auth.currentUser!.emailVerified ? Get.offAndToNamed(Routes.HOME) : null;
    _sub=streamController.stream.listen((event) {
    });
  }

  Future<void> sendVerificationEmail() async {
    loading.value = true;
    await _authenticationHelper.sendVerificationEmail();
    Get.back();
    loading.value = false;
   userReloadCheck =
    Stream.periodic(const Duration(seconds: 15), (int nd) {
      _auth.currentUser?.reload();
      return nd;
    });
    userReloadCheck.listen((event) {
      streamController.add(event);
    });
    streamController.stream.listen((event) {

    });


  }

  Future<void> sendChangeEmail({required String email}) async {
    await _authenticationHelper.updateEmail(email: email);
    await _authenticationHelper.sendVerificationEmail();
    Get.back();
  }

  @override
  void onClose() async {
    super.onClose();
    streamController.close();
  }
}
