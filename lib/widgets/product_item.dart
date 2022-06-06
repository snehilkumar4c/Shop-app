// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

import '../screens/product_detail_screen.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  // const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: GridTile(
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
            footer: GridTileBar(
              leading: Consumer<Product>(
                builder: (ctx, product, child) => IconButton(
                  icon: Icon(
                    product.isFavourite
                        ? Icons.favorite
                        : Icons.favorite_border,
                  ),
                  onPressed: () {
                    product.toggleFavouriteStatus();
                  },
                  color: Theme.of(context).accentColor,
                ),
              ),
              backgroundColor: Colors.black87,
              title: Text(
                product.title,
                textAlign: TextAlign.center,
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                ),
                onPressed: () {
                  cart.addItem(
                    product.id,
                    product.title,
                    product.price,
                  );
                  Scaffold.of(context).hideCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Added Item to Cart'),
                      duration: Duration(
                        seconds: 2,
                      ),
                      action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () {
                          cart.removesingleItem(product.id);
                        },
                      ),
                    ),
                  );
                },
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
