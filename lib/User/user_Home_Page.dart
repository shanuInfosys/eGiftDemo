import 'package:e_gift_shoppe/Database/Database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:e_gift_shoppe/DataBaseClasses/Products.dart';

class user_Home_Page extends StatefulWidget {
  const user_Home_Page({super.key});

  @override
  State<user_Home_Page> createState() => _user_Home_PageState();
}

class _user_Home_PageState extends State<user_Home_Page> {
  // Variable Declaration
  late List<Products> productList = [];
  int count = 0;

  @override
  initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My App'),
          //automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                logOutUser();
                // do something
              },
            )
          ],
        ),
        body: ListView.builder(
          //itemCount: productsData.length,
          itemCount: count,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(productList[index].name,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(
                      "${productList[index].details}\n${productList[index].quantity}\n${productList[index].price}"),
                  isThreeLine: true,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                        child: const Icon(
                          Icons.shopping_basket_outlined,
                          color: Colors.black,
                        ),
                        onTap: () {
                          //navigateToDetail(productList[index]);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }

  void updateListView() {
    Future<List<Products>> productListFuture = DBProvider.db.getAllProducts();
    productListFuture.then((productList) {
      setState(() {
        print("Product List = $productList");
        this.productList = productList;
        this.count = productList.length;
      });
    }, onError: (error) {
      print(error.toString());
    });
  }

  void logOutUser() {
    Navigator.pop(context, true);
  }
}
