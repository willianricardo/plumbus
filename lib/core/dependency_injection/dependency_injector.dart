import 'package:get_it/get_it.dart';
import 'package:plumbus/app/data/repositories/memory/auth_repository.dart';
import 'package:plumbus/app/data/repositories/memory/produto_repository.dart';
import 'package:plumbus/app/data/repositories/memory/session_repository.dart';
import 'package:plumbus/app/domain/repositories/auth_repository_interface.dart';
import 'package:plumbus/app/domain/repositories/produto_repository_interface.dart';
import 'package:plumbus/app/domain/repositories/session_repository_interface.dart';
import 'package:plumbus/core/adapters/cache/cache_adapter_interface.dart';
import 'package:plumbus/core/adapters/cache/shared_preferences_cache.dart';
import 'package:plumbus/core/adapters/http/client_adapter_interface.dart';
import 'package:plumbus/core/adapters/http/http_client.dart';

final GetIt getIt = GetIt.instance;

abstract class DependencyInjector {
  static void load() {
    /// Packages
    getIt.registerLazySingleton<ICacheAdapter>(
      () => SharedPreferencesCache(),
    );
    getIt.registerLazySingleton<IClientAdapter>(
      () => HttpClient(getIt<ICacheAdapter>()),
    );
    // getIt.registerLazySingleton<IDatabaseAdapter>(
    //   () => SQFLiteDatabase(),
    // );

    /// Session
    getIt.registerLazySingleton<ISessionRepository>(
      () => SessionRepository(getIt<ICacheAdapter>()),
    );

    /// Auth
    getIt.registerLazySingleton<IAuthRepository>(
      () => AuthRepository(),
    );

    /// Produtos
    getIt.registerLazySingleton<IProdutoRepository>(
      () => ProdutoRepository(),
    );
  }

  static T get<T extends Object>() {
    return getIt.get<T>();
  }
}
