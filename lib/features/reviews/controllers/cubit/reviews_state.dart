import 'package:commerce_app/features/reviews/models/review_model.dart';

sealed class ReviewsState {}

final class ReviewsInitial extends ReviewsState {}

final class ReviewsLoading extends ReviewsState {}

final class ReviewsSuccess extends ReviewsState {
  final List<ReviewData> reviews;
  final Map<int, double> ratingPercentages;
  final num averageRating;
  final int totalReviews;

  ReviewsSuccess({
    required this.reviews,
    required this.ratingPercentages,
    required this.averageRating,
    required this.totalReviews,
  });
}

final class ReviewsError extends ReviewsState {
  final String message;
  ReviewsError(this.message);
}
