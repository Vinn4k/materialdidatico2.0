import 'package:easmaterialdidatico/app/controller/active_account_controller.dart';
import 'package:easmaterialdidatico/shared/themes/app_text_stayle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/themes/app_colors.dart';

class ActiveAccountPage extends GetView<ActiveAccountController> {
  const ActiveAccountPage({Key? key}) : super(key: key);

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Sua conta não foi Verificada",
                  style: AppTextStyle.titleHome),
              Text("Por Favor Clique no botão Verificar",
                  style: AppTextStyle.titleRegularWhite),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Get.defaultDialog(
                        title: "Ativar Conta",
                        content: Column(
                          children: [
                            Text("Seu Email: ${controller.email}"),
                            Obx(() {
                              return controller.loading.value
                                  ? const CircularProgressIndicator()
                                  : TextButton(
                                      onPressed: () {
                                        controller.sendVerificationEmail();
                                      },
                                      child: const Text("Verificar"));
                            })
                          ],
                        ));
                  },
                  child: const Text("Verificar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
