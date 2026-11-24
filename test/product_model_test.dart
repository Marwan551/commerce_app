import 'package:flutter_test/flutter_test.dart';
import 'package:commerce_app/features/home/models/product_model.dart';

void main() {
  group('ProductData API and local storage mapping', () {
    test('reads API _id and preserves decimal price and images', () {
      final product = ProductData.fromJson({
        '_id': 'p1',
        'title': 'Notebook',
        'price': 12.5,
        'images': ['front.png', 'back.png'],
      });
      expect(product.id, 'p1');
      expect(product.title, 'Notebook');
      expect(product.price, 12.5);
      expect(product.images, ['front.png', 'back.png']);
    });
    test('accepts local id fallback and absent optional nested fields', () {
      final product = ProductData.fromJson({'id': 'local-1'});
      expect(product.id, 'local-1');
      expect(product.category, isNull);
      expect(product.brand, isNull);
      expect(product.images, isNull);
    });
    test('API _id takes precedence over local id', () {
      expect(ProductData.fromJson({'_id': 'api', 'id': 'local'}).id, 'api');
    });
    test('round trips favorite data through database JSON', () {
      final original = ProductData(
        id: 'p2',
        title: 'Pen',
        price: 4,
        quantity: 7,
        images: ['pen.png'],
      );
      final row = original.toDb();
      final restored = ProductData.fromDb(row);
      expect(row['productId'], 'p2');
      expect(row['isFavorite'], 1);
      expect(restored.id, original.id);
      expect(restored.title, original.title);
      expect(restored.price, original.price);
      expect(restored.quantity, original.quantity);
      expect(restored.images, original.images);
    });
    test('reads product pagination metadata', () {
      final response = ProductModel.fromJson({
        'results': 1,
        'metadata': {
          'currentPage': 1,
          'numberOfPages': 3,
          'limit': 10,
          'nextPage': 2,
        },
        'data': [
          {'_id': 'p3'},
        ],
      });
      expect(response.results, 1);
      expect(response.metadata!.nextPage, 2);
      expect(response.data!.single.id, 'p3');
    });
  });
}
