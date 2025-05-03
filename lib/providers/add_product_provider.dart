
import 'package:cloud_mart/services/awss3_service.dart';
import 'package:cloud_mart/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:cloud_mart/models/product_mode.dart'; 

class AddProductProvider with ChangeNotifier {
  File? _imageFile;
  String _name = '';
  double _price = 0.0;
  String _description = '';

  final AWSS3Service _s3Service = AWSS3Service();
  final FirestoreService _firestoreService = FirestoreService();

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

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setImageFile(File(pickedFile.path));
    }
  }

  Future<void> saveProduct(BuildContext context) async {
    if (_name.isNotEmpty &&
        _price > 0 &&
        _description.isNotEmpty &&
        _imageFile != null) {
      try {
        final String noteId = DateTime.now().millisecondsSinceEpoch.toString(); 
        final String? imageUrl =
            await _s3Service.uploadImageToS3(_imageFile!, noteId);

        if (imageUrl == null) {
          throw Exception("Image upload failed");
        }

  
        final product = Product(
          id: '', 
          name: _name,
          price: _price,
          description: _description,
          imageUrl: imageUrl,
        );

        await _firestoreService.addProduct(product);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product saved successfully')),
        );

        clearForm();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save product: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields and select an image')),
      );
    }
  }

  void clearForm() {
    _imageFile = null;
    _name = '';
    _price = 0.0;
    _description = '';
    notifyListeners();
  }
}
