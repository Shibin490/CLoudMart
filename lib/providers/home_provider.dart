import 'package:cloud_mart/models/product_mode.dart';
import 'package:cloud_mart/services/firestore_services.dart';
import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  final ProductService _productService = ProductService();
  bool _isGridView = true;
  final TextEditingController _searchController = TextEditingController();
  List<Product> _filteredProducts = [];
  
  bool get isGridView => _isGridView;
  TextEditingController get searchController => _searchController;
  List<Product> get filteredProducts => _filteredProducts;
  Stream<List<Product>> get productsStream => _productService.getProducts();
  
  HomeProvider() {
    _searchController.addListener(_onSearchChanged);
  }
  
  void toggleViewMode() {
    _isGridView = !_isGridView;
    notifyListeners();
  }
  
  void _onSearchChanged() {
    if (_searchController.text.isEmpty) {
      _filteredProducts = [];
      notifyListeners();
    }
  }
  
  void searchProducts(String query) {
    if (query.isEmpty) {
      _filteredProducts = [];
    } else {
      _productService.getProducts().first.then((products) {
        _filteredProducts = products.where((product) => 
          product.name.toLowerCase().contains(query.toLowerCase()) ||
          (product.description).toLowerCase().contains(query.toLowerCase())
        ).toList();
        notifyListeners();
      });
    }
  }
  
  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }
}