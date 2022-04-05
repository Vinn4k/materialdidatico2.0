
import 'package:cloud_firestore/cloud_firestore.dart';

class AppMonitorProvider{
  AppMonitorProvider({required this.firestore});
   FirebaseFirestore firestore;

  Future<DocumentSnapshot> getAppInfo() async {
    DocumentSnapshot snapshot = await firestore
        .collection("app")
        .doc("info").get();
    return snapshot;
  }
}