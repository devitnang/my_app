class Product {
  int id;
  String name;
  String subtitle;
  String description;
  double price;
  String image;
  List<String> images;
  bool isFavorite;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.description,
    required this.price,
    required this.image,
    this.images = const [],
    this.isFavorite = false,
    this.quantity = 1,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['pname'] as String? ?? json['name'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      image: json['image'] as String? ?? '',
    );
  }

  void toggleFavorite() {
    isFavorite = !isFavorite;
  }

  void decreaseQty() {
    if (quantity > 1) quantity--;
  }

  void increaseQty() {
    quantity++;
  }
}
