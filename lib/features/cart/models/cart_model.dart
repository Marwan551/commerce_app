class CartModel {
  final String? status;
  final int? numOfCartItems;
  final CartData? data;

  CartModel({this.status, this.numOfCartItems, this.data});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      status: json['status'],
      numOfCartItems: json['numOfCartItems'],
      data: json['data'] != null ? CartData.fromJson(json['data']) : null,
    );
  }
}

class CartData {
  final String? id;
  final String? cartOwner;
  final List<CartProduct>? products;
  final num? totalCartPrice;

  CartData({this.id, this.cartOwner, this.products, this.totalCartPrice});

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      id: json['_id'],
      cartOwner: json['cartOwner'],
      products: json['products'] != null
          ? (json['products'] as List).map((i) => CartProduct.fromJson(i)).toList()
          : null,
      totalCartPrice: json['totalCartPrice'],
    );
  }
}

class CartProduct {
  final int? count;
  final String? id;
  final CartInnerProduct? product;
  final num? price;

  CartProduct({this.count, this.id, this.product, this.price});

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      count: json['count'],
      id: json['_id'],
      product: json['product'] != null ? CartInnerProduct.fromJson(json['product']) : null,
      price: json['price'],
    );
  }
}

class CartInnerProduct {
  final String? id;
  final String? title;
  final String? imageCover;
  final num? price;

  CartInnerProduct({this.id, this.title, this.imageCover, this.price});

  factory CartInnerProduct.fromJson(Map<String, dynamic> json) {
    return CartInnerProduct(
      id: json['id'] ?? json['_id'],
      title: json['title'],
      imageCover: json['imageCover'],
      price: json['price'],
    );
  }
}
