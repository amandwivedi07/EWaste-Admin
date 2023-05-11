import 'package:cloud_firestore/cloud_firestore.dart';

class Riders {
  String? name;
  String? riderUid;
  Timestamp? time;
  String? phone;
  bool? accVerified;
  String? address;

  Riders({
    this.name,
    this.riderUid,
    this.time,
    this.phone,
    this.accVerified,
    this.address,
  });

  Riders.fromJson(Map<String, dynamic> json) {
    riderUid = json['riderUid'];
    phone = json['riderPhone'];
    name = json['riderName'];
    time = json['createdAt'];

    address = json['riderAddress'];
    accVerified = json['accVerified'] as bool;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['riderName'] = name;

    data['riderUid'] = riderUid;
    data['riderAddress'] = address;
    data['riderPhone'] = phone;
    data['createdAt'] = time;
    data['accVerified'] = accVerified;

    return data;
  }
}
