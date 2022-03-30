
import 'package:get/get.dart';

import '../controller/pdf_view_controller.dart';

class PdfViewerBinding implements Bindings{
  @override
  void dependencies() {
Get.lazyPut<PdfViewerControllerUi>((){

  return PdfViewerControllerUi();
});
  }

}