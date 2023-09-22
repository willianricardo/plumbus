import 'dart:convert';

import 'package:plumbus/app/domain/entities/usuario_entity.dart';

class UsuarioModel extends UsuarioEntity {
  const UsuarioModel({
    required bool ativo,
    required String token,
    required String nome,
    required String id,
    required int empresa,
  }) : super(
          ativo: ativo,
          token: token,
          nome: nome,
          id: id,
          empresa: empresa,
        );

  factory UsuarioModel.fromEntity(UsuarioEntity value) {
    return UsuarioModel(
      ativo: value.ativo,
      token: value.token,
      nome: value.nome,
      id: value.id,
      empresa: value.empresa,
    );
  }

  UsuarioEntity toEntity() {
    return UsuarioEntity(
      ativo: ativo,
      token: token,
      nome: nome,
      id: id,
      empresa: empresa,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'USUSTATUS': ativo,
      'TOKEN': token,
      'USUNOME': nome,
      'USUCODIGO': id,
      'USUEMPRESAPADRAO': empresa,
    };
  }

  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel(
      ativo: map['USUSTATUS'] == "A",
      token: map['TOKEN'] ?? '',
      nome: map['USUNOME'],
      id: map['USUCODIGO'],
      empresa: map['USUEMPRESAPADRAO'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UsuarioModel.fromJson(String source) =>
      UsuarioModel.fromMap(json.decode(source));
}
