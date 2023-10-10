import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../constants.dart';
import '../../models/product.dart';
import '../../services/firebase_services.dart';
import '../product_from_field.dart';

class SubCategoryWidget extends StatefulWidget {
  final String categoryName;
  final String docId;
  const SubCategoryWidget(
    this.categoryName,
    this.docId,
  );

  @override
  _SubCategoryWidgetState createState() => _SubCategoryWidgetState();
}

class _SubCategoryWidgetState extends State<SubCategoryWidget> {
  FirebaseServices _services = FirebaseServices();
  final _formKey = GlobalKey<FormState>();

  var nameTextController = TextEditingController();
  var priceController = TextEditingController();
  String selectsubCategory = 'Topwear';
  TextEditingController imageUrlController = TextEditingController();
  List<String> imageUrls = [];
  void addImageUrl() {
    setState(() {
      String imageUrl = imageUrlController.text.trim();
      if (imageUrl.isNotEmpty) {
        imageUrls.add(imageUrl);
        imageUrlController.clear();
      }
    });
  }

  void removeImageUrl(int index) {
    setState(() {
      imageUrls.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Dialog(
        child: Form(
          key: _formKey,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    'Add Product in ${widget.categoryName}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyFormField(
                      inputFormatter: LengthLimitingTextInputFormatter(50),
                      controller: nameTextController,
                      hintText: 'Name',
                      data: Icons.person,
                      type: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Your Name';
                        }
                        return null;
                      }),
                  SizedBox(height: 26.0),
                  MyFormField(
                      inputFormatter: LengthLimitingTextInputFormatter(50),
                      controller: priceController,
                      hintText: 'Price',
                      data: Icons.person,
                      type: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Product Name';
                        }
                        return null;
                      }),
                  SizedBox(height: 26.0),
                  MyFormField(
                    controller: imageUrlController,
                    hintText: 'Image Url',
                    data: Icons.person,
                    inputFormatter: LengthLimitingTextInputFormatter(500),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: addImageUrl,
                    ),
                    type: TextInputType.name,
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return 'Enter Image Url';
                    //   }
                    //   return null;
                    // }
                  ),
                  SizedBox(height: 26.0),
                  Center(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: selectsubCategory,
                        borderRadius: BorderRadius.circular(8),
                        hint: Text(
                          'Select SubCat',
                          style: TextStyle(fontSize: 16),
                        ),
                        dropdownColor: textFieldFillColor,
                        focusColor: textFieldFillColor,
                        isExpanded: true,
                        items: [
                          for (String subCat in subCats.keys)
                            DropdownMenuItem(
                              child: Text(subCats[subCat]!),
                              value: subCat,
                            )
                        ],
                        onChanged: (value) => setState(
                          () {
                            selectsubCategory = value.toString();
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: imageUrls.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Image.network(
                              imageUrls[index],
                              fit: BoxFit.contain,
                              height: 200,
                              width: 150,
                            ),
                            IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  removeImageUrl(index);
                                }),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final alert = AlertDialog(
                          content: WillPopScope(
                            onWillPop: () async => false,
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: CircularProgressIndicator(
                                      color: kPrimaryColor,
                                      strokeWidth: 5,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Please wait while your product is being created",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                        showDialog(context: context, builder: (_) => alert);
                        createCategoriesAndProducts();
                      } else {
                        EasyLoading.showError('Fill all the details');
                      }
                    },
                    child: Text('Add Product'),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  void createCategoriesAndProducts() async {
    final itemsRef = FirebaseFirestore.instance.collection("products");
    final String documentId = itemsRef.doc().id;
    await itemsRef
        .doc(documentId)
        .set(Product(
          available: true,
          cat: widget.categoryName,
          subCat: selectsubCategory,
          createdAt: DateTime.now(),
          id: DateTime.now().millisecondsSinceEpoch,
          name: nameTextController.text,
          price: double.parse(priceController.text),
          images: imageUrls,
        ).toMap())
        .then((value) {
      final productRef = FirebaseFirestore.instance.collection("categories");
      productRef
          .doc(widget.docId)
          .collection('subcategories')
          .doc(selectsubCategory)
          .collection('items')
          .doc(documentId)
          .set(Product(
            available: true,
            cat: widget.categoryName,
            subCat: selectsubCategory,
            createdAt: DateTime.now(),
            id: DateTime.now().millisecondsSinceEpoch,
            name: nameTextController.text,
            price: double.parse(priceController.text),
            images: imageUrls,
          ).toMap());
    });
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
