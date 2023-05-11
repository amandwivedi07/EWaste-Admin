import 'package:admin/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartItemDetailBox extends StatefulWidget {
  final String? userId;
  final String? createdAt;
  const CartItemDetailBox(
      {required this.userId, required this.createdAt, Key? key})
      : super(key: key);

  @override
  State<CartItemDetailBox> createState() => _OrderDetailBoxState();
}

class _OrderDetailBoxState extends State<CartItemDetailBox> {
  @override
  final FirebaseServices _services = FirebaseServices();
  DocumentSnapshot? _customer;
  @override
  void initState() {
    _services.getCustomerDetails(widget.userId).then((value) {
      if (value != null) {
        setState(() {
          _customer = value;
        });
      } else {}
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseServices _services = FirebaseServices();

    return StreamBuilder<QuerySnapshot>(
        stream:
            _services.cart.doc(widget.userId).collection('items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something Went Wrong'),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.size == 0) {
            return Dialog(
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Stack(children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width * .3,
                        child: const Center(
                            child: Text(
                          'Order Placed',
                          style: TextStyle(fontSize: 26),
                        )),
                      )
                    ])));
          }

          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Stack(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width * .3,
                      child: ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;

                          return Column(children: [
                            // Customer Detail/////////////
                            ListTile(
                              contentPadding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              title: Row(
                                children: [
                                  const Text("Customer : ",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                    '${_customer!['Name']}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                _customer!['address'],
                                style: const TextStyle(fontSize: 14),
                                maxLines: 1,
                              ),
                              trailing: Column(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: const Padding(
                                          padding: EdgeInsets.only(
                                              left: 8.0,
                                              right: 8,
                                              top: 2,
                                              bottom: 2),
                                          child: Icon(Icons.phone_in_talk,
                                              color: Colors.white),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        _customer!['phone'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  if (widget.createdAt != null)
                                    Text(
                                      widget.createdAt!,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                    ),
                                ],
                              ),
                            ),

                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                var itemData = snapshot.data!.docs[index];
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Image.network(
                                      itemData['thumbnailUrl'],
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    itemData['title'],
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  subtitle: Text(
                                    '${itemData['qty']} x ${itemData['price'].toStringAsFixed(0)} = ${itemData['total'].toStringAsFixed(0)}',
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                );
                              },
                              itemCount: snapshot.data!.docs.length,
                            ),
                          ]);
                        }).toList(),
                      ))
                ],
              ),
            ),
          );
        });
  }
}
