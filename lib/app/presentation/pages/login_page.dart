import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plumbus/app/presentation/block/login_bloc.dart';
import 'package:plumbus/core/theme/app_colors.dart';
import 'package:plumbus/core/theme/app_images.dart';
import 'package:plumbus/core/translations/app_translations.dart';

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
  Future<void> _login() async {
    context.read<LoginBloc>().onLoginPressed(
          context: context,
          user: 'MM',
          password: 'MM',
          company: 1,
        );
  }

  Future<void> _tryAgain() async {
    context.read<LoginBloc>().onLoginReset();
  }

  _buildInitialState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 250,
          child: TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              backgroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              elevation: 1,
            ),
            onPressed: _login,
            child: Text(
              AppTranslations.translate('login'),
              style: const TextStyle(
                color: AppColors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  _buildFailureState(message) {
    return Center(
      child: Column(
        children: [
          Text(message),
          TextButton(
            onPressed: () {
              _tryAgain();
            },
            child: Text(
              AppTranslations.translate('try_again'),
            ),
          ),
        ],
      ),
    );
  }

  _buildSuccessState() {
    return Container();
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
                          InitialState() => _buildInitialState(),
                          LoadingState() => _buildLoadingState(),
                          SuccessState() => _buildSuccessState(),
                          FailureState(error: final error) =>
                            _buildFailureState(error.message),
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
