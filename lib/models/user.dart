import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? name;
  String? userUid;
  Timestamp? time;
  String? phone;
  String? userRole;
  String? address;

  User({
    this.name,
    this.userUid,
    this.phone,
    this.address,
    this.time,
    this.userRole,
  });

  User.fromJson(Map<String, dynamic> json) {
    userUid = json['userId'] ?? '';
    phone = json['phone'] ?? '';
    name = json['name'] ?? '';
    time = json['createdAt'] ?? '';
    address = json['address'] ?? '';
    userRole = json['role'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['userId'] = userUid;
    data['address'] = address;
    data['phone'] = phone;
    data['createdAt'] = time;
    data['role'] = userRole;
    return data;
  }
}
