class BrandModel {
  final int? results;
  final BrandMetadata? metadata;
  final List<BrandData>? data;

  BrandModel({
    this.results,
    this.metadata,
    this.data,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      results: json['results'],
      metadata: json['metadata'] != null
          ? BrandMetadata.fromJson(json['metadata'])
          : null,
      data: json['data'] != null
          ? (json['data'] as List).map((i) => BrandData.fromJson(i)).toList()
          : null,
    );
  }
}

class BrandMetadata {
  final int? currentPage;
  final int? numberOfPages;
  final int? limit;
  final int? nextPage;

  BrandMetadata({
    this.currentPage,
    this.numberOfPages,
    this.limit,
    this.nextPage,
  });

  factory BrandMetadata.fromJson(Map<String, dynamic> json) {
    return BrandMetadata(
      currentPage: json['currentPage'],
      numberOfPages: json['numberOfPages'],
      limit: json['limit'],
      nextPage: json['nextPage'],
    );
  }
}

class BrandData {
  final String? id;
  final String? name;
  final String? slug;
  final String? image;

  BrandData({
    this.id,
    this.name,
    this.slug,
    this.image,
  });

  factory BrandData.fromJson(Map<String, dynamic> json) {
    return BrandData(
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
