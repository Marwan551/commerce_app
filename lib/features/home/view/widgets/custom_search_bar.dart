import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:commerce_app/core/utils/constants/styles/app_text_styles.dart';

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
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: AppStrings.searchHint,
              hintStyle: AppTextStyles.regular14.copyWith(color: AppColors.grey707070),
              prefixIcon: const Icon(Icons.search, color: AppColors.black1A1A1A, size: 28),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.greyB3B3B3),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: AppColors.greyB3B3B3),
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
              color: AppColors.black1A1A1A,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset(
              'assets/images/imgs/Filter.svg',
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
        ),
      ],
    );
  }
}
