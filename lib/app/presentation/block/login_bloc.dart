import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plumbus/app/domain/entities/login_credential_entity.dart';
import 'package:plumbus/app/domain/entities/usuario_entity.dart';
import 'package:plumbus/app/domain/errors/auth_error.dart';
import 'package:plumbus/app/domain/repositories/auth_repository_interface.dart';
import 'package:plumbus/app/domain/repositories/session_repository_interface.dart';
import 'package:plumbus/app/presentation/block/auth_bloc.dart';
import 'package:plumbus/core/dependency_injection/dependency_injector.dart';
import 'package:plumbus/core/translations/app_translations.dart';

class LoginBloc extends Cubit<LoginState> {
  LoginBloc() : super(const InitialState());

  void onLoginPressed({
    required BuildContext context,
    required String user,
    required String password,
    required int company,
  }) async {
    emit(const LoadingState());

    final credential = LoginCredentialEntity(
      user: user,
      password: password,
      company: company,
    );

    if (!credential.isValidUser) {
      return emit(FailureState(InvalidUserFailure(
        AppTranslations.translate('invalid_user'),
      )));
    }

    if (!credential.isValidPassword) {
      return emit(FailureState(InvalidPasswordFailure(
        AppTranslations.translate('invalid_password'),
      )));
    }

    if (!credential.isValidCompany) {
      return emit(FailureState(InvalidCompanyFailure(
        AppTranslations.translate('invalid_company'),
      )));
    }

    final repository = DependencyInjector.get<IAuthRepository>();

    var result = await repository.login(credential);

    if (result.isSuccess() && !result.tryGetSuccess()!.ativo) {
      return emit(FailureState(
        InactiveUserFailure(
          AppTranslations.translate('inactive_user'),
        ),
      ));
    }

    if (result.isSuccess()) {
      final loggedUserRepository = DependencyInjector.get<ISessionRepository>();
      await loggedUserRepository.setLoggedUser(result.tryGetSuccess()!);
    }

    result.when((r) {
      emit(SuccessState(r));
      context.read<AuthBloc>().onLoggedIn(usuario: r);
    }, (l) {
      emit(FailureState(l));
    });
  }

  void onLoginReset() async {
    emit(const InitialState());
  }
}

sealed class LoginState {}

class InitialState implements LoginState {
  const InitialState();
}

class LoadingState implements LoginState {
  const LoadingState();
}

class SuccessState implements LoginState {
  final UsuarioEntity usuario;

  const SuccessState(this.usuario);
}

class FailureState implements LoginState {
  final AuthFailure error;

  const FailureState(this.error);
}