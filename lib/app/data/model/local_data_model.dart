import 'package:meta/meta.dart';
import 'dart:convert';

LocalDataModel localDataModelFromJson(String str) => LocalDataModel.fromJson(json.decode(str));

String localDataModelToJson(LocalDataModel data) => json.encode(data.toJson());

class LocalDataModel {
  LocalDataModel({
   required this.datat,
   required this.datau,
   required this.datap,
  });

  String datat;
  String datau;
  String datap;

  factory LocalDataModel.fromJson(Map<String, dynamic> json) => LocalDataModel(
    datat: json["datat"],
    datau: json["datau"],
    datap: json["datap"],
  );

  Map<String, dynamic> toJson() => {
    "datat": datat,
    "datau": datau,
    "datap": datap,
  };
}
