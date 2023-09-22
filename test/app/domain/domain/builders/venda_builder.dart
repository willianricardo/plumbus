import 'package:plumbus/app/domain/entities/venda_entity.dart';

class VendaBuilder {
  static VendaEntity withValues({
    int empresa = 1,
    String id = '1',
    bool ativo = true,
  }) {
    return VendaEntity(
      empresa: empresa,
      id: id,
      ativo: ativo,
    );
  }
}
