
import 'package:flutter/material.dart';
import 'dart:io';

class HomeProvider with ChangeNotifier {
  File? _imageFile;
  String _name = '';
  double _price = 0.0;
  String _description = '';

  File? get imageFile => _imageFile;
  String get name => _name;
  double get price => _price;
  String get description => _description;

  void setImageFile(File? imageFile) {
    _imageFile = imageFile;
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setPrice(String price) {
    _price = double.tryParse(price) ?? 0.0;
    notifyListeners();
  }

  void setDescription(String description) {
    _description = description;
    notifyListeners();
  }

  void clearForm() {
    _imageFile = null;
    _name = '';
    _price = 0.0;
    _description = '';
    notifyListeners();
  }
}
