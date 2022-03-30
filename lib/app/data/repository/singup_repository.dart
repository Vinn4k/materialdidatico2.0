import 'package:easmaterialdidatico/app/data/provider/singup_provider.dart';

class SingUpRepository {
  final SingupProvider _provider = SingupProvider();

  Future<void> singUp(String nome, String cpf, String email, String uid,
      String courseid, String modouleId) async {
    _provider.singUp(nome, cpf, email, uid, courseid, modouleId);
  }
}
