import 'package:encrypt/encrypt.dart' as crypto;

class CryptPdfService{


  Future<String> encryptPdf({required String pdfBase64}) async {
    final key = crypto.Key.fromUtf8("3gA2dkfTtlkNBdXgWcVQnhRkkWC5dxWc");
    final iv = crypto.IV.fromLength(16);
    final encrypterData = crypto.Encrypter(crypto.AES(key));
    final pdfEncrypted =  encrypterData.encrypt(pdfBase64, iv: iv);
    return pdfEncrypted.base64.toString();

  }

  String decryptPdf({required String pdfEncrypted})  {
    final key = crypto.Key.fromUtf8("3gA2dkfTtlkNBdXgWcVQnhRkkWC5dxWc");
    final iv = crypto.IV.fromLength(16);

    final decryptLocalPdf = crypto.Encrypter(crypto.AES(key));
    final pdfDecrypted =  decryptLocalPdf.decrypt64(pdfEncrypted, iv: iv);
    return pdfDecrypted;
  }
}