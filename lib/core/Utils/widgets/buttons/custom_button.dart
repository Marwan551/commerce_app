import 'package:flutter/material.dart';
import 'package:commerce_app/core/utils/widgets/loading/app_loading_indicator.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.disabled)) {
                  return Theme.of(context).colorScheme.secondary;
                }
                return Theme.of(context).colorScheme.primary;
              }),
            ),
        child: isLoading
            ? AppLoadingIndicator(
                size: 24,
              )
            : Text(text),
      ),
    );
  }
}
