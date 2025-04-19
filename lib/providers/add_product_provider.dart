import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_mart/services/firestore_services.dart';
import 'package:image_picker/image_picker.dart';

class AddProductProvider with ChangeNotifier {
  final ProductService _productService = ProductService();
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  File? imageFile;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> saveProduct(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      if (imageFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select an image')),
        );
        return;
      }

      _setLoadingState(true);

      try {
        await _productService.addProduct(
          nameController.text.trim(),
          double.parse(priceController.text.trim()),
          descriptionController.text.trim(),
          imageFile!,
        );

        if (context.mounted) {
          Navigator.pop(context, true);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Product added successfully')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error adding product: $e')),
          );
        }
      } finally {
        _setLoadingState(false);
      }
    }
  }

  void _setLoadingState(bool state) {
    _isLoading = state;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
