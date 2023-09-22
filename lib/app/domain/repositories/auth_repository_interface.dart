import 'package:multiple_result/multiple_result.dart';
import 'package:plumbus/app/domain/entities/login_credential_entity.dart';
import 'package:plumbus/app/domain/entities/usuario_entity.dart';
import 'package:plumbus/app/domain/errors/auth_error.dart';

abstract class IAuthRepository {
  Future<Result<UsuarioEntity, LoginFailure>> login(
    LoginCredentialEntity credential,
  );
  Future<Result<Unit, LogoutFailure>> logout();
}
