class HomePopShowWidgetModel {
  HomePopShowWidgetModel({
      this.curso, 
      this.mostrar, 
      this.imgUrl, 
      this.paginaMatricula,});

  HomePopShowWidgetModel.fromJson(dynamic json) {
    curso = json['curso'];
    mostrar = json['mostrar'];
    imgUrl = json['imgUrl'];
    paginaMatricula = json['paginaMatricula'];
  }
  String? curso;
  bool? mostrar;
  String? imgUrl;
  String? paginaMatricula;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['curso'] = curso;
    map['mostrar'] = mostrar;
    map['imgUrl'] = imgUrl;
    map['paginaMatricula'] = paginaMatricula;
    return map;
  }

}