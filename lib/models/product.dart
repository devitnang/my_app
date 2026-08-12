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
