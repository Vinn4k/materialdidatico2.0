import 'package:easmaterialdidatico/app/controller/subject_controller.dart';
import 'package:easmaterialdidatico/app/routes/app_routes.dart';
import 'package:easmaterialdidatico/app/widgets/all_progress_indicator_widget.dart';
import 'package:easmaterialdidatico/shared/themes/app_text_stayle.dart';
import 'package:easmaterialdidatico/shared/themes/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubjectPage extends GetView<SubjectController> {
  final data = Get.parameters;

  SubjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String? courseId = data["cursoId"];
    final String? id = data["id"];

    return Scaffold(
      backgroundColor: AppColors.blue,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/image/brasao.png"),
                opacity: 0.04,
                alignment: Alignment.bottomCenter,
                scale: 0.7),
          ),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SizedBox(
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "Disciplinas ",
                          style: TextStyle(
                              fontFamily: 'pro',
                              color: Colors.white,
                              fontSize: constraints.maxWidth * 0.1),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: GetPlatform.isMobile ? 0 : 3,
                      child: SizedBox(
                        width: constraints.maxWidth * 0.9,
                        height: constraints.maxHeight * 0.9,
                        child: Center(
                          child: FutureBuilder(
                            future: controller.getSubjects(courseId!, id!),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                return  ListView.separated(
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      Map<String, String> data = {
                                        "nome": snapshot.data?.docs[index]
                                            ["nome"],
                                        "id": snapshot.data?.docs[index]["id"],
                                        "linkPdf": snapshot.data?.docs[index]
                                            ["linkPdf"]
                                      };
                                      return Container(
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: ListTile(
                                          leading: Icon(
                                            snapshot.data?.docs[index]["ativo"]
                                                ? Icons.menu_book
                                                : Icons.do_disturb_alt_rounded,
                                            color: snapshot.data?.docs[index]
                                                    .get("ativo")
                                                ? Colors.white
                                                : AppColors.orange,
                                          ),
                                          title: Text(
                                            snapshot.data?.docs[index]["nome"],
                                            style: snapshot.data?.docs[index]
                                                    ["ativo"]
                                                ? AppTextStyle.titleRegularWhite
                                                : AppTextStyle.titleRegularGrey,
                                          ),
                                          onTap: snapshot.data?.docs[index]
                                                  ["ativo"]
                                              ? () async {
                                                  controller.pdfIsSync(
                                                      id: snapshot.data
                                                          ?.docs[index]["id"],
                                                      data: data);
                                                }
                                              : () {
                                                  Get.snackbar("Aviso",
                                                      "Disciplina Desabilitada",
                                                      snackPosition:
                                                          SnackPosition.BOTTOM);
                                                },
                                        ),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return SizedBox(
                                        height: Get.height * 0.015,
                                      );
                                    },
                                    itemCount: snapshot.data!.docs.length);
                              }
                              if (snapshot.hasError) {
                                const Center(
                                  child: Text("Erro"),
                                );
                              }
                              return AllProgressIndicator().circularProgress();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
