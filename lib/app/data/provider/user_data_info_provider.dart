import 'package:cloud_firestore/cloud_firestore.dart';

import '../interface/user_data_info_interface.dart';

class UserDataInfoProvider implements IUserDataInfo {
  @override
  Future<DocumentSnapshot> getUserInfo(String uid) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    return snapshot;
  }

  @override
  Future<bool> checkUserExist(String cpf) async {
   try{
     QuerySnapshot data = await FirebaseFirestore.instance
         .collection("users")
         .where("cpf", isEqualTo: cpf)
         .get();
     if(data.docs.isNotEmpty){
       return true;
     }
     else{
       return false;
     }
   }catch(e){
     rethrow;
   }

  }
}
