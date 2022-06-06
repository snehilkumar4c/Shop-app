// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;
  CartItem(
    this.title,
    this.productId,
    this.id,
    this.price,
    this.quantity,
  );

  // const CartItem({ Key? key }) : super(key: key);
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Colors.transparent,
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(2.0),
        ),
      ));

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        // return Future.value(true);
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text(
              'Do you want to remove the items?',
            ),
            actions: [
              FlatButton(
                child: Text(
                  'NO',
                  style: TextStyle(color: Colors.teal),
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text(
                  'YES',
                  style: TextStyle(color: Colors.teal),
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
                child: Padding(
              padding: EdgeInsets.all(5),
              child: FittedBox(
                child: Text('\$$price'),
              ),
            )),
            title: Text(title),
            subtitle: Text('Total: \$${price * quantity}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
