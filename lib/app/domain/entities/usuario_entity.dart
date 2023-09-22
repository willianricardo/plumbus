import 'package:equatable/equatable.dart';

class UsuarioEntity extends Equatable {
  final String id;
  final bool ativo;
  final int empresa;
  final String nome;
  final String token;

  const UsuarioEntity({
    required this.id,
    required this.ativo,
    required this.empresa,
    required this.nome,
    required this.token,
  });

  @override
  List<Object?> get props => [
        id,
        ativo,
        empresa,
        nome,
        token,
      ];
}
