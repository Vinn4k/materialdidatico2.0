

import 'package:easmaterialdidatico/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormLoginWidget extends GetWidget{
    const FormLoginWidget( this.label, this.iconData, this.controllerT, this.isvisible, this.colors, this.keyboardType,{Key? key}) : super(key: key);
final String label;
final IconData iconData;
final TextEditingController controllerT;
final bool isvisible;
final Color colors;
final TextInputType keyboardType;



@override
  Widget build(BuildContext context) {

return Padding(
  padding: const EdgeInsets.all(20.0),
  child: TextFormField(
    style:  TextStyle(color: colors),
    obscureText: isvisible,
    controller: controllerT,
  keyboardType:keyboardType ,
    decoration:  InputDecoration(
      fillColor: Colors.amber,
      labelText: label,
      labelStyle:  TextStyle(
        color: colors
      ),
      hintStyle:  TextStyle(
        color: colors
      ),
      errorStyle: const TextStyle(
        color: AppColors.orange,

      ),

      enabledBorder: OutlineInputBorder(
        borderSide:  BorderSide(width: 2, color: colors),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 2, color: AppColors.orange),
        borderRadius: BorderRadius.circular(10),
      ),
      prefixIcon:  Icon(iconData, color: colors),

    ),

    validator: (String? value) {
      if (value == null || value.isEmpty) {
        return "O campo não pode ser vazio";
      }
      if(label=="Repita sua Senha"){
    
      }
          if(label=="E-mail"){
            if(!controllerT.text.removeAllWhitespace.isEmail){
              return "E-mail inválido";
            }
            return null;
          }
      if(label=="CPF"){
        if(!controllerT.text.removeAllWhitespace.isCpf){
          return "CPF inválido";
        }
        return null;
      }
      return null;
    },
    maxLines: 1,

  ),
);
  }
}

