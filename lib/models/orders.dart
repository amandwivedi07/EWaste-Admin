import 'package:cloud_firestore/cloud_firestore.dart';

class Orders {
  String? userName;
  String? sellerId;
  String? shopName;
  String? userId;
  String? orderStatus;
  double? total;
  String? orderTime;
  int ? orderId;

  Orders(
      {this.orderTime,
      this.orderId,
      this.orderStatus,
      this.userName,
      this.shopName,
      this.sellerId,
      this.total});

  Orders.fromJson(Map<String, dynamic> json) {
    sellerId = json['seller']['sellerId'];
    shopName = json['seller']['shopName'];
    total = json['total'];
    orderId = json['orderId'];

    orderTime = json['timeStamp'];
    orderStatus = json['orderStatus'];
    userName = json['userName'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['sellerId'] = sellerId;

    data['shopName'] = shopName;
    data['total'] = total;
    data['orderId'] = orderId;
    data['timeStamp'] = orderTime;
    data['userName'] = userName;
    data['userId'] = userId;
    data['orderStatus'] = orderStatus;

    return data;
  }
}
