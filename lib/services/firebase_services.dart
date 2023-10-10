import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseServices {
  CollectionReference category =
      FirebaseFirestore.instance.collection('categories');
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  CollectionReference listing =
      FirebaseFirestore.instance.collection('listing');
  CollectionReference orders = FirebaseFirestore.instance.collection('orders');
  CollectionReference riders = FirebaseFirestore.instance.collection('riders');
  CollectionReference cart = FirebaseFirestore.instance.collection('cart');

  Future<void> updateListing(
      {CollectionReference? reference,
      Map<String, dynamic>? data,
      String? docName}) {
    return reference!.doc(docName).update(data!);
  }

  Future<DocumentSnapshot> getCustomerDetails(id) async {
    DocumentSnapshot doc = await users.doc(id).get();
    return doc;
  }

  Future<DocumentSnapshot> getAdminCredentials(id) {
    var result = FirebaseFirestore.instance.collection('Admin').doc(id).get();
    return result;
  }

  Future<void> selectBoys(
      {orderId, location, name, image, phone, email, riderUid}) {
    var result = orders.doc(orderId).update({
      'deliveryBoy': {
        'riderUid': riderUid,
        'location': location,
        'name': name,
        'image': image,
        'phone': phone,
        'email': email
      },
      'riderLocation': location,
      'orderStatus': 'Rider Appointed'
    });
    return result;
  }

  Future<void> showMyDialog({title, message, context}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
