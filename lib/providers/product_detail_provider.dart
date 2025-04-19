import 'package:flutter/material.dart';
import 'package:cloud_mart/models/product_mode.dart';
import 'package:cloud_mart/services/firestore_services.dart';

class ProductProvider with ChangeNotifier {
  final ProductService _productService = ProductService();
  Product? _product;
  bool _isLoading = false;

  Product? get product => _product;
  bool get isLoading => _isLoading;

  Future<void> fetchProduct(String productId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _product = await _productService.getProductById(productId);
    } catch (e) {
      _product = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String productId, String imageUrl) async {
    try {
      await _productService.deleteProduct(productId, imageUrl);
      _product = null;
      notifyListeners();
    } catch (e) {
      rethrow; 
    }
  }
}
