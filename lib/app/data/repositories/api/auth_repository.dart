import 'dart:convert';

import 'package:multiple_result/multiple_result.dart';
import 'package:plumbus/app/data/models/api/usuario_model.dart';
import 'package:plumbus/app/domain/entities/login_credential_entity.dart';
import 'package:plumbus/app/domain/entities/usuario_entity.dart';
import 'package:plumbus/app/domain/errors/auth_error.dart';
import 'package:plumbus/app/domain/repositories/auth_repository_interface.dart';
import 'package:plumbus/core/adapters/http/client_adapter_interface.dart';
import 'package:plumbus/core/environments/app_environment.dart';
import 'package:plumbus/core/translations/app_translations.dart';

class AuthRepository implements IAuthRepository {
  final IClientAdapter http;

  AuthRepository(this.http);

  @override
  Future<Result<UsuarioEntity, LoginFailure>> login(
    LoginCredentialEntity credential,
  ) async {
    try {
      final response = await http.post(
        '/"Login"',
        body: json.encode({
          'usuario': credential.user,
          'senha': credential.password,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Basic ${AppEnvironments.get('AUTHORIZATION_TOKEN')}',
        },
      );

      if (response.statusCode != 200) {
        return Error(
          LoginFailure(AppTranslations.translate('connection_error')),
        );
      }

      if (json.decode(response.body).containsKey('error')) {
        return Error(
          LoginFailure(json.decode(response.body)['error']),
        );
      }

      return Success(
        UsuarioModel.fromMap(json.decode(response.body)['usuario']),
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
