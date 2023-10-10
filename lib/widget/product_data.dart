import 'dart:math';

import 'package:admin/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/items.dart';

class ProductData extends StatefulWidget {
  const ProductData({Key? key}) : super(key: key);

  @override
  State<ProductData> createState() => _ProductDataState();
}

class _ProductDataState extends State<ProductData> {
  @override
  Widget build(BuildContext context) {
    String catId;
    FirebaseServices _services = FirebaseServices();
    return StreamBuilder<QuerySnapshot>(
        stream: _services.products
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print(e.toString());
            return const Text('Something went Wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator();
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              // Map<String, dynamic> data =
              //     snapshot.data!.docs[index].data() as Map<String, dynamic>;
              Items items = Items.fromDoc(snapshot.data!.docs[index]);

              return Row(
                children: [
                  _userData(flex: 1, widget: Text((index + 1).toString())),
                  _userData(
                      widget: Image.network(
                        items.images![0],
                        fit: BoxFit.contain,
                        // height: 200,
                        // width: 150,
                      ),
                      flex: 2,
                      text: items.images![0]),
                  _userData(flex: 1, text: items.name),
                  _userData(flex: 1, text: items.cat),
                  _userData(flex: 1, text: items.subCat),
                  _userData(
                      flex: 1,
                      widget: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          onPressed: () async {
                            deleteProductItem(
                                id: snapshot.data!.docs[index].id);
                            if (items.cat == 'Men') {
                              catId = "tjb89aVfgoey23hn7PP1";
                            } else if (items.cat == 'Women') {
                              catId = "NHm74mVCsetP5lm77bIO";
                            } else if (items.cat == 'Boys') {
                              catId = "vMigggzKuN3GqObplBFg";
                            } else {
                              catId = "EuWRrOHFucMgq35wTRs9";
                            }
                            setState(() {});

                            await deleteCatItem(
                                id: snapshot.data!.docs[index].id,
                                catId: catId,
                                subCatName: items.subCat);
                          },
                          child: const Text(
                            'Delete',
                            textAlign: TextAlign.center,
                          ))),
                ],
              );
            },
          );
        });
  }

  deleteProductItem({id}) async {
    CollectionReference deleteProductItems =
        FirebaseFirestore.instance.collection("products");
    return deleteProductItems.doc(id).delete();
  }

  deleteCatItem({id, catId, subCatName}) async {
    CollectionReference deleteCatItems = FirebaseFirestore.instance
        .collection("categories")
        .doc(catId)
        .collection('subcategories')
        .doc(subCatName)
        .collection("items");
    return deleteCatItems.doc(id).delete();
  }

  Widget _userData({int? flex, String? text, Widget? widget}) {
    return Expanded(
      flex: flex!,
      child: Container(
        // width: 80,
        height: 70,
        decoration:
            BoxDecoration(border: Border.all(color: Colors.grey.shade400)),
        child: Padding(
            padding: const EdgeInsets.all(4), child: widget ?? Text(text!)),
      ),
    );
  }
}
