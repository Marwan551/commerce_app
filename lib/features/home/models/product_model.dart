import 'dart:convert';
import 'category_model.dart';
import 'brand_model.dart';

class ProductModel {
  final int? results;
  final ProductMetadata? metadata;
  final List<ProductData>? data;

  ProductModel({this.results, this.metadata, this.data});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      results: json['results'],
      metadata: json['metadata'] != null ? ProductMetadata.fromJson(json['metadata']) : null,
      data: json['data'] != null
          ? (json['data'] as List).map((i) => ProductData.fromJson(i)).toList()
          : null,
    );
  }
}

class ProductMetadata {
  final int? currentPage;
  final int? numberOfPages;
  final int? limit;
  final int? nextPage;

  ProductMetadata({this.currentPage, this.numberOfPages, this.limit, this.nextPage});

  factory ProductMetadata.fromJson(Map<String, dynamic> json) {
    return ProductMetadata(
      currentPage: json['currentPage'],
      numberOfPages: json['numberOfPages'],
      limit: json['limit'],
      nextPage: json['nextPage'],
    );
  }
}

class ProductData {
  final String? id;
  final String? title;
  final String? slug;
  final String? description;
  final int? quantity;
  final num? price;
  final String? imageCover;
  final CategoryData? category;
  final BrandData? brand;
  final num? ratingsAverage;
  final List<String>? images;

  ProductData({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.quantity,
    this.price,
    this.imageCover,
    this.category,
    this.brand,
    this.ratingsAverage,
    this.images,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['_id'] ?? json['id'],
      title: json['title'],
      slug: json['slug'],
      description: json['description'],
      quantity: json['quantity'],
      price: json['price'],
      imageCover: json['imageCover'],
      category: json['category'] != null ? CategoryData.fromJson(json['category']) : null,
      brand: json['brand'] != null ? BrandData.fromJson(json['brand']) : null,
      ratingsAverage: json['ratingsAverage'],
      images: json['images'] != null ? List<String>.from(json['images']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'description': description,
      'quantity': quantity,
      'price': price,
      'imageCover': imageCover,
      'category': category?.toJson(),
      'brand': brand?.toJson(),
      'ratingsAverage': ratingsAverage,
      'images': images,
    };
  }

  Map<String, dynamic> toDb() {
    return {
      'productId': id,
      'productData': jsonEncode(toJson()),
      'isFavorite': 1,
    };
  }

  factory ProductData.fromDb(Map<String, dynamic> map) {
    return ProductData.fromJson(jsonDecode(map['productData']));
  }
}
