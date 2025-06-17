class ProductModel {
  final String id;
  final String category;
  final String description;
  final String imageUrl;
  final String name;
  final num price;

  ProductModel({
    required this.id,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.name,
    required this.price,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map, String id) {
    return ProductModel(
      id: id,
      category: map['category'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      name: map['name'] ?? '',
      price: map['price'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'description': description,
      'imageUrl': imageUrl,
      'name': name,
      'price': price,
    };
  }
}