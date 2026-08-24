  import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/services/network_service/remote/base_client_service.dart';
import 'package:commerce_app/core/services/network_service/remote/endpoints.dart';
import 'package:commerce_app/core/services/network_service/remote/api_error_handler.dart';
import 'package:commerce_app/features/reviews/models/review_model.dart';
import 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  final ApiService _apiService;

  ReviewsCubit(this._apiService) : super(ReviewsInitial());

  Future<void> getProductReviews(String productId) async {
    emit(ReviewsLoading());
    try {
      final response = await _apiService.getData(
        endpoint: Endpoints.reviews,
        query: {
          'product': productId,
        },
      );

      final reviewModel = ReviewModel.fromJson(response.data);
      final List<ReviewData> reviews = reviewModel.data ?? [];

      final int total = reviews.length;
      final Map<int, int> counts = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
      num totalRatingsSum = 0;

      for (var review in reviews) {
        final int rating = (review.ratings ?? 0).round();
        if (counts.containsKey(rating)) {
          counts[rating] = counts[rating]! + 1;
        }
        totalRatingsSum += review.ratings ?? 0;
      }

      final Map<int, double> percentages = {};
      counts.forEach((stars, count) {
        percentages[stars] = total == 0 ? 0.0 : (count / total);
      });

      final average = total == 0 ? 0.0 : totalRatingsSum / total;

      emit(ReviewsSuccess(
        reviews: reviews,
        ratingPercentages: percentages,
        averageRating: average,
        totalReviews: total,
      ));
    } catch (e) {
      emit(ReviewsError(ApiErrorHandler.getMessage(e)));
    }
  }
}
