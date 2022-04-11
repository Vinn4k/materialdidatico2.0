
import 'package:easmaterialdidatico/app/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/themes/app_colors.dart';
import '../../shared/themes/app_text_stayle.dart';
import '../routes/app_routes.dart';

Widget course(String title,bool status, Map<String, String> data,HomeController controller) {
  return Container(
    height: Get.height * 0.08,
    decoration: BoxDecoration(
      color:status? AppColors.orange:Colors.grey,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: Colors.white, width: 2),
    ),
    child: InkWell(
      onTap:status? () {
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
      }:(){
        Get.snackbar("Aviso", "Curso desativado",
            snackPosition: SnackPosition.BOTTOM);
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
