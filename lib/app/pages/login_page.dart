
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/themes/app_colors.dart';
import '../../shared/themes/app_text_stayle.dart';
import '../controller/login_controller.dart';
import '../routes/app_routes.dart';
import '../widgets/form_login_widget.dart';

class LoginPage extends GetView {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passowrdController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoginPage({Key? key}) : super(key: key);
 LoginController controller= Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GetPlatform.isMobile ? Colors.white : AppColors.blue,
      body: SingleChildScrollView(
        child: Container(
          decoration: GetPlatform.isMobile
              ? const BoxDecoration()
              : const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/image/brasao.png'),
                      opacity: 0.09,
                      scale: 1,
                      alignment: Alignment.centerRight),
                ),
          height: Get.height,
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Center(
                  child: SizedBox(
                    width: Get.width * 0.4,
                    height: Get.height * 0.08,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      constraints.maxWidth >= 600 ? forPC() : forMobile()
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: Get.height,
                  ),
                ),

              ],
            );
          }),
        ),
      ),
    );
  }

  Widget forMobile() {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 700,
        minHeight: 300,
      ),
      width: Get.width * 0.9,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.01,
          ),
          SizedBox(
            width: Get.width * 0.55,
            height: Get.height * 0.22,
            child: Image.asset(
              'assets/image/logov2.png',
            ),
          ),
          Center(
            child: Text(
              "EAS-Material Didático",
              style: AppTextStyle.titleRegularBold,

          )),
          FormLoginWidget(
              "E-mail", Icons.person, emailController, false, AppColors.blue,TextInputType.emailAddress),
          FormLoginWidget(
              "Senha", Icons.lock, passowrdController, true, AppColors.blue,TextInputType.visiblePassword),
          Padding(
            padding: EdgeInsets.zero,
            child: Row(
              children: [
                Expanded(
                    child: SizedBox(
                  width: Get.width,
                )),
                TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.PASSWORDRESET);
                  },
                  child: const Text(
                    "Esqueci a senha",
                    style: TextStyle(color: AppColors.blue),
                  ),
                ),
              ],
            ),
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
                          controller.loadingPage.value = true;
                          await controller.login(
                              emailController.text, passowrdController.text);
                          controller.loadingPage.value = false;
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
          ),
        ],
      ),
    );
  }

  Widget forPC() {
    return Container(
      width: Get.width * 0.45,
      height: Get.height * 0.75,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: SizedBox(

        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.01,
            ),
            SizedBox(
              width: Get.width * 0.4,
              height: Get.height * 0.22,
              child: Image.asset(
                'assets/image/logov2.png',
              ),
            ),
            Center(

              child: Text(
                "EAS Material Didático ",
                style: AppTextStyle.titleRegularBold,

            )),
            SizedBox(
              width: Get.width*0.8,
              height: Get.height*0.13,
              child: FormLoginWidget(
                  "E-mail", Icons.person, emailController, false, AppColors.blue,TextInputType.emailAddress),
            ),
            SizedBox(
              width: Get.width*0.8,
              height: Get.height*0.13,
              child: FormLoginWidget(
                  "Senha", Icons.lock, passowrdController, true, AppColors.blue,TextInputType.visiblePassword),
            ),
            Row(
              children: [
                Expanded(
                    child: SizedBox(
                  width: Get.width,
                )),
                TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.PASSWORDRESET);
                  },
                  child: const Text(
                    "Esqueci a senha",
                    style: TextStyle(color: AppColors.blue),
                  ),
                ),
              ],
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
                            controller.loadingPage.value = true;
                            await controller.login(emailController.text, passowrdController.text);
                            controller.loadingPage.value = false;
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
            ),
          ],
        ),
      ),
    );
  }
}
