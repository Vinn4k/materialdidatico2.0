class UserInfoModel {
  UserInfoModel({
      List<Cursos>? cursos, 
      String? email, 
      List<Modulos>? modulos, 
      String? uid, 
      String? nome, 
      String? cpf,}){
    _cursos = cursos;
    _email = email;
    _modulos = modulos;
    _uid = uid;
    _nome = nome;
    _cpf = cpf;
}

  UserInfoModel.fromJson(dynamic json) {
    if (json['cursos'] != null) {
      _cursos = [];
      json['cursos'].forEach((v) {
        _cursos?.add(Cursos.fromJson(v));
      });
    }
    _email = json['email'];
    if (json['modulos'] != null) {
      _modulos = [];
      json['modulos'].forEach((v) {
        _modulos?.add(Modulos.fromJson(v));
      });
    }
    _uid = json['uid'];
    _nome = json['nome'];
    _cpf = json['cpf'];
  }
  List<Cursos>? _cursos;
  String? _email;
  List<Modulos>? _modulos;
  String? _uid;
  String? _nome;
  String? _cpf;

  List<Cursos>? get cursos => _cursos;
  String? get email => _email;
  List<Modulos>? get modulos => _modulos;
  String? get uid => _uid;
  String? get nome => _nome;
  String? get cpf => _cpf;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_cursos != null) {
      map['cursos'] = _cursos?.map((v) => v.toJson()).toList();
    }
    map['email'] = _email;
    if (_modulos != null) {
      map['modulos'] = _modulos?.map((v) => v.toJson()).toList();
    }
    map['uid'] = _uid;
    map['nome'] = _nome;
    map['cpf'] = _cpf;
    return map;
  }

}

class Modulos {
  Modulos({
      String? modulo, 
      bool? ativo,}){
    _modulo = modulo;
    _ativo = ativo;
}

  Modulos.fromJson(dynamic json) {
    _modulo = json['modulo'];
    _ativo = json['ativo'];
  }
  String? _modulo;
  bool? _ativo;

  String? get modulo => _modulo;
  bool? get ativo => _ativo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['modulo'] = _modulo;
    map['ativo'] = _ativo;
    return map;
  }

}

class Cursos {
  Cursos({
      bool? ativo, 
      String? cursoId,}){
    _ativo = ativo;
    _cursoId = cursoId;
}

  Cursos.fromJson(dynamic json) {
    _ativo = json['ativo'];
    _cursoId = json['cursoId'];
  }
  bool? _ativo;
  String? _cursoId;

  bool? get ativo => _ativo;
  String? get cursoId => _cursoId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ativo'] = _ativo;
    map['cursoId'] = _cursoId;
    return map;
  }

}