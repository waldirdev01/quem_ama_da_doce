import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quem_ama_da_doce/models/app_user/app_user.dart';

import '../app_user/app_user_manager.dart';
import '../products/product.dart';
import 'cart_product.dart';

class CartManager extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<CartProduct> items = [];
  AppUser? userApp;
  num productsPrice = 0.0;
  late Product product;

  void updateUser(UserManager userManager) {
    userApp = userManager.appUser;
    items.clear();

    if (userApp != null) {
      _loadCartItems();
    }
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await userApp!.cartReference.get();

    items = cartSnap.docs
        .map((d) => CartProduct.fromDocument(d)..addListener(_onItemUpdated))
        .toList();
  }

  void addToCart(Product product) {
    try {
      final entidade = items.firstWhere((p) => p.stackable(product));
      entidade.increment();
    } catch (e) {
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(_onItemUpdated);
      items.add(cartProduct);
      userApp!.cartReference
          .add(cartProduct.toCartItemMap())
          .then((doc) => cartProduct.id = doc.id);
      _onItemUpdated();
    }
    notifyListeners();
  }

  void removeOfCartProduct(CartProduct cartProduct) {
    items.removeWhere((element) => element.id == cartProduct.id);
    userApp?.cartReference.doc(cartProduct.id).delete();
    cartProduct.removeListener(_onItemUpdated);
    notifyListeners();
  }

  void _onItemUpdated() {
    productsPrice = 0.0;
    for (int i = 0; i <items.length; i++) {
      final cartProduct = items[i];
      if (cartProduct.quantity == 0) {
        removeOfCartProduct(cartProduct);
        i--;
        continue;
      }
      productsPrice += cartProduct.totalPrice;
      _updateCartProduct(cartProduct);
    }
  }

  void _updateCartProduct(CartProduct cartProduct) {
    if(cartProduct.id != null)
    userApp?.cartReference
        .doc(cartProduct.id)
        .update(cartProduct.toCartItemMap());
    notifyListeners();
  }

  bool get isCartValid {
    for (final cartProduct in items) {
      if (!cartProduct.hasStock) return false;
    }
    return true;
  }
}
