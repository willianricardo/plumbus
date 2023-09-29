import 'package:multiple_result/multiple_result.dart';
import 'package:plumbus/app/domain/entities/login_credential_entity.dart';
import 'package:plumbus/app/domain/entities/usuario_entity.dart';
import 'package:plumbus/app/domain/errors/auth_error.dart';
import 'package:plumbus/app/domain/repositories/auth_repository_interface.dart';

class AuthRepository implements IAuthRepository {
  @override
  Future<Result<UsuarioEntity, LoginFailure>> login(
    LoginCredentialEntity credential,
  ) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      const usuario = UsuarioEntity(
        id: '1',
        ativo: true,
        empresa: 1,
        nome: 'Teste',
        token: 'xyz',
      );

      return const Success(
        usuario,
      );
    } catch (e) {
      return Error(
        LoginFailure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Result<Unit, LogoutFailure>> logout() async {
    try {
      return const Success(unit);
    } catch (e) {
      return Error(
        LogoutFailure(
          e.toString(),
        ),
      );
    }
  }
}
