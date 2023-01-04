import 'package:e_gift_shoppe/Database/Database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sqflite/sqflite.dart';

import '../DataBaseClasses/Products.dart';

class AddProduct extends StatefulWidget {
  final Products product;
  const AddProduct({super.key, required this.product});
  @override
  State<AddProduct> createState() {
    return _AddProductState(product);
  }
}

class _AddProductState extends State<AddProduct> {
  _AddProductState(this.product);
  // Local Variable declaration
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  Products product;
  @override
  Widget build(BuildContext context) {
    this.product = product;
    nameController.text = product.name;
    descController.text = product.details;
    priceController.text = product.price;
    quantityController.text = product.quantity;

    return Scaffold(
        appBar: AppBar(
          title: Text("Add Products"),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(10),
                    child: const Text(
                      "Add Product",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 20,
                      ),
                    )),
                SizedBox(height: 10, width: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Enter product name"),
                    onChanged: (value) {
                      updateName();
                    },
                  ),
                ),
                SizedBox(height: 10, width: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: descController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Enter product Desc"),
                    onChanged: (value) {
                      updateDetails();
                    },
                  ),
                ),
                SizedBox(height: 10, width: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: priceController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Enter product price"),
                    onChanged: (value) {
                      updatePrice();
                    },
                  ),
                ),
                SizedBox(height: 10, width: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: quantityController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Enter product quantity"),
                    onChanged: (value) {
                      updateQuantity();
                    },
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                      child: const Text("Submit"),
                      onPressed: () {
                        product.name = nameController.text;
                        product.details = descController.text;
                        product.price = priceController.text;
                        product.quantity = quantityController.text;
                        saveProductsIntoDataBase();
                      },
                    ),
                  ),
                )
              ],
            )));
  }

  saveProductsIntoDataBase() async {
    moveToLastScreen();
    Future<int?> result;

    if (product.id == 0) {
      product.id = product.id + 1;
      result = DBProvider.db.addNewProduct(product);
    } else {
      result = DBProvider.db.updateProducts(product);
    }
    if (result != 0) {
      showAlertDialog('status', 'Products saved successfully'); // Success
    } else {
      showAlertDialog('status', 'Problem saving Products '); // Failure
    }
  }

  // Updating Name
  void updateName() {
    product.name = nameController.text;
  }

  // Updating Details
  void updateDetails() {
    product.details = descController.text;
  }

  // Updating Price
  void updatePrice() {
    product.price = priceController.text;
  }

  // Updating Quantity
  void updateQuantity() {
    product.quantity = quantityController.text;
  }

  void showAlertDialog(String title, String message) {
    AlertDialog alertDialog =
        AlertDialog(title: Text(title), content: Text(message));
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }
}
