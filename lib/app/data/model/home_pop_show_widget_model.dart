class HomePopShowWidgetModel {
  HomePopShowWidgetModel({
      this.tituloPop, 
      this.curso, 
      this.mostrar, 
      this.imgUrl, 
      this.paginaMatricula, 
      this.tituloBotao,});

  HomePopShowWidgetModel.fromJson(dynamic json) {
    tituloPop = json['tituloPop'];
    curso = json['curso'];
    mostrar = json['mostrar'];
    imgUrl = json['imgUrl'];
    paginaMatricula = json['paginaMatricula'];
    tituloBotao = json['tituloBotao'];
  }
  String? tituloPop;
  String? curso;
  bool? mostrar;
  String? imgUrl;
  String? paginaMatricula;
  String? tituloBotao;
HomePopShowWidgetModel copyWith({  String? tituloPop,
  String? curso,
  bool? mostrar,
  String? imgUrl,
  String? paginaMatricula,
  String? tituloBotao,
}) => HomePopShowWidgetModel(  tituloPop: tituloPop ?? this.tituloPop,
  curso: curso ?? this.curso,
  mostrar: mostrar ?? this.mostrar,
  imgUrl: imgUrl ?? this.imgUrl,
  paginaMatricula: paginaMatricula ?? this.paginaMatricula,
  tituloBotao: tituloBotao ?? this.tituloBotao,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tituloPop'] = tituloPop;
    map['curso'] = curso;
    map['mostrar'] = mostrar;
    map['imgUrl'] = imgUrl;
    map['paginaMatricula'] = paginaMatricula;
    map['tituloBotao'] = tituloBotao;
    return map;
  }

}