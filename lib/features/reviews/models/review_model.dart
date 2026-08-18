class ReviewModel {
  final int? results;
  final List<ReviewData>? data;

  ReviewModel({this.results, this.data});

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      results: json['results'],
      data: json['data'] != null
          ? (json['data'] as List).map((i) => ReviewData.fromJson(i)).toList()
          : null,
    );
  }
}

class ReviewData {
  final String? id;
  final String? comment;
  final ReviewUser? user;
  final num? ratings;
  final String? createdAt;

  ReviewData({this.id, this.comment, this.user, this.ratings, this.createdAt});

  factory ReviewData.fromJson(Map<String, dynamic> json) {
    return ReviewData(
      id: json['_id']?.toString() ?? json['id']?.toString(),
      comment: json['review']?.toString(),
      user: json['user'] != null ? ReviewUser.fromJson(json['user']) : null,
      ratings: num.tryParse(json['rating']?.toString() ?? '0') ?? 0,
      createdAt: json['createdAt']?.toString(),
    );
  }
}

class ReviewUser {
  final String? name;
  final String? email;

  ReviewUser({this.name, this.email});

  factory ReviewUser.fromJson(Map<String, dynamic> json) {
    return ReviewUser(
      name: json['name']?.toString() ?? 'Anonymous',
      email: json['email']?.toString(),
    );
  }
}
