import 'package:multiple_result/multiple_result.dart';
import 'package:plumbus/app/data/models/memory/usuario_model.dart';
import 'package:plumbus/app/domain/entities/usuario_entity.dart';
import 'package:plumbus/app/domain/errors/auth_error.dart';
import 'package:plumbus/app/domain/repositories/session_repository_interface.dart';
import 'package:plumbus/core/adapters/cache/cache_adapter_interface.dart';
import 'package:plumbus/core/translations/app_translations.dart';

class SessionRepository implements ISessionRepository {
  final ICacheAdapter prefs;

  SessionRepository(this.prefs);

  @override
  Future<Result<UsuarioEntity, AuthFailure>> getLoggedUser() async {
    try {
      if (!await prefs.containsKey("usuario")) {
        return Error(
          UnauthorizedUserFailure(
            AppTranslations.translate('cache_error'),
          ),
        );
      }

      final user = await prefs.getString("usuario");
      return Success(UsuarioModel.fromJson(user));
    } catch (e) {
      return Error(
        UnauthorizedUserFailure(
          AppTranslations.translate('cache_error'),
        ),
      );
    }
  }

  @override
  Future<Result<Unit, AuthFailure>> removeLoggedUser() async {
    try {
      await prefs.remove("usuario");

      return const Success(unit);
    } catch (e) {
      return Error(
        UnauthorizedUserFailure(
          AppTranslations.translate('cache_error'),
        ),
      );
    }
  }

  @override
  Future<Result<Unit, AuthFailure>> setLoggedUser(UsuarioEntity user) async {
    try {
      await prefs.setString(
        "usuario",
        UsuarioModel.fromEntity(user).toJson(),
      );

      return const Success(unit);
    } catch (e) {
      return Error(
        UnauthorizedUserFailure(
          AppTranslations.translate('cache_error'),
        ),
      );
    }
  }
}
