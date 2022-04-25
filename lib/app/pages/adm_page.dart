import 'package:easmaterialdidatico/app/controller/adm_controller.dart';
import 'package:easmaterialdidatico/shared/themes/app_colors.dart';
import 'package:easmaterialdidatico/shared/themes/app_text_stayle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdmPage extends GetView<AdmController> {
  const AdmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.blue,
        body: Container(
          decoration: GetPlatform.isMobile
              ? const BoxDecoration()
              : const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/image/brasao.png"),
                      opacity: 0.09,
                      scale: 1,
                      alignment: Alignment.centerRight),
                ),
          height: Get.height,
          child: Column(
            children: [
              Center(
                child: Text(
                  "Gerenciar Usuários",
                  style: AppTextStyle.titleRegularWhite,
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: Get.width * 0.09,
                    child: Column(
                      children: [
                        ElevatedButton(onPressed: () {}, child: const Text("dsfsd")),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
