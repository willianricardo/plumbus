import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plumbus/app/domain/entities/usuario_entity.dart';
import 'package:plumbus/app/presentation/block/auth_bloc.dart';

class LoginSuccessWidget extends StatelessWidget {
  final UsuarioEntity usuario;

  const LoginSuccessWidget({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().onLoggedIn(usuario: usuario);
    return const SizedBox.shrink();
  }
}
