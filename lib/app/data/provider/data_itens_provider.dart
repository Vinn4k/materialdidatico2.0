import 'dart:io';
import 'package:easmaterialdidatico/app/config/firestore_config.dart';


import 'package:cloud_firestore/cloud_firestore.dart';

import '../interface/data_itens_interface.dart';
import '../interface/itens_model.dart';

class DataItensProvider implements IDataItens {
  DataItensProvider({required this.firestore});

    final FirebaseFirestore firestore;
  @override
  Future<QuerySnapshot> getCourses() async {
    QuerySnapshot snapshot =
        await firestore.collection("cursos").get();


    return snapshot;
  }

  @override
  Future<QuerySnapshot> getModules(String course) async {
    QuerySnapshot snapshot = await firestore
        .collection("modulos")
        .doc(course)
        .collection("modulos")
        .get();
    return snapshot;
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
  Future<QuerySnapshot> getSubjects(
      String course, String moduleId) async {
    QuerySnapshot snapshot = await firestore
        .collection("modulos")
        .doc(course)
        .collection("modulos")
        .doc(moduleId)
        .collection("disciplinas")
        .get();
    return snapshot;
  }

}
