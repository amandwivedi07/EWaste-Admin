import 'package:cloud_firestore/cloud_firestore.dart';

class Items {
  Timestamp? createdAt;
  int? id;
  String? name;
  double? price;
  List<String>? images;
  String? subCat;
  String? cat;

  Items({
    required this.createdAt,
    required this.id,
    required this.name,
    required this.price,
    required this.images,
    required this.subCat,
    required this.cat,
  });
  factory Items.fromDoc(DocumentSnapshot doc) {
    Map data = doc.data()! as Map;
    return Items(
      images: List<String>.from(data['images'] as List<dynamic>),
      createdAt: data['createdAt'],
      id: data['id'],
      name: data['name'],
      price: data['price'],
      subCat: data['subCat'],
      cat: data['cat'],
    );
  }
}
