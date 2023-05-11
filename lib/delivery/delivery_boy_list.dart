import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import '../services/firebase_services.dart';

class DeliveryBoysList extends StatefulWidget {
  final DocumentSnapshot document;
  String? sellerid;

  DeliveryBoysList(this.document, this.sellerid, {Key? key}) : super(key: key);
  @override
  _DeliveryBoysListState createState() => _DeliveryBoysListState();
}

class _DeliveryBoysListState extends State<DeliveryBoysList> {
  final FirebaseServices _services = FirebaseServices();
  // final OrderServices _orderServices = OrderServices();
  late GeoPoint _shopLocation;
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference vendors =
      FirebaseFirestore.instance.collection('vendors');

  Future<DocumentSnapshot> getShopDetails() async {
    DocumentSnapshot doc = await vendors.doc(widget.sellerid).get();
    return doc;
  }

  @override
  void initState() {
    getShopDetails().then((value) {
      if (value != null) {
        if (mounted) {
          setState(() {
            _shopLocation = value['location'];
          });
        }
      } else {}
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * .3,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBar(
                backgroundColor: Theme.of(context).primaryColor,
                title: const Text(
                  'Select Delivery Boy',
                  style: TextStyle(color: Colors.white),
                ),
                iconTheme: const IconThemeData(color: Colors.white),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: _services.riders
                    .where('accVerified', isEqualTo: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView(
                    shrinkWrap: true,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      GeoPoint location = document['location'];
                      double distanceInMeters = _shopLocation == null
                          ? 0.0
                          : Geolocator.distanceBetween(
                                  _shopLocation.latitude,
                                  _shopLocation.longitude,
                                  location.latitude,
                                  location.longitude) /
                              1000;
                      if (distanceInMeters > 500) {
                        return Container();
                        //  it will show only neared delivery boys
                      }

                      return Column(
                        children: [
                          ListTile(
                            onTap: () {
                              EasyLoading.show(status: 'Assigning Boys');
                              _services
                                  .selectBoys(
                                orderId: widget.document.id,
                                phone: document['phone'],
                                name: document['name'],
                                riderUid: document['riderUid'],
                                email: document['Email'],
                                location: document['location'],
                                image: document['riderAvatarUrl'],
                              )
                                  .then((value) {
                                EasyLoading.showSuccess(
                                    'Assigned Delivery Boy');
                                Navigator.pop(context);
                              });
                            },
                            leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Image.network(document['riderAvatarUrl']),
                            ),
                            title: Text(document['name']),
                            subtitle: Text(
                                '${distanceInMeters.toStringAsFixed(0)} Km'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      // GeoPoint location = document['location'];
                                      // _orderServices.launchMap(
                                      //     location, document['name']);
                                    },
                                    icon: Icon(
                                      CupertinoIcons.location,
                                      color: Theme.of(context).primaryColor,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      // launch('tel:${document['mobile']}');
                                    },
                                    icon: Icon(
                                      Icons.phone,
                                      color: Theme.of(context).primaryColor,
                                    )),
                              ],
                            ),
                          ),
                          const Divider(
                            height: 2,
                            color: Colors.grey,
                          )
                        ],
                      );
                    }).toList(),
                  );
                },
              )
            ],
          )),
    );
  }
}
