
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'itens_model.dart';

abstract class IDataItens{

  Future<QuerySnapshot> getCourses ();
  Future<QuerySnapshot>getModules (String course);
  Future<QuerySnapshot>getSubjects(String course,String moduleId);
  Future<String> getPdf (String id);
  Future<String> putPdf (File file);
  Future<String> putCourses (ItensModel data);
  Future<String> putModules (ItensModel data);

}