import 'package:auvnet/features/products/data/models/product_model.dart';
import 'package:auvnet/features/products/domain/repo/product_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductRepoImpl implements ProductRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final querySnapshot = await _firestore.collection('products').get();
      return querySnapshot.docs.map((doc) {
        return ProductModel.fromMap(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}