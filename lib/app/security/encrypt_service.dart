import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as crypto;
import '../data/model/local_data_model.dart';
import '../data/model/user_data_model.dart';

///serviço de encriptação
class EncyptService {
  void encryptAndSave({required String user, required String password}) async {
    final prefs = await SharedPreferences.getInstance();
    final key = crypto.Key.fromUtf8("3gA2dkfTtkkNBdXgWcVQnhRkkWC5dxWc");
    final keyForHead = crypto.Key.fromUtf8("A6kuhTVzTLTkyjH2ywMjzbA5eMMPxgWK");
    final iv = crypto.IV.fromLength(16);
    final encrypterData = crypto.Encrypter(crypto.AES(key));

    final encrypterHead = crypto.Encrypter(crypto.AES(keyForHead));

    final userEncrypted = encrypterData.encrypt(user, iv: iv);
    final passwordEncrypted = encrypterData.encrypt(password, iv: iv);
    final dateEncrypted =
        encrypterData.encrypt(DateTime.now().toIso8601String(), iv: iv);

    Map<String, dynamic> dataModel = {
      'datat': dateEncrypted.base64,
      'datau': userEncrypted.base64,
      'datap': passwordEncrypted.base64
    };

    String data = json.encode(dataModel);
    final dataEncrypted = encrypterHead.encrypt(data, iv: iv);
    prefs.setString("data001", dataEncrypted.base64);
  }

  Future<UserDataModel> readLocalDatabaseAndDecrypt() async {
    final key = crypto.Key.fromUtf8("3gA2dkfTtkkNBdXgWcVQnhRkkWC5dxWc");
    final keyForHead = crypto.Key.fromUtf8("A6kuhTVzTLTkyjH2ywMjzbA5eMMPxgWK");
    final iv = crypto.IV.fromLength(16);
    final decryptLocalData = crypto.Encrypter(crypto.AES(key));
    final decryptHead = crypto.Encrypter(crypto.AES(keyForHead));

    final prefs = await SharedPreferences.getInstance();
    String? localData = prefs.getString("data001");

    Map<String, dynamic> jsonData =await
        json.decode(decryptHead.decrypt64(localData!, iv: iv));

    LocalDataModel data = LocalDataModel.fromJson(jsonData);
    String? user = data.datau;
    String? password = data.datap;
    String? time = data.datat;

    final userDecrypted = decryptLocalData.decrypt64(user, iv: iv);
    final passwordDecrypted = decryptLocalData.decrypt64(password, iv: iv);

    DateTime timeDecrypted =
        DateTime.parse(decryptLocalData.decrypt64(time, iv: iv));
    DateTime validateHorous = timeDecrypted.add(const Duration(hours: 4));
    if (DateTime.now().isAfter(validateHorous)) {
      prefs.remove("data001");
    }
    UserDataModel dataModel=UserDataModel();
    dataModel.password=passwordDecrypted;
    dataModel.email=userDecrypted;

    return dataModel;
  }
}
