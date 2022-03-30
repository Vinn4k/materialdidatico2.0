import 'package:easmaterialdidatico/app/controller/home_controller.dart';
import 'package:easmaterialdidatico/app/routes/app_routes.dart';
import 'package:easmaterialdidatico/shared/themes/app_text_stayle.dart';
import 'package:easmaterialdidatico/shared/themes/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: SafeArea(
        child: Container(
          width: Get.width,
          height: Get.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/image/brasao.png"),
                opacity: 0.04,
                alignment: Alignment.bottomCenter,
                scale: 0.7),
          ),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              double sizeForPc = constraints.maxWidth * 0.9;
              if (constraints.maxWidth > 600) {
                sizeForPc = sizeForPc = constraints.maxWidth * 0.5;
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    height: constraints.maxHeight * 0.01,
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 12),
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        controller.logout();
                      },
                      child: const Text(
                        "Sair",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.08,
                  ),
                  Expanded(
                    child: SizedBox(
                      width: constraints.maxWidth * 0.7,
                      child: Image.asset(
                        "assets/image/logo.png",
                        width: constraints.maxWidth,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.04,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: constraints.maxHeight,
                      child: Text(
                        "MATERIAL \n DIDÁTICO",
                        style: TextStyle(
                            fontFamily: 'pro',
                            color: Colors.white,
                            fontSize: sizeForPc * 0.06),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.09,
                    child: Text(
                      "Selecione Seu Curso",
                      style: AppTextStyle.titleWithe,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      width: sizeForPc,
                      height: constraints.maxHeight,
                      child: FutureBuilder<QuerySnapshot>(
                          future: controller.getCourses(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data?.docs[0]["ativo"] == false) {
                                return Center(
                                  child: Text(
                                    "Aguardando Liberação",
                                    style: AppTextStyle.titleRegularWhite,
                                  ),
                                );
                              } else {
                                return ListView.separated(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    Map<String, String> data = {
                                      "nome": snapshot.data?.docs[index]["nome"],
                                      "id": snapshot.data?.docs[index]["id"],
                                    };
                                    return course(
                                        snapshot.data?.docs[index]["nome"], data);
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      height: constraints.maxHeight * 0.01,
                                    );
                                  },
                                );
                              }
                            }
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                backgroundColor: AppColors.orange,
                              ),
                            );
                          }),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(0.0),
                      height: constraints.maxHeight * 0.1,
                      child: Image.asset(
                        "assets/icons/amorEnfer.png",
                        height: constraints.maxHeight,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget course(String title, Map<String, String> data) {
    return Container(
      height: Get.height * 0.08,
      decoration: BoxDecoration(
        color: AppColors.orange,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: InkWell(
        onTap: () {
          if (controller.userCourseId
              .where((item) => item["cursoId"] == data["id"])
              .isNotEmpty) {
            Get.toNamed(
              Routes.MODULE,
              parameters: data,
            );
          } else {
            Get.snackbar("Aviso", "Você não faz parte deste curso",
                snackPosition: SnackPosition.BOTTOM);
          }
        },
        child: Center(
          child: Text(
            title,
            style: AppTextStyle.titleRegular,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
