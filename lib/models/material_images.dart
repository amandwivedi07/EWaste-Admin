import 'package:cloud_firestore/cloud_firestore.dart';

class MaterialImage {
  String image;
  GeoPoint? location;

  MaterialImage({
    required this.image,
    this.location,
  });

  factory MaterialImage.fromMap(Map map) {
    return MaterialImage(
      image: map['image'],
      location: map['location'],
    );
  }

  Map toMap() {
    return {
      'image': image,
      if (location != null)
        'location': {
          'latitude': location!.latitude,
          'longitude': location!.longitude,
        },
    };
  }
}
