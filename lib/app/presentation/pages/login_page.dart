import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plumbus/app/presentation/block/login_bloc.dart';
import 'package:plumbus/app/presentation/components/login_form_widget.dart';
import 'package:plumbus/app/presentation/components/login_success_widget.dart';
import 'package:plumbus/core/components/loading_widget.dart';
import 'package:plumbus/core/components/try_again_widget.dart';
import 'package:plumbus/core/theme/app_colors.dart';
import 'package:plumbus/core/theme/app_images.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => LoginBloc(),
        child: const LoginView(),
      ),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  _onTryAgain() {
    context.read<LoginBloc>().onLoginReset();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.36,
              color: AppColors.primary,
            ),
            Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: Image.asset(
                AppImages.person,
                width: 208,
                height: 300,
              ),
            ),
            Positioned(
              bottom: size.height * 0.10,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return switch (state) {
                          InitialState() => const LoginFormWidget(),
                          LoadingState() => const LoadingWidget(),
                          SuccessState(usuario: final usuario) =>
                            LoginSuccessWidget(
                              usuario: usuario,
                            ),
                          FailureState(error: final error) => TryAgainWidget(
                              message: error.message,
                              onTryAgain: _onTryAgain,
                            ),
                        };
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
