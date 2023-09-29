import 'package:flutter/material.dart';
import 'package:plumbus/core/translations/app_translations.dart';

class TryAgainWidget extends StatelessWidget {
  final String message;
  final VoidCallback onTryAgain;

  const TryAgainWidget({
    super.key,
    required this.message,
    required this.onTryAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(message),
          TextButton(
            onPressed: onTryAgain,
            child: Text(
              AppTranslations.translate('try_again'),
            ),
          ),
        ],
      ),
    );
  }
}
