
import 'package:easmaterialdidatico/app/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/route_manager.dart';

class UserAccountCheckService{
  UserAccountCheckService({required this.firebaseAuth});
  final FirebaseAuth firebaseAuth;

  Future chekIsAccountActive()async{
    User? user=firebaseAuth.currentUser;
    if(user !=null){
      user.emailVerified?null:Get.offAndToNamed(Routes.ActiveAccount);
    }

  }
}