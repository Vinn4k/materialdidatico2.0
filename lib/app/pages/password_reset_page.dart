import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/themes/app_colors.dart';
import '../../shared/themes/app_text_stayle.dart';
import '../controller/password_reset_controller.dart';
import '../widgets/form_login_widget.dart';

class PasswordReset extends GetView<PasswordResetController> {
  PasswordReset({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.blue,
      child: Container(
        decoration: GetPlatform.isMobile
            ? const BoxDecoration()
            : const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/image/brasao.png"),
                    opacity: 0.09,
                    scale: 1,
                    alignment: Alignment.centerRight),
              ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            constraints: BoxConstraints(
                minWidth: Get.width * 0.2,
                maxWidth:
                    GetPlatform.isMobile ? Get.width * 0.9 : Get.width * 0.5,
                maxHeight: Get.height * 0.7,
                minHeight: Get.height * 0.2),
            child: Column(children: [
              SizedBox(
                height: Get.height * 0.01,
              ),
              SizedBox(
                width: Get.width * 0.55,
                height: Get.height * 0.22,
                child: Image.asset(
                  "assets/image/logov2.png",
                  scale: 1,
                  filterQuality: FilterQuality.high,
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Center(
                child: Text(
                  "Resetar minha Senha",
                  style: AppTextStyle.titleRegularBold,
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Form(
                key: _formKey,
                child: FormLoginWidget("E-mail", Icons.email, emailController,
                    false, AppColors.blue, TextInputType.emailAddress),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Obx(
                () {
                  return controller.loadingPage.value
                      ? const CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          color: AppColors.orange,
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              controller.resetPassword(
                                  email: emailController.text);
                            }
                          },
                          child: const Text(
                            "Enviar",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(AppColors.blue),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.all(Get.height * 0.02)),
                            textStyle: MaterialStateProperty.all(
                              TextStyle(
                                fontSize: Get.height * 0.02,
                              ),
                            ),
                          ),
                        );
                },
              )
            ]),
          ),
        ),
      ),
    );
  }

  Widget forMobile() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      constraints: BoxConstraints(
          minWidth: Get.width * 0.2,
          maxWidth: Get.width * 0.5,
          maxHeight: Get.height * 0.7,
          minHeight: Get.height * 0.2),
      child: Column(children: [
        SizedBox(
          height: Get.height * 0.01,
        ),
        SizedBox(
          width: Get.width * 0.4,
          height: Get.height * 0.22,
          child: Image.asset(
            "assets/image/logov2.png",
            scale: 1,
            filterQuality: FilterQuality.high,
          ),
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Center(
          child: Text(
            "Resetar minha Senha",
            style: AppTextStyle.titleRegularBold,
          ),
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Form(
          key: _formKey,
          child: FormLoginWidget(
              "E-mail", Icons.email, emailController, false, AppColors.blue,TextInputType.emailAddress),
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Obx(
          () {
            return controller.loadingPage.value
                ? const CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    color: AppColors.orange,
                  )
                : ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                       controller.resetPassword(email: emailController.text);
                      }
                    },
                    child: const Text(
                      "Entrar",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.blue),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.all(Get.height * 0.02)),
                      textStyle: MaterialStateProperty.all(
                        TextStyle(
                          fontSize: Get.height * 0.02,
                        ),
                      ),
                    ),
                  );
          },
        )
      ]),
    );
  }
}
