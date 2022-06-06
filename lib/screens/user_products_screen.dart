import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop/widgets/user_product_item.dart';

import '../providers/products_providers.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  // const UserProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (_, i) => UserProductItem(
            productData.items[i].title,
            productData.items[i].imageUrl,
          ),
          itemCount: productData.items.length,
        ),
      ),
    );
  }
}
