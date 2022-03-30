class ItensModel {
  ItensModel({
      String? id, 
      String? titulo,}){
    _id = id;
    _titulo = titulo;
}

  ItensModel.fromJson(dynamic json) {
    _id = json['id'];
    _titulo = json['titulo'];
  }
  String? _id;
  String? _titulo;

  String? get id => _id;
  String? get titulo => _titulo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['titulo'] = _titulo;
    return map;
  }

}