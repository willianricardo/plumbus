import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plumbus/app/presentation/block/login_bloc.dart';
import 'package:plumbus/core/theme/app_colors.dart';
import 'package:plumbus/core/translations/app_translations.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {
              context.read<LoginBloc>().onLoginPressed(
                    user: 'MM',
                    password: 'MM',
                    company: 1,
                  );
            },
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
}
