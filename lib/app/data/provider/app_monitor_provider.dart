
import 'package:cloud_firestore/cloud_firestore.dart';

class AppMonitorProvider{

  Future<DocumentSnapshot> getAppInfo() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("app")
        .doc("info").get();
    return snapshot;
  }
}