import 'package:auvnet/features/products/data/models/product_model.dart';

abstract class ProductRepo {
  Future<List<ProductModel>> getProducts();
}