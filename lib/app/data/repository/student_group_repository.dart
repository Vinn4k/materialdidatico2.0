import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easmaterialdidatico/app/data/provider/studant_group_provider.dart';

class StudentGroupRepository {
  final StudentGroupProvider _provider = StudentGroupProvider();

  Future<QuerySnapshot> getCourseInfoById(String id) async {
    return _provider.getCourseInfoById(id);
  }
  Future<DocumentSnapshot> getGroupById(String id) async {
    return _provider.getGroupInfoById(id);
  }

  Future<void> setUserGroup(
      {required String id, required String groupId}) async {
    _provider.setUserGroup(id: id, groupId: groupId);
  }
}
