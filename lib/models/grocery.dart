class Grocery {
  final int id;
  final String name;
  final String imageUrl;
  final String description;

  Grocery({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.description = '',
  });

  factory Grocery.fromJson(Map<String, dynamic> json) {
    return Grocery(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['gname'] as String? ?? json['name'] as String? ?? '',
      imageUrl: json['image'] as String? ?? json['imageUrl'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );
  }
}
