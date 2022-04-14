import 'package:easmaterialdidatico/app/controller/pdf_view_controller.dart';
import 'package:easmaterialdidatico/shared/themes/app_colors.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewPage extends GetView<PdfViewerControllerUi> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  final PdfViewerController _pdfViewerController = PdfViewerController();

  FirebasePerformance performance = FirebasePerformance.instance;

  final data = Get.parameters;

  PdfViewPage({Key? key}) : super(key: key);
  late Trace trace;

  @override
  Widget build(BuildContext context) {
    String disciplina = data["nome"] ?? "error";
    trace = performance.newTrace('PDF Load time');
    trace.putAttribute('disciplina', disciplina);

    if (!GetPlatform.isWeb) {
      controller.disableScreenCapture();
    }
    String pdf = data["linkPdf"] ??
        "https://firebasestorage.googleapis.com/v0/b/cefops.appspot.com/o/Logo%20Azul%20PDF.pdf?alt=media&token=92d52776-2235-4b7e-a2fa-6fe9e33b0bb1";
    startTrace();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        title: Text("${data["nome"]}"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
              semanticLabel: 'Marcador',
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
          GetPlatform.isWeb
              ? IconButton(
            icon: const Icon(
              Icons.zoom_in,
              color: Colors.white,
              semanticLabel: '+ zoom',
            ),
            onPressed: () {
              _pdfViewerController.zoomLevel = 3;
            },
          )
              : Container(),
          GetPlatform.isWeb
              ? IconButton(
            icon: const Icon(
              Icons.zoom_out,
              color: Colors.white,
              semanticLabel: '- zoom',
            ),
            onPressed: () {
              _pdfViewerController.zoomLevel = 0;
            },
          )
              : Container(),
        ],
      ),
      body: SafeArea(
        child: GetPlatform.isWeb
            ? Stack(
          children: [
            SfPdfViewer.network(
              pdf,
              key: _pdfViewerKey,
              password: controller.password.value,
              enableTextSelection: false,
              onDocumentLoaded: (doc) {
                trace.putAttribute(
                    'plataforma', controller.userDiviceType.value);
                trace.putAttribute('userId', controller.userID.value);

                stopTrace();
              },
              onDocumentLoadFailed: (doc) {
                trace.putAttribute(
                    'plataforma', controller.userDiviceType.value);
                trace.putAttribute('userId', controller.userID.value);
                trace.putAttribute('error', doc.error);
                stopTrace();
              },
              initialZoomLevel: controller.setZoomInPc(),
            ),
            Center(
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(19 / 360),
                child: Obx(() {
                  return Text(
                    controller.userCpf.value,
                    style: TextStyle(
                      fontSize:GetPlatform.isMobile? Get.width * 0.10: Get.width * 0.082,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  );
                }),
              ),
            ),
          ],
        )
            : SfPdfViewer.network(
          pdf,
          key: _pdfViewerKey,
          enableTextSelection: false,
          password: controller.password.value,
          onDocumentLoaded: (doc) {
            trace.putAttribute(
                'plataforma', controller.userDiviceType.value);
            trace.putAttribute('userId', controller.userID.value);

            stopTrace();
          },
          onDocumentLoadFailed: (doc) {
            trace.putAttribute(
                'plataforma', controller.userDiviceType.value);
            trace.putAttribute('userId', controller.userID.value);
            trace.putAttribute('error', doc.error);
            stopTrace();
          },
        ),
      ),
    );
  }

  Future<void> startTrace() async {
    await trace.start();
  }

  Future<void> stopTrace() async {
    await trace.stop();
  }
}
