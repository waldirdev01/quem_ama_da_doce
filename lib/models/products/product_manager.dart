import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quem_ama_da_doce/models/products/product.dart';

class ProductManager extends ChangeNotifier {
  ProductManager() {
    _loadAllProducts();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Product> _allProducts = [];

  List<Product> get allProducts => [..._allProducts];
  String _search = '';

  String get search => _search;

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<Product> get filteredProducts {
    final List<Product> filteredProducts = [];
    if (search.isEmpty) {
      filteredProducts.addAll(allProducts);
    } else {
      filteredProducts.addAll(allProducts.where((product) =>
          product.name.toLowerCase().contains(search.toLowerCase())));
    }
    return filteredProducts;
  }

  Future<void> _loadAllProducts() async {
    final QuerySnapshot snapProducts =
    await firestore.collection('products').get();
    _allProducts =
        snapProducts.docs.map((d) => Product.fromDocument(d)).toList();
  }

  Product? findProductById(String id){
    try {
      return allProducts.firstWhere((p) => p.id == id);
    } catch (e){
      return null;
    }
  }
}
