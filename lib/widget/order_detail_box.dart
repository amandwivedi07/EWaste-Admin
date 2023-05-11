import 'package:admin/services/firebase_services.dart';
import 'package:admin/services/order_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart';

class OrderDetailBox extends StatefulWidget {
  final String? userId;
  const OrderDetailBox({this.userId, Key? key}) : super(key: key);

  @override
  State<OrderDetailBox> createState() => _OrderDetailBoxState();
}

class _OrderDetailBoxState extends State<OrderDetailBox> {
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
    OrderServices _orderServices = OrderServices();

    return StreamBuilder<QuerySnapshot>(
        stream: _services.orders
            .where('userId', isEqualTo: widget.userId)
            .orderBy('timeStamp', descending: true)
            .snapshots(),
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
                          'No Orders Till Now',
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
                      width: MediaQuery.of(context).size.width * .4,
                      child: ListView.separated(
                        itemCount: snapshot.data!.size,
                        separatorBuilder: (context, index) {
                          return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: CircleAvatar(
                                radius: 6,
                                backgroundColor: Colors.grey.shade700,
                              ));
                        },
                        itemBuilder: (context, index) {
                          // Map<String, dynamic> data1 =
                          //     snapshot.data! as Map<String, dynamic>;
                          // var data = data1[index];
                          var data = snapshot.data!.docs[index];

                          // var surCharge = (snapshot.data!.docs[index].data()
                          //         as Map)['surCharge'] !=
                          null;
                          return Card(
                            elevation: 12,
                            child: Container(
                                color: Colors.white,
                                child: Column(children: [
                                  ListTile(
                                    horizontalTitleGap: 0,
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 14,
                                      child: _orderServices.statusIcon(
                                          snapshot.data!.docs[index]),
                                    ),
                                    title: Text(
                                      data['orderStatus'],
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: _orderServices.statusColor(
                                              snapshot.data!.docs[index]),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      'On ${DateFormat().format(DateTime.parse(data['timeStamp']))}',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    trailing: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Order Type : ${data['orderType']}',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Payment Type : ${data['cod'] == true ? 'Cash On delivery' : 'Paid Online'}',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Amount : ₹ ${data['total'].toStringAsFixed(0)}',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Customer Detail/////////////
                                  ListTile(
                                    contentPadding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Text("Customer : ",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(
                                              '${_customer!['Name']}',
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        data['customerMessage'] != ''
                                            ? Text(
                                                'Customer Message ${data['customerMessage']}',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold))
                                            : Text('')
                                      ],
                                    ),
                                    subtitle: Text(
                                      _customer!['address'],
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            // launch('tel:${_customer!['phone']}');
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
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
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          _customer!['phone'],
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Deivery Detail/////////////////////
                                  if (data['deliveryBoy']['name'].length > 2)
                                    // if (document['orderStatus'] == 'Delivery')
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: ListTile(
                                          tileColor: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(.3),
                                          leading: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            child: Image.network(
                                              data['deliveryBoy']['image'],
                                              height: 24,
                                            ),
                                          ),
                                          title: Text(
                                            data['deliveryBoy']['name'],
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                          subtitle: Text(
                                            _orderServices.statusComment(
                                                snapshot.data!.docs[index]),
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  // launch(
                                                  //     'tel:${document['deliveryBoy']['phone']}');
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  child: const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8.0,
                                                        right: 8,
                                                        top: 2,
                                                        bottom: 2),
                                                    child: Icon(
                                                        Icons.phone_in_talk,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                data['deliveryBoy']['phone'],
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ExpansionTile(
                                    title: const Text(
                                      'Order Details',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    ),
                                    subtitle: const Text('View order details',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey)),
                                    children: [
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return ListTile(
                                            leading: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              child: Image.network(
                                                  data['products'][index]
                                                      ['thumbnailUrl']),
                                            ),
                                            title: Text(data['products'][index]
                                                ['title']),
                                            subtitle: Text(
                                              '${data['products'][index]['qty']} x ${data['products'][index]['price'].toStringAsFixed(0)} = ${data['products'][index]['total'].toStringAsFixed(0)}',
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12),
                                            ),
                                          );
                                        },
                                        itemCount: data['products'].length,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0,
                                            bottom: 8,
                                            left: 12,
                                            right: 12),
                                        child: Card(
                                          elevation: 4,
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(.7),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    const Text(
                                                      'Seller :',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(
                                                      width: 7,
                                                    ),
                                                    Text(
                                                      data['seller']
                                                          ['shopName'],
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                if (int.parse(
                                                        data['discount']) >
                                                    0)
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          // ignore: prefer_const_constructors
                                                          Text(
                                                            'Discount :',
                                                            // ignore: prefer_const_constructors
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12),
                                                          ),
                                                          const SizedBox(
                                                            width: 7,
                                                          ),
                                                          Text(
                                                            '${data['discount']}',
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12),
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                            'Discount Code :',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12),
                                                          ),
                                                          const SizedBox(
                                                            width: 7,
                                                          ),
                                                          Text(
                                                            '${data['discountCode']}',
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                // if (snapshot.data!
                                                //         .docs()[index]
                                                //   )['surCharge']
                                                // .data()
                                                // .toString()
                                                // .contains('amount')
                                                // ? doc.get('amount')
                                                // : 0, //Number
                                                // data['surCharge'] > 0
                                                //     ?
                                                (snapshot.data!.docs[index]
                                                                .data() as Map)[
                                                            'surCharge'] !=
                                                        null
                                                    // data['surCharge'] > 0
                                                    ? Row(
                                                        children: [
                                                          const Text(
                                                            'Sur Charge :',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12),
                                                          ),
                                                          Text(
                                                            '${data['surCharge'] ?? 0}',
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12),
                                                          )
                                                        ],
                                                      )
                                                    : SizedBox(),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      'Delivery Fee :',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12),
                                                    ),
                                                    Text(
                                                      '${data['deliveryFee'].toString()}',
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ])),
                          );
                        },
                        // children: snapshot.data!.docs
                        //     .map((DocumentSnapshot document) {
                        //   Map<String, dynamic> data =
                        //       document.data()! as Map<String, dynamic>;
                        // }).toList(),
                      ))
                ],
              ),
            ),
          );
        });
  }

  void launchMap(GeoPoint location, name) async {
    final availableMaps = await MapLauncher.installedMaps;
    // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

    await availableMaps.first.showMarker(
      coords: Coords(location.latitude, location.longitude),
      title: name,
    );
  }
}
