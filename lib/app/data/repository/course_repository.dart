
import 'package:easmaterialdidatico/app/data/provider/course_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseRepository{
  final CourseProvider _provider=CourseProvider();
  Future<DocumentSnapshot> getCourseInfoById(String id) async {

    return _provider.getCourseInfoById(id);
  }
}