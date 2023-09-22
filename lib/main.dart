import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plumbus/app/presentation/block/auth_bloc.dart';
import 'package:plumbus/app/presentation/pages/login_page.dart';
import 'package:plumbus/app/presentation/pages/produto_page.dart';
import 'package:plumbus/app/presentation/pages/splash_page.dart';
import 'package:plumbus/core/dependency_injection/dependency_injector.dart';
import 'package:plumbus/core/environments/app_environment.dart';
import 'package:plumbus/core/theme/app_theme.dart';
import 'package:plumbus/core/translations/app_translations.dart';

void main() async {
  await _init();
  runApp(const Plumbus());
}

Future<void> _init() async {
  await AppEnvironments.load();
  AppTranslations.load();
  DependencyInjector.load();

  WidgetsFlutterBinding.ensureInitialized();
}

class Plumbus extends StatefulWidget {
  const Plumbus({Key? key}) : super(key: key);

  @override
  State<Plumbus> createState() => _PlumbusState();
}

class _PlumbusState extends State<Plumbus> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (_) => AuthBloc(),
      child: const PlumbusView(),
    );
  }
}

class PlumbusView extends StatefulWidget {
  const PlumbusView({Key? key}) : super(key: key);

  @override
  State<PlumbusView> createState() => _PlumbusViewState();
}

class _PlumbusViewState extends State<PlumbusView> {
  @override
  initState() {
    super.initState();
    context.read<AuthBloc>().onStart();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      localizationsDelegates: AppTranslations.localizationsDelegates,
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (BuildContext context, AuthState state) {
          return switch (state) {
            UninitializedState() => const SplashPage(),
            AuthenticatedState() => const ProdutoPage(),
            UnauthenticatedState() => const LoginPage(),
          };
        },
      ),
    );
  }
}
