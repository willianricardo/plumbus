import 'package:multiple_result/multiple_result.dart';
import 'package:plumbus/app/domain/entities/usuario_entity.dart';
import 'package:plumbus/app/domain/errors/auth_error.dart';

abstract class ISessionRepository {
  Future<Result<UsuarioEntity, AuthFailure>> getLoggedUser();
  Future<Result<Unit, AuthFailure>> setLoggedUser(UsuarioEntity user);
  Future<Result<Unit, AuthFailure>> removeLoggedUser();
}
