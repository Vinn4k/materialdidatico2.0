import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easmaterialdidatico/app/data/interface/user_data_info_interface.dart';
import 'package:easmaterialdidatico/app/data/repository/student_group_repository.dart';
import 'package:easmaterialdidatico/app/data/repository/user_data_info_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class GroupSelectController extends GetxController {

  final StudentGroupRepository _repository = StudentGroupRepository();
   final IUserDataInfo _dataUserInfo = UserDataInfoRepository();


  RxInt selectedIndex = 1.obs;
  RxString selectedGroupId = "nd".obs;
  RxString userCourseId="".obs;

  Future<QuerySnapshot> getGroup() async {
    await  getAndSelectUserInfo();
    return _repository.getCourseInfoById(userCourseId.value);
  }

  Future<void> getSelectedGroup(QueryDocumentSnapshot data) async {
    selectedGroupId.value = data.get("id");
    
  }  Future<void> getAndSelectUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user?.uid ?? "";
    DocumentSnapshot data = await _dataUserInfo.getUserInfo(uid);

    List<dynamic> courses = data.get("cursos");
    userCourseId.value=courses[0]["cursoId"];
  }
  Future<void> setStudentGroup() async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user?.uid ?? "";
    if (selectedGroupId.value != "nd") {
         await _repository.setUserGroup(id: uid, groupId: selectedGroupId.value);
         Get.back();
    } else {
      Get.showSnackbar(const GetSnackBar(
        title: "Aviso",
        message: "Selecione Uma Turma",duration: Duration(seconds: 7),
      ));
    }
  }
}
