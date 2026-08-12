class CategoryModel {
  final int? results;
  final CategoryMetadata? metadata;
  final List<CategoryData>? data;

  CategoryModel({
    this.results,
    this.metadata,
    this.data,
  });

  factory CategoryModel.fromJson(Map<String,dynamic> json) {
    return CategoryModel(
      results: json['results'],
      metadata: json['metadata'] != null
          ? CategoryMetadata.fromJson(json['metadata'])
          : null,
      data: json['data'] != null
          ? (json['data'] as List).map((i) => CategoryData.fromJson(i)).toList()
          : null,
    );
  }
}

class CategoryMetadata {
  final int? currentPage;
  final int? numberOfPages;
  final int? limit;

  CategoryMetadata({
    this.currentPage,
    this.numberOfPages,
    this.limit,
  });

  factory CategoryMetadata.fromJson(Map<String, dynamic> json) {
    return CategoryMetadata(
      currentPage: json['currentPage'],
      numberOfPages: json['numberOfPages'],
      limit: json['limit'],
    );
  }
}

class CategoryData {
  final String? id;
  final String? name;
  final String? slug;
  final String? image;

  CategoryData({
    this.id,
    this.name,
    this.slug,
    this.image,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      id: json['_id'] ?? json['id'],
      name: json['name'],
      slug: json['slug'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'image': image,
    };
  }
}
