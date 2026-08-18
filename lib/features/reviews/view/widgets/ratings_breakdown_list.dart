import 'package:commerce_app/core/utils/constants/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RatingsBreakdownList extends StatelessWidget {
  final Map<int, double> percentages;

  const RatingsBreakdownList({super.key, required this.percentages});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [5, 4, 3, 2, 1].map((stars) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              SizedBox(
                width: 120,
                child: Row(
                  spacing: 5,
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(5, (index) {
                    final isFilled = index < stars;
                    return Padding(
                      padding: const EdgeInsets.only(right: 2.0),
                      child: SvgPicture.asset(
                        isFilled
                            ? 'assets/images/imgs/star_gold.svg'
                            : 'assets/images/imgs/star_grey.svg',
                        width: 16,
                        height: 16,
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: percentages[stars] ?? 0.0,
                    backgroundColor: AppColors.greyFFE6E6E6,
                    color: AppColors.black1A1A1A,
                    minHeight: 5,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
