import 'package:cloud_firestore/cloud_firestore.dart';

class Vendors {
  String? Email;
  String? vendorUid;
  Timestamp? time;
  String? phone;
  bool? accVerified;
  bool? isShopOpen;
  String? address;
  String? shopName;
double? todaysEarnings;
  String? taxRegistered;
  bool? isTopPicked;
  // bool? popularChoice;
  String? vendorAvatarUrl;
  String? GSTNumber;

  Vendors(
      {this.Email,
      this.shopName,
      this.vendorUid,
      this.phone,
      this.accVerified,
      this.isShopOpen,
      this.address,
      // this.location,
      this.taxRegistered,
      this.isTopPicked,
      // this.popularChoice,
      this.vendorAvatarUrl,
      this.time,
        this.todaysEarnings,
      this.GSTNumber});

  Vendors.fromJson(Map<String, dynamic> json) {
    Email = json['Email'];
    vendorUid = json['vendorUid'];
    phone = json['phone'];
    shopName = json['shopName'];
    taxRegistered = json['taxRegistered'];
    // publishedDate = json['publishedDate'];
    vendorAvatarUrl = json['vendorAvatarUrl'];
  todaysEarnings = json['todaysEarnings'] as double;
    address = json['address'];
    isTopPicked = json['isTopPicked'] as bool;
    accVerified = json['accVerified'] as bool;
    isShopOpen = json['isShopOpen'] as bool;
    // popularChoice = json['accVerified'] as bool;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['shopName'] = shopName;
    data['vendorUid'] = vendorUid;
    data['address'] = address;
    data['phone'] = phone;
    data['taxRegistered'] = taxRegistered;
    data['time'] = time;
    data['accVerified'] = accVerified;
    data['GSTNumber'] = GSTNumber;
    data['isTopPicked'] = isTopPicked;
    data['isShopOpen'] = isShopOpen;
    data['todaysEarnings']= todaysEarnings;

    return data;
  }
}
