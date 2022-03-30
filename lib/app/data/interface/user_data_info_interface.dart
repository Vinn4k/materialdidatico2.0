

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IUserDataInfo{
  Future<DocumentSnapshot> getUserInfo(String uid);
}