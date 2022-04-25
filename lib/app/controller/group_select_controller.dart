
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easmaterialdidatico/app/data/repository/student_group_repository.dart';
import 'package:get/get.dart';

class GroupSelectController extends GetxController{
  final StudentGroupRepository _repository=StudentGroupRepository();

RxInt selectedIndex=0.obs;

  Future<QuerySnapshot> getGroup()async{
 return   _repository.getCourseInfoById("IgNti2X8bdYrs2bO5Pii");

}

}