import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:commerce_app/core/services/database/sqflite_helper.dart';
import 'package:commerce_app/features/home/models/product_model.dart';
import 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final SqfliteHelper _dbHelper;

  WishlistCubit(this._dbHelper) : super(WishlistInitial());

  List<String> _wishlistIds = [];
  List<String> get wishlistIds => _wishlistIds;

  Future<void> getWishlist() async {
    emit(WishlistLoading());
    try {
      final List<Map<String, dynamic>> results = await _dbHelper.query('wishlist');
      final List<ProductData> items = results.map((e) => ProductData.fromDb(e)).toList();
      _wishlistIds = items.map((e) => e.id!).toList();
      emit(WishlistSuccess(items));
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  Future<void> toggleFavorite(ProductData product) async {
    try {
      final bool exists = await _dbHelper.isExists('wishlist', product.id!);
      if (exists) {
        await _dbHelper.delete('wishlist', product.id!);
        _wishlistIds.remove(product.id!);
      } else {
        await _dbHelper.insert('wishlist', product.toDb());
        _wishlistIds.add(product.id!);
      }
      getWishlist();
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  bool isFavorite(String productId) {
    return _wishlistIds.contains(productId);
  }

  Future<void> loadWishlistIds() async {
     final List<Map<String, dynamic>> results = await _dbHelper.query('wishlist');
     _wishlistIds = results.map((e) => e['productId'] as String).toList();
  }
}
