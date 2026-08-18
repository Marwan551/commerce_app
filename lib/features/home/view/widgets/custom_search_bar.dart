import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:commerce_app/core/utils/constants/strings/app_strings.dart';

class CustomSearchBar extends StatelessWidget {
  final void Function(String) onSearchChanged;
  final VoidCallback onFilterTap;

  const CustomSearchBar({
    super.key,
    required this.onSearchChanged,
    required this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: AppStrings.searchHint,
              hintStyle: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodyMedium?.color?.withAlpha(150),
              ),
              prefixIcon: Icon(Icons.search,
                  color: theme.colorScheme.primary, size: 28),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: theme.colorScheme.secondary),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: theme.colorScheme.secondary),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        InkWell(
          onTap: onFilterTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset(
              'assets/images/imgs/Filter.svg',
              colorFilter:
                  ColorFilter.mode(theme.colorScheme.onPrimary, BlendMode.srcIn),
            ),
          ),
        ),
      ],
    );
  }
}
