
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easmaterialdidatico/app/controller/student_group_select_controller.dart';
import 'package:easmaterialdidatico/app/widgets/all_progress_indicator_widget.dart';
import 'package:easmaterialdidatico/shared/themes/app_text_stayle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupSelectPopShowWidget {
  final GroupSelectController _controller = Get.put(GroupSelectController());

  showDialog() {
    _controller.getGroup();
    return Get.defaultDialog(
      title: "Selecione Sua Turma",
      titleStyle: AppTextStyle.titleRegular,
      barrierDismissible: false,
      content: Column(
        children: [
          SizedBox(
            height: Get.height * 0.09,
            width: Get.height * 0.2,
            child: listGenerate(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () async{
                    await _controller.setStudentGroup();
                  },
                  icon: const Icon(
                    Icons.check,
                    color: Colors.green,
                  )),
              IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.close,
                    color: Colors.red,
                  )),
            ],
          )
        ],
      ),
    );
  }

  Widget listGenerate() {
    return StreamBuilder(
      stream: _controller.getGroup().asStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.size,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Turma ${snapshot.data?.docs[index].get("nome")}"),
                    Obx(() {
                      return IconButton(
                        icon: _controller.selectedIndex.value == index
                            ? const Icon(Icons.check_circle)
                            : const Icon(Icons.circle_outlined),
                        onPressed: () {
                          _controller.selectedIndex.value = index;
                          _controller.getSelectedGroup(snapshot.data!.docs[index]);
                        },
                      );
                    })
                  ],
                ),
              );
            },
          );
        } else {
          return AllProgressIndicator().circularProgress();
        }
      },
    );
  }
}
