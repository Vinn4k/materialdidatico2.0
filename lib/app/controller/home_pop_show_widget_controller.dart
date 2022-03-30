import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';

class HomePopShowWidgetController extends GetxController {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;



  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 10),(){
      showCloseButton.value=true;
    });
  }

RxBool showCloseButton=false.obs;

///Envia os dados do click para o google analytics
  Future<void> courSelect(
      {required String courseName, required String status}) async {
    await _analytics.logEvent(
        name:"Cliques_em_cursos_livres",
      parameters: {
        "content_type": "anúncio",
        "item_name":courseName,
        "item_staus":status,
        "click_time":Timestamp.now().toString()
      }
    );

  }
}
