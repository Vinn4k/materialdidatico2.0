import 'package:easmaterialdidatico/app/data/provider/app_monitor_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppMonitorRepository {
  final AppMonitorProvider _provider =
      AppMonitorProvider(firestore: FirebaseFirestore.instance);

  Future<DocumentSnapshot> getApInfo() async {
    return _provider.getAppInfo();
  }
}
