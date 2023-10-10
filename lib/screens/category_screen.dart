import 'package:flutter/material.dart';

import '../widget/category/category_list_widget.dart';

class CategoryScreen extends StatelessWidget {
  static const String id = 'category';
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              Divider(
                thickness: 5,
              ),
              Divider(
                thickness: 5,
              ),
              Divider(
                thickness: 5,
              ),
              CategoryListWidget(),
            ],
          ),
        ),
      ),
    );

    //    Column(
    //       mainAxisAlignment: MainAxisAlignment.end,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         const Center(
    //           child: Text(
    //             'Categories',
    //             style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
    //           ),
    //         ),

    //         // Row(
    //         //   children: [
    //         //     _rowHeader(flex: 1, text: 'SN'),
    //         //     _rowHeader(flex: 1, text: 'Component Name'),
    //         //     _rowHeader(flex: 1, text: 'Listing Status'),
    //         //     _rowHeader(flex: 1, text: 'Created At'),
    //         //     _rowHeader(flex: 1, text: 'View More'),
    //         //   ],
    //         // ),
    //         // const ListingData()
    //       ]),
    // );
  }

  // void createCategoriesAndProducts() async {
  //   final CollectionReference categoriesCollection =
  //       FirebaseFirestore.instance.collection('categories');

  //   DocumentReference menCategoryDocRef =
  //       await categoriesCollection.add({'name': 'Men'});
  //   final menCategoryCollection = menCategoryDocRef.collection('subcategories');

  //   // Add products to 'men' subcategories
  //   final menTopWearCollection =
  //       menCategoryCollection.doc('topWear').collection('products');
  //   await menTopWearCollection.add(Product(
  //     cat: '',
  //     subCat: '',
  //     createdAt: DateTime.now(),
  //     id: DateTime.now().millisecondsSinceEpoch,
  //     name: 'Product 1',
  //     price: 29.99,
  //     images: ['image1.jpg'],
  //   ).toMap());
  //   await menTopWearCollection.add(Product(
  //           cat: '',
  //           subCat: '',
  //           name: 'Product 2',
  //           price: 39.99,
  //           images: ['image2.jpg'],
  //           createdAt: DateTime.now(),
  //           id: DateTime.now().millisecondsSinceEpoch)
  //       .toMap());
  // }

  // void createCategories() async {
  //   final CollectionReference categoriesCollection =
  //       FirebaseFirestore.instance.collection('categories');

  //   // Create 'men' category
  //   DocumentReference menCategoryDocRef =
  //       await categoriesCollection.add({'name': 'Men'});
  //   final menCategoryCollection = menCategoryDocRef.collection('subcategories');
  //   await menCategoryCollection.doc('topWear').set({'name': 'Top Wear'});
  //   await menCategoryCollection.doc('bottomWear').set({'name': 'Bottom Wear'});
  //   await menCategoryCollection.doc('sweatshirt').set({'name': 'Sweatshirt'});
  //   await menCategoryCollection.doc('joggers').set({'name': 'Joggers'});

  //   // Create 'women' category
  //   DocumentReference womenCategoryDocRef =
  //       await categoriesCollection.add({'name': 'Women'});
  //   final womenCategoryCollection =
  //       womenCategoryDocRef.collection('subcategories');
  //   await womenCategoryCollection.doc('topWear').set({'name': 'Top Wear'});
  //   await womenCategoryCollection
  //       .doc('bottomWear')
  //       .set({'name': 'Bottom Wear'});
  //   await womenCategoryCollection.doc('sweatshirt').set({'name': 'Sweatshirt'});
  //   await womenCategoryCollection.doc('joggers').set({'name': 'Joggers'});

  //   // Create 'boys' category
  //   DocumentReference boysCategoryDocRef =
  //       await categoriesCollection.add({'name': 'Boys'});
  //   final boysCategoryCollection =
  //       boysCategoryDocRef.collection('subcategories');
  //   await boysCategoryCollection.doc('topWear').set({'name': 'Top Wear'});
  //   await boysCategoryCollection.doc('bottomWear').set({'name': 'Bottom Wear'});
  //   await boysCategoryCollection.doc('sweatshirt').set({'name': 'Sweatshirt'});
  //   await boysCategoryCollection.doc('joggers').set({'name': 'Joggers'});

  //   // Create 'girls' category
  //   DocumentReference girlsCategoryDocRef =
  //       await categoriesCollection.add({'name': 'Girls'});
  //   final girlsCategoryCollection =
  //       girlsCategoryDocRef.collection('subcategories');
  //   await girlsCategoryCollection.doc('topWear').set({'name': 'Top Wear'});
  //   await girlsCategoryCollection
  //       .doc('bottomWear')
  //       .set({'name': 'Bottom Wear'});
  //   await girlsCategoryCollection.doc('sweatshirt').set({'name': 'Sweatshirt'});
  //   await girlsCategoryCollection.doc('joggers').set({'name': 'Joggers'});

  //   print('Categories and subcategories created successfully!');
  // }

  Widget _rowHeader({int? flex, String? text}) {
    return Expanded(
      flex: flex!,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade500),
            color: Colors.grey.shade400),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            text!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
