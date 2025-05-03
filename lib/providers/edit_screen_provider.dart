import 'dart:io';
import 'package:cloud_mart/services/awss3_service.dart';
import 'package:cloud_mart/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/product_mode.dart';

class EditProductProvider extends ChangeNotifier {
  final Product product;

  TextEditingController nameController;
  TextEditingController priceController;
  TextEditingController descriptionController;

  File? pickedImage;

  EditProductProvider(this.product)
    : nameController = TextEditingController(text: product.name),
      priceController = TextEditingController(text: product.price.toString()),
      descriptionController = TextEditingController(text: product.description);

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      pickedImage = File(picked.path);
      notifyListeners();
    }
  }

  Future<void> saveProduct(BuildContext context) async {
    try {
      final s3Service = AWSS3Service();
      final firestoreService = FirestoreService();

      String imageUrl = product.imageUrl;

      if (pickedImage != null) {
        final uploadedUrl = await s3Service.uploadImageToS3(
          pickedImage!,
          nameController.text,
        );
        if (uploadedUrl != null) {
          imageUrl = uploadedUrl;
        } else {
          debugPrint("Image upload failed");
          return;
        }
      }

      final double? parsedPrice = double.tryParse(priceController.text);
      if (parsedPrice == null) {
        debugPrint("Invalid price format");
        return;
      }

      final updatedProduct = Product(
        id: product.id,
        name: nameController.text.trim(),
        price: parsedPrice,
        imageUrl: imageUrl,
        description: descriptionController.text.trim(),
      );

      final result = await firestoreService.updateProduct(updatedProduct);
      debugPrint(result ?? "Product updated successfully");

      Navigator.pushReplacementNamed(context, '/home');

    } catch (e) {
      debugPrint("Error updating product: $e");
    }
  }

  Future<void> deleteProduct() async {
    try {
      final firestoreService = FirestoreService();
      await firestoreService.deleteProduct(product.id!);
      debugPrint("Product deleted successfully");
    } catch (e) {
      debugPrint("Error deleting product: $e");
    }
  }
}
