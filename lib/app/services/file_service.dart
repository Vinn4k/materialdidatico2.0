import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easmaterialdidatico/app/security/crypt_pdf_service.dart';
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
    final File file = File('$path/$fileName.eas');
    targetDirFolder.existsSync() ? null : targetDirFolder.create();
    final status = await Permission.storage.request();

    final Dio dio = Dio();
    try {
      if (status.isGranted) {
        await dio
            .download(url, file.path,
                deleteOnError: true, onReceiveProgress: (rec, total) {})
            .then((value) async {
          await encryptPdf(pdfPath: file.path);
          await saveDataOffPdf(filePath: file.path, documentId: fileName);
        });
      } else {
        Get.snackbar(
            "Atenção ", "Permissão para Acessar o armazenamento não concedida");
      }
    } catch (e) {
      Get.snackbar("Error ", "Não foi possível Concluir o Download");
    }
  }

  Future<void> encryptPdf({required String pdfPath}) async {
    final CryptPdfService pdfService = CryptPdfService();
    final localPdf = await File(pdfPath).readAsBytes();
    final localPdfToBase64 = base64.encode(localPdf);

    final encryptedPdf =
        await pdfService.encryptPdf(pdfBase64: localPdfToBase64);
    final file = File(pdfPath);
    await file.writeAsString(encryptedPdf);
    await decryptPdf(pdfPath: file.path);
  }

  Future<String> decryptPdf({required String pdfPath}) async {
    final CryptPdfService pdfService = CryptPdfService();

    final file = File(pdfPath);
    final encryptedPdf = await file.readAsString();
    return await pdfService.decryptPdf(pdfEncrypted: encryptedPdf);
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
    return ispresent;
  }

  Future<String> getOffPdf({required String id}) async {
    final prefs = await SharedPreferences.getInstance();
    String? localData = prefs.getString(id);

    Map<String, dynamic> dataModel = json.decode(localData!);
    String path = dataModel["filePath"];
    final String pdfDecrypted = await decryptPdf(pdfPath: path);
    return pdfDecrypted;
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
  }
}
