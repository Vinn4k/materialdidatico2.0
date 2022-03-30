
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/themes/app_colors.dart';
import '../routes/app_routes.dart';

class ResetPasswordPopShow{

  Future popShowMessage(){
    return Get.defaultDialog(
      title: "Enviamos um E-mail para você",
      titleStyle:
      const TextStyle(color: AppColors.blue),
      middleTextStyle:
      const TextStyle(color: Colors.white),
      barrierDismissible: false,
      content: Column(
        children: [
          const Text("Se seu e-mail estiver"),
          const Text("cadastrado em nossa base"),
          const Text("você irá receber um e-mail "),
          const Text(
              "para redefinir sua senha em ate 5 minutos"),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColors.blue)),
              onPressed: () {
                Get.offAndToNamed(Routes.LOGIN);
              },
              child: const Text(
                "Ok",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20),
              ))
        ],
      ),
    );
  }
}