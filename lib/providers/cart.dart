import 'package:flutter/foundation.dart';

// import 'package:flutter/cupertino.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemcount {
    return _items.length;
  }

  double get totalamount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String title, String productId, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingcartItem) => CartItem(
            id: existingcartItem.id,
            title: existingcartItem.title,
            quantity: existingcartItem.quantity + 1,
            price: existingcartItem.price),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removesingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
          productId,
          (existingcartitem) => CartItem(
                id: existingcartitem.id,
                title: existingcartitem.title,
                quantity: existingcartitem.quantity - 1,
                price: existingcartitem.price,
              ));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clearcart() {
    _items = {};
    notifyListeners();
  }
}
