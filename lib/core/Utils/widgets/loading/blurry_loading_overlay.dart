import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:commerce_app/core/utils/widgets/loading/app_loading_indicator.dart';

class BlurryLoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const BlurryLoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: Container(
              color: Colors.black.withAlpha(50),
              child: const Center(
                child: AppLoadingIndicator(),
              ),
            ),
          ),
      ],
    );
  }
}
