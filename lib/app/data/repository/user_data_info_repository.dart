
import 'package:cloud_firestore/cloud_firestore.dart';

import '../interface/user_data_info_interface.dart';
import '../provider/user_data_info_provider.dart';

class UserDataInfoRepository implements IUserDataInfo{
  UserDataInfoProvider provider=UserDataInfoProvider();
  @override
  Future<DocumentSnapshot> getUserInfo(String uid) {
   return provider.getUserInfo(uid);
  }
}