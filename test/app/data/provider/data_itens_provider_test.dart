
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easmaterialdidatico/app/data/provider/data_itens_provider.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/firestore_mock.dart';

void main()async{
 final FirestoreMock _mock=FirestoreMock();
  DataItensProvider _data;

 group("Data itens provider test", (){

   test("Get Courses test", ()async{
     _data=DataItensProvider(firestore: _mock.courseData());
     QuerySnapshot data=await _data.getCourses();
     expect(2, data.size);
     expect("Auxiliar de Enfermagem", data.docs[0].get("nome"));
     expect("Técnico de Enfermagem", data.docs[1].get("nome"));
   });
   test("Get Modules", (){


   });
 });

}