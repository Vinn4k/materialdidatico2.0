import 'dart:async';

import 'package:easmaterialdidatico/app/routes/app_routes.dart';
import 'package:easmaterialdidatico/shared/auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ActiveAccountController extends GetxController {
  late final FirebaseAuth _auth;
  late final AuthenticationHelper _authenticationHelper;
  final StreamController<User?> _controller=StreamController();
  late final   StreamSubscription _sub;
  RxString email = "teste@teste.com".obs;
  RxString message = "Por Favor Clique no botão Verificar".obs;
  RxBool loading = false.obs;

  @override
  void onInit() {
    _auth = FirebaseAuth.instance;
    _authenticationHelper = AuthenticationHelper(auth: _auth);
    email.value = "${_auth.currentUser?.email}";
    super.onInit();
    _auth.currentUser!.emailVerified ? Get.offAndToNamed(Routes.HOME) : null;
    _auth.userChanges().listen((event) {
    _controller.add(event);
    });
  }

  Future<void> sendVerificationEmail() async {
    loading.value = true;
    await _authenticationHelper.sendVerificationEmail();
    Get.back();
    loading.value = false;
    message.value="Por Favor verifique sua caixa de email e spam";
 final Stream  userReloadCheck =
    Stream.periodic(const Duration(seconds: 5), (int nd) {
      return nd;
    });
    StreamSubscription _subUserReload= userReloadCheck.listen((event) {
      _auth.currentUser?.reload();
    });

 _auth.userChanges().listen((event) {
   _controller.add(event);
 });
 _sub =_controller.stream.listen((event) {
   if(event!.emailVerified){
     _controller.close();
     _sub.cancel();
     _subUserReload.cancel();
    Get.offAndToNamed(Routes.HOME);

   }
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
    _controller.close();
  }
}
