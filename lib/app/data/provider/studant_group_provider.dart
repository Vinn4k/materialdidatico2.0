
import 'package:cloud_firestore/cloud_firestore.dart';
class StudentGroupProvider{

  Future<QuerySnapshot> getCourseInfoById(String id) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("turmas").where("courseId",isEqualTo: id).get();
    return snapshot;
  }
}