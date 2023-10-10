class Product {
  final DateTime createdAt;
  final int id;
  final String name;
  final double price;
  final List<String> images;
  final String subCat;
  final String cat;
  final bool available;

  Product(
      {required this.createdAt,
      required this.id,
      required this.name,
      required this.price,
      required this.images,
      required this.subCat,
      required this.cat,
      required this.available});

  Map<String, dynamic> toMap() {
    return {
      'itemId': id,
      'name': name,
      'price': price,
      'images': images,
      'createdAt': createdAt,
      'subCat': subCat,
      'cat': cat,
      'available': available
    };
  }
}
