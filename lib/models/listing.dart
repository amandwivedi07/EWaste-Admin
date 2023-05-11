import 'package:cloud_firestore/cloud_firestore.dart';

import 'material_images.dart';

class Listing {
  String? componentName;
  String? listingStatus;
  String? userUid;
  String? materialType;
  Timestamp? time;
  String? phone;
  String? userRole;
  String? address;
  String? createdBy;
  List<MaterialImage>? images;

  Listing(
      {this.componentName,
      this.userUid,
      this.phone,
      this.address,
      this.time,
      this.images,
      this.listingStatus,
      this.userRole,
      this.createdBy,
      this.materialType});

  factory Listing.fromDoc(DocumentSnapshot doc) {
    Map data = doc.data()! as Map;
    return Listing(
      userUid: data['userId'] ?? '',
      createdBy: data['createdBy'] ?? '',
      materialType: data['materialType'] ?? '',
      componentName: data['componentName'],
      images: ((data['images'] ?? []) as List<dynamic>)
          .map((e) => MaterialImage.fromMap(e))
          .toList(),
      time: data['createdAt'] ?? Timestamp.fromDate(DateTime.now()),
      listingStatus: data['listingStatus'],
      userRole: data['userRole'] ?? '',
      address: data['address'] ?? '',
    );
  }
  // Listing.fromJson(Map<String, dynamic> json) {
  //   // images = ((json['images'] ?? []) as List<dynamic>)
  //   //     .map((e) => MaterialImage.fromMap(e))
  //   //     .toList();
  //   userUid = json['userId'] ?? '';
  //   listingStatus = json['listingStatus'];
  //   phone = json['phone'] ?? '';
  //   componentName = json['componentName'] ?? '';
  //   materialType = json['materialType'];
  //   time = json['createdAt'] ?? '';
  //   address = json['address'] ?? '';
  //   createdBy = json['materialType'];
  //   userRole = json['userrole'] ?? '';
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   data['componentName'] = componentName;
  //   data['userId'] = userUid;
  //   data['address'] = address;
  //   data['phone'] = phone;
  //   data['createdAt'] = time;
  //   data['role'] = userRole;
  //   data['createdBy'] = createdBy;
  //   data['materialType'] = materialType;

  //   return data;
  // }
}
