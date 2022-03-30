
import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';

import '../interface/data_itens_interface.dart';
import '../interface/itens_model.dart';
import '../provider/data_itens_provider.dart';

class DataItensRepository extends IDataItens{
  DataItensProvider provider= DataItensProvider();
  @override
  Future<QuerySnapshot> getCourses()async {
  return await provider.getCourses();
  }

  @override
  Future<QuerySnapshot> getModules(String course) async{
    return await provider.getModules(course);
  }

  @override
  Future<String> getPdf(String id) {
    // TODO: implement getPdf
    throw UnimplementedError();
  }

  @override
  Future<String> putCourses(ItensModel data) {
    // TODO: implement putCourses
    throw UnimplementedError();
  }

  @override
  Future<String> putModules(ItensModel data) {
    // TODO: implement putModules
    throw UnimplementedError();
  }

  @override
  Future<String> putPdf(File file) {
    // TODO: implement putPdf
    throw UnimplementedError();
  }

  @override
  Future<QuerySnapshot> getSubjects(String course,String moduleId) {
   return provider.getSubjects(course, moduleId);
  }
}