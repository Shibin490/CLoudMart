import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/product_mode.dart';
import '../services/firestore_services.dart';

class ProductEditProvider extends ChangeNotifier {
  final ProductService _productService = ProductService();
  final formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController descriptionController;
  File? imageFile;
  bool isLoading = false;
  bool imageChanged = false;
  late Product product;

  void init(Product p) {
    product = p;
    nameController = TextEditingController(text: product.name);
    priceController = TextEditingController(text: product.price.toString());
    descriptionController = TextEditingController(text: product.description);
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      imageChanged = true;
      notifyListeners();
    }
  }

  Future<void> updateProduct(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    isLoading = true;
    notifyListeners();

    try {
      await _productService.updateProduct(
        product.id,
        nameController.text.trim(),
        double.parse(priceController.text.trim()),
        descriptionController.text.trim(),
        newImageFile: imageChanged ? imageFile : null,
      );

      if (context.mounted) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product updated successfully')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating product: $e')),
        );
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
