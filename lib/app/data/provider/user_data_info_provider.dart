
import 'package:cloud_firestore/cloud_firestore.dart';


import '../interface/user_data_info_interface.dart';

class UserDataInfoProvider implements IUserDataInfo{
  @override
  Future<DocumentSnapshot> getUserInfo(String uid) async{
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    return snapshot;
  }


}