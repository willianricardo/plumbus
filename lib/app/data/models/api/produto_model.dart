import 'dart:convert';

import 'package:plumbus/app/domain/entities/produto_entity.dart';

class ProdutoModel extends ProdutoEntity {
  ProdutoModel({
    required id,
    required ativo,
    required descricao,
    required valor,
  }) : super(
          id: id,
          ativo: ativo,
          descricao: descricao,
          valor: valor,
        );

  factory ProdutoModel.fromMap(Map<String, dynamic> map) {
    return ProdutoModel(
      id: map['ID'],
      ativo: map['PROATIVO'] == 'S',
      descricao: map['PRODESCRICAO'] as String,
      valor: double.tryParse(map['PROVLRVENDA'].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ID': id,
      'PROATIVO': ativo ? 'S' : 'N',
      'PRODESCRICAO': descricao,
      'PROVLRVENDA': valor,
    };
  }

  String toJson() => json.encode(toMap());

  factory ProdutoModel.fromJson(String source) =>
      ProdutoModel.fromMap(json.decode(source));
}
