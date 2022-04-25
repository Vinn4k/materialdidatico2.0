import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FileService {
  Future<Directory?> downloadPdf(
      {required String url, required String fileName}) async {
    final targetDir = await getExternalStorageDirectory();
    final targetDirFolder = Directory('${targetDir?.path}/off');
    final path = targetDirFolder.path;
    final File file = File('$path/$fileName.pdf');
    targetDirFolder.existsSync() ? null : targetDirFolder.create();
    final status = await Permission.storage.request();

    final Dio dio = Dio();
    try {
      if (status.isGranted) {
        await dio.download(url, file.path, deleteOnError: true,
            onReceiveProgress: (rec, total) {

        }).then((value) =>
            saveDataOffPdf(filePath: file.path, documentId: fileName));
      } else {
        Get.snackbar(
            "Atenção ", "Permissão para Acessar o armazenamento não concedida");
      }
    } catch (e) {
      Get.snackbar("Error ", "Não foi possível Concluir o Download");
    }
  }

  Future<bool> pdfIsSync({required String id}) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.get(id);
    late bool ispresent;
    if (data != null) {
      ispresent = true;
    } else {
      ispresent = false;
    }
    //
    // final targetDir = await getExternalStorageDirectory();
    // final  targetDirFolder = Directory('${targetDir?.path}/off');
    // final path=targetDirFolder.path;
    // final File file=File('$path/$id.pdf');
    return ispresent;
  }

  Future<File> getOffPdf({required String id}) async {
    final prefs = await SharedPreferences.getInstance();
    String? localData = prefs.getString(id);

    Map<String, dynamic> dataModel = json.decode(localData!);
    String path = dataModel["filePath"];
    final File file = File(path);
    return file;
  }

  Future<void> saveDataOffPdf(
      {required String documentId, required String filePath}) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> dataModel = {
      'id': documentId,
      'data': DateTime.now().toIso8601String(),
      'filePath': filePath
    };
    String data = json.encode(dataModel);
    prefs.setString(documentId, data);
    print(prefs.get(documentId));
  }
}
