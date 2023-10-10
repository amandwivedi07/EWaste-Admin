import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../services/firebase_services.dart';
import 'category_card_widget.dart';

class CategoryListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseServices _services = FirebaseServices();
    return StreamBuilder(
      stream: _services.category.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Something went Wrong'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Wrap(
          direction: Axis.horizontal,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 22.0, vertical: 22),
              child: CategoryCard(document),
            );
          }).toList(),
        );
      },
    );
  }
}
