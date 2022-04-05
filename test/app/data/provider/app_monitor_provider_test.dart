

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easmaterialdidatico/app/data/provider/app_monitor_provider.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/firestore_mock.dart';

void main()async{
  final instance = FirestoreMock().appInfoMock();
  AppMonitorProvider _provider=AppMonitorProvider(firestore: instance);

  test("App info ", ()async{
    DocumentSnapshot data= await _provider.getAppInfo() ;
  expect("EAS", data.get("nome"));
  expect("1.1.3", data.get("versao"));
  });
}