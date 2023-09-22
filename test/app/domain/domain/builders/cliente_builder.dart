import 'package:plumbus/app/domain/entities/cliente_entity.dart';

class ClienteBuilder {
  static ClienteEntity withValues({
    String id = '1',
    bool ativo = true,
    String nome = 'test',
  }) {
    return ClienteEntity(
      id: id,
      ativo: ativo,
      nome: nome,
    );
  }
}
