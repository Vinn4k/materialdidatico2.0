import 'package:cloud_firestore/cloud_firestore.dart';

class StudentGroupProvider {
  Future<QuerySnapshot> getCourseInfoById(String id) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("turmas")
        .where("courseId", isEqualTo: id)
        .where("mostrar", isEqualTo: true)
        .orderBy("nome", descending: false)
        .get();
    return snapshot;
  }

  Future<void> setUserGroup(
      {required String id, required String groupId}) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .update({"turma": groupId});
  }
}
