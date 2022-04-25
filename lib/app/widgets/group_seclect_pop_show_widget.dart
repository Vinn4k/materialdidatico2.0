
import 'package:easmaterialdidatico/app/controller/group_select_controller.dart';
import 'package:easmaterialdidatico/shared/themes/app_text_stayle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupSelectPopShowWidget{
final GroupSelectController _controller=Get.put(GroupSelectController());
  showDialog(){

    return Get.defaultDialog(
      title: "Selecione Sua Turma",
      titleStyle: AppTextStyle.titleRegular,
      barrierDismissible: false,

      content: Column(
        children: [
          SizedBox(
            height: Get.height*0.09,
            width: Get.height*0.2,
            child:listGenerate() ,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed:() =>null, icon:const Icon(Icons.check,color: Colors.green,)),
              IconButton(onPressed:() =>Get.back(), icon: const Icon(Icons.close,color: Colors.red,)),
            ],
          )
        ],
      ),

    );
  }
  Widget listGenerate(){
    return ListView.builder(itemCount: 5, itemBuilder: (BuildContext context, int index){
      return  SizedBox(child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Turma $index"),
          InkWell(
            child: Icon(Icons.circle_outlined),
            onTap: ()=> null,
          )
        ],
      ),);
    });
  }

}