import 'dart:io';

import 'package:easmaterialdidatico/app/controller/pdf_view_controller.dart';
import 'package:easmaterialdidatico/shared/themes/app_colors.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewPage extends GetView<PdfViewerControllerUi> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  final PdfViewerController _pdfViewerController = PdfViewerController();

  final FirebasePerformance performance = FirebasePerformance.instance;

  final data = Get.parameters;

  PdfViewPage({Key? key}) : super(key: key);
  late final Trace trace;

  @override
  Widget build(BuildContext context) {
    String disciplina = data["nome"] ?? "error";
    String offlinePath = data["path"] ?? "not";
    String id = data["id"] ?? "error";
    String pdf = data["linkPdf"] ??
        "https://firebasestorage.googleapis.com/v0/b/cefops.appspot.com/o/Logo%20Azul%20PDF.pdf?alt=media&token=92d52776-2235-4b7e-a2fa-6fe9e33b0bb1";
    trace = performance.newTrace('PDF Load time');
    trace.putAttribute('disciplina', disciplina);

    controller.startTrace(trace);
    if (!GetPlatform.isWeb) {
      controller.disableScreenCapture();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        title: Text("${data["nome"]}"),
        actions: <Widget>[
          GetPlatform.isWeb
              ? IconButton(
                  icon: const Icon(
                    Icons.zoom_in,
                    color: Colors.white,
                    semanticLabel: '+ zoom',
                  ),
                  onPressed: () {
                    _pdfViewerController.zoomLevel = 1.5;
                  },
                )
              : Container(),
          GetPlatform.isAndroid
              ? IconButton(
                  icon: const Icon(
                    Icons.download,
                    color: Colors.white,
                    semanticLabel: 'Marcador',
                  ),
                  onPressed: () {
                    GetPlatform.isAndroid
                        ? controller.downloadPdf(url: pdf, fileName: id)
                        : null;
                  },
                )
              : SizedBox(),
          GetPlatform.isWeb
              ? IconButton(
                  icon: const Icon(
                    Icons.zoom_out,
                    color: Colors.white,
                    semanticLabel: '- zoom',
                  ),
                  onPressed: () {
                    _pdfViewerController.zoomLevel = controller.setZoomInPc();
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
                    controller: _pdfViewerController,
                    key: _pdfViewerKey,
                    password: controller.password.value,
                    enableTextSelection: false,
                    onDocumentLoaded: (doc) async {
                      trace.putAttribute(
                          'plataforma', controller.userDiviceType.value);
                      trace.putAttribute('userId', controller.userID.value);

                      await controller.stopTrace(trace);
                    },
                    onDocumentLoadFailed: (doc) async {
                      trace.putAttribute(
                          'plataforma', controller.userDiviceType.value);
                      trace.putAttribute('userId', controller.userID.value);
                      trace.putAttribute('error', doc.error);
                      await controller.stopTrace(trace);
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
                            fontSize: GetPlatform.isMobile
                                ? Get.width * 0.10
                                : Get.width * 0.078,
                            color: Colors.black.withOpacity(0.2),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              )
            : _detectPdf(pdfOn: pdf, pdfOff: offlinePath),
      ),
    );
  }

  SfPdfViewer _detectPdf({required String pdfOn, required String pdfOff}) {
    if (pdfOff != "not") {
      return SfPdfViewer.file(
        File(pdfOff),
        onDocumentLoaded: (e) async {
          await controller.stopTrace(trace);
        },
        onDocumentLoadFailed: (e) async {
          await controller.stopTrace(trace);
        },
      );
    } else {
      return SfPdfViewer.network(
        pdfOn,
        key: _pdfViewerKey,
        controller: _pdfViewerController,
        enableTextSelection: false,
        password: controller.password.value,
        onDocumentLoaded: (doc) async {
          trace.putAttribute('plataforma', controller.userDiviceType.value);
          trace.putAttribute('userId', controller.userID.value);

          await controller.stopTrace(trace);
        },
        onDocumentLoadFailed: (doc) async {
          trace.putAttribute('plataforma', controller.userDiviceType.value);
          trace.putAttribute('userId', controller.userID.value);
          trace.putAttribute('error', doc.error);
          await controller.stopTrace(trace);
        },
      );
    }
  }
}
