import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easmaterialdidatico/app/data/provider/studant_group_provider.dart';

class StudentGroupRepository{
  final StudentGroupProvider _provider=StudentGroupProvider();

  Future<QuerySnapshot> getCourseInfoById(String id) async {
    return _provider.getCourseInfoById(id);
  }
}