

import 'package:cloud_firestore/cloud_firestore.dart';

class CourseProvider{

  Future<DocumentSnapshot> getCourseInfoById(String id) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("cursos")
        .doc(id).get();
    return snapshot;
  }


}