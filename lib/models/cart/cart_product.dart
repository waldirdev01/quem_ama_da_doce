import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../item_size.dart';
import '../products/product.dart';

class CartProduct extends ChangeNotifier {
  CartProduct.fromProduct(this.product)
      : productId = product!.id,
        quantity = 1,
        size = product.selectedSize.name;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? id;
  String productId;
  int quantity;
  String size;
  Product? product;

  CartProduct.fromDocument(DocumentSnapshot document)
      : id = document.id,
        productId = document['pid'] as String,
        quantity = document['quantity'] as int,
        size = document['size'] as String {
    firestore.doc('products/$productId').get().then((doc) {
      product = Product.fromDocument(doc);
      notifyListeners();
    });
  }



  ItemSize? get itemSize {
    if (product == null) return null;
    return product!.findSize(size);
  }

  num get unitPrice {
    if (product == null) return 0;
    return itemSize?.price ?? 0;
  }

  num get totalPrice => unitPrice * quantity;

  Map<String, dynamic> toCartItemMap() {
    return {
      'pid': productId,
      'quantity': quantity,
      'size': size,
    };
  }

  bool stackable(Product product) {
    return product.id == productId && product.selectedSize.name == size;
  }

  void increment() {
    quantity++;
    notifyListeners();
  }

  void decrement() {
    quantity--;
    notifyListeners();
  }

  bool get hasStock {
    final size = itemSize;
    if (size == null) {
      return false;
    } else {
      return size.stock >= quantity;
    }
  }
}
