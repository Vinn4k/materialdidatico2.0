import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

class FirestoreMock{

  FakeFirebaseFirestore appInfoMock(){
    final instance = FakeFirebaseFirestore();
    instance.collection('app').doc("info").set({
      'nome': 'EAS',
     'versao':'1.1.3'
    });
    return instance;
  }

  FakeFirebaseFirestore courseData(){
    final instance = FakeFirebaseFirestore();
    instance.collection('cursos').add({
      'ativo': true,
     'firstModule':'40MS5oEwxYLQDBUtVZwj',
      'id':'JKvhYXcuDsUhKrgbvYP7',
      'nome':'Auxiliar de Enfermagem'
    }); instance.collection('cursos').add({
      'ativo': true,
     'firstModule':'1zmJvcLymGdBB3wb7Vtd',
      'id':'xBzfxiqVvIiDvKpEvKja',
      'nome':'Técnico de Enfermagem'
    });
    return instance;
  }
FakeFirebaseFirestore getModules(){
    final instance = FakeFirebaseFirestore();
    instance.collection('modulos').add({
      'id':'JKvhYXcuDsUhKrgbvYP7',
      'nome':'Auxiliar de Enfermagem',
      'modulos':{

      }
    }); instance.collection('cursos').add({
      'ativo': true,
     'firstModule':'1zmJvcLymGdBB3wb7Vtd',
      'id':'xBzfxiqVvIiDvKpEvKja',
      'nome':'Técnico de Enfermagem'
    });
    return instance;
  }



}