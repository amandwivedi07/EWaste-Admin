import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class OrderServices {
  CollectionReference orders = FirebaseFirestore.instance.collection('orders');
  Future<DocumentReference> saveOrder(Map<String, dynamic> data) {
    var result = orders.add(data);
    return result;
  }

  Color? statusColor(DocumentSnapshot document) {
    if (document['orderStatus'] == 'Accepted') {
      return Colors.blueGrey[400];
    }
    if (document['orderStatus'] == 'Rejected') {
      return Colors.red;
    }
    if (document['orderStatus'] == 'Picked Up') {
      return Colors.pink[900];
    }

    if (document['orderStatus'] == 'On The way') {
      return Colors.purple[900];
    }
    if (document['orderStatus'] == 'Delivered') {
      return Colors.green;
    }
    return Colors.orange;
  }

  Icon statusIcon(DocumentSnapshot document) {
    if (document['orderStatus'] == 'Accepted') {
      return Icon(
        Icons.assignment_turned_in_outlined,
        color: statusColor(document),
      );
    }

    if (document['orderStatus'] == 'Picked Up') {
      return Icon(
        Icons.cases,
        color: statusColor(document),
      );
    }

    if (document['orderStatus'] == 'On the way') {
      return Icon(
        Icons.delivery_dining,
        color: statusColor(document),
      );
    }
    if (document['orderStatus'] == 'Delivered') {
      return Icon(
        Icons.shopping_bag_outlined,
        color: statusColor(document),
      );
    }
    return Icon(
      Icons.assignment_turned_in_outlined,
      color: statusColor(document),
    );
  }

  String statusComment(document) {
    if (document['orderStatus'] == 'Picked Up') {
      return ' Order is Picked by ${document['deliveryBoy']['name']}';
    }
    if (document['orderStatus'] == 'On the way') {
      return 'Your delivery person ${document['deliveryBoy']['name']} is on the way';
    }
    if (document['orderStatus'] == 'Delivered') {
      return 'Your order is now completed';
    }

    return 'Mr. ${document['deliveryBoy']['name']} is on the way to Pick your Order ';
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////
  Widget statusContainer(document, context) {
    if (document['deliveryBoy']['name'].length > 1) {
      return document['deliveryBoy']['image'] == null
          ? Container()
          : ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.network(document['deliveryBoy']['image']),
              ),
              title: Text(document['deliveryBoy']['name']),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      // launch('tel:${document['deliveryBoy']['phone']}');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(4)),
                      child: const Padding(
                        padding: EdgeInsets.only(
                            left: 8.0, right: 8, top: 2, bottom: 2),
                        child: Icon(Icons.phone_in_talk, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      // GeoPoint location = document['deliveryBoy']['location'];
                      // launchMap(location, document['deliveryBoy']['name']);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(4)),
                      child: const Padding(
                        padding: EdgeInsets.only(
                            left: 8.0, right: 8, top: 2, bottom: 2),
                        child:
                            Icon(CupertinoIcons.location, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
    }

    return Container();
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////

  showMyDialog(
    title,
    status,
    documentId,
    context,
  ) {
    OrderServices _orderServices = OrderServices();
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text('Are you Sure? '),
            actions: [
              TextButton(
                  child: Text(
                    'OK',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    EasyLoading.show(status: 'Updating status');

                    status == 'Accepted'
                        ? _orderServices
                            .updateOrderStatus(documentId, status)
                            .then((value) {
                            EasyLoading.showSuccess('Updated Successfully');
                          })
                        : _orderServices
                            .updateOrderStatus(documentId, status)
                            .then((value) {
                            EasyLoading.showSuccess('Updated Successfully');
                          });
                    Navigator.pop(context);
                  }),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          );
        });
  }

  Future<void> updateOrderStatus(documentId, status) {
    var result = orders.doc(documentId).update({'orderStatus': status});
    return result;
  }
}
