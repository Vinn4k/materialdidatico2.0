
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/themes/app_colors.dart';
import '../controller/home_pop_show_widget_controller.dart';
import '../data/model/home_pop_show_widget_model.dart';



class HomePopShowWidget {
  HomePopShowWidgetController controller =
      Get.put(HomePopShowWidgetController());

  showDialog({required HomePopShowWidgetModel data}) {
    return Get.defaultDialog(
      barrierDismissible: false,
      title: "${data.tituloPop}",
      content: Column(
        children: [
           Image(
            image: NetworkImage(
                "${data.imgUrl}",
                scale: 3),
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width:
                    GetPlatform.isMobile ? Get.width * 0.5 : Get.width * 0.175,
                child: ElevatedButton(
                  onPressed: () async{
                   await controller.courSelect(
                        courseName: "${data.curso}",
                        status: "open");
                    launchUrl(Uri.parse("${data.paginaMatricula}"));
                    controller.dispose();
                    Get.back();

                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.blue),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(10)),
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(fontSize: 15))),
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:  [
                       const Icon(
                          Icons.ads_click,
                          color: AppColors.orange,
                        ),
                        Text("${data.tituloBotao}")
                      ],
                    ),
                  ),
                ),
              ),
              Obx(
                () {
                  return IconButton(
                    onPressed: controller.showCloseButton.value? () async {
                      await controller.courSelect(
                          courseName: "${data.curso}",
                          status: "closed");
                       controller.dispose();
                       Get.back();
                    }:null,
                    icon:  Icon(
                      Icons.close,
                      color:controller.showCloseButton.value? Colors.red:Colors.grey,
                    ),
                  );
                }
              ),
            ],
          ),
        ],
      ),
    );
  }
}
