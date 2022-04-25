
import 'package:easmaterialdidatico/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';
class AllProgressIndicator{
Widget circularProgress(){
  return  const Center(
    child: CircularProgressIndicator(
      backgroundColor: Colors.white,
      color: AppColors.orange,
    ),
  );
}}