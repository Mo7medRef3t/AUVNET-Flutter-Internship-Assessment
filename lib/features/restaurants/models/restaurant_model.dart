class RestaurantModel {
  final String name;
  final String deliveryTime;
  final String imageUrl;

  RestaurantModel({
    required this.name,
    required this.deliveryTime,
    required this.imageUrl,
  });

  factory RestaurantModel.fromMap(Map<String, dynamic> map) {
    return RestaurantModel(
      name: map['name'] ?? '',
      deliveryTime: map['delivery_time'] ?? '',
      imageUrl: map['image_url'] ?? '',
    );
  }
}