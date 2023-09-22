import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plumbus/app/domain/entities/usuario_entity.dart';
import 'package:plumbus/app/domain/repositories/session_repository_interface.dart';
import 'package:plumbus/core/dependency_injection/dependency_injector.dart';

class AuthBloc extends Cubit<AuthState> {
  AuthBloc() : super(const UninitializedState());

  void onStart() async {
    final repository = DependencyInjector.get<ISessionRepository>();

    var result = await repository.getLoggedUser();

    result.when((r) {
      emit(AuthenticatedState(r));
    }, (l) {
      emit(const UnauthenticatedState());
    });
  }

  void onLoggedIn({
    required UsuarioEntity usuario,
  }) async {
    emit(AuthenticatedState(usuario));
  }

  void onLoggedOut() async {
    emit(const UnauthenticatedState());
  }
}

sealed class AuthState {}

class UninitializedState implements AuthState {
  const UninitializedState();
}

class AuthenticatedState implements AuthState {
  final UsuarioEntity usuario;

  const AuthenticatedState(this.usuario);
}

class UnauthenticatedState implements AuthState {
  const UnauthenticatedState();
}
