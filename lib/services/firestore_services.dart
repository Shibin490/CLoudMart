
// ignore_for_file: avoid_print, use_rethrow_when_possible

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_mart/models/product_mode.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;
import 'package:image/image.dart' as img;

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final String productsCollection = 'products';
  Future<String> addProduct(
    String name,
    double price,
    String description,
    File imageFile,
  ) async {
    try {
      String productId = const Uuid().v4();
      String fileExtension = path.extension(imageFile.path).toLowerCase();
      if (!['.jpg', '.jpeg', '.png'].contains(fileExtension)) {
        throw Exception('Unsupported image format');
      }

      final fileSizeInMB =
          imageFile.lengthSync() / (1024 * 1024); 
      if (fileSizeInMB > 5) {
        throw Exception('Image size exceeds the limit of 5MB');
      }
      String imageUrl = await _uploadImage(imageFile, productId);

      final product = {
        'name': name,
        'price': price,
        'description': description,
        'imageUrl': imageUrl,
        'createdAt': FieldValue.serverTimestamp(),
      };
      await _firestore
          .collection(productsCollection)
          .doc(productId)
          .set(product);

      return productId;
    } catch (e) {
      print('Error adding product: $e');
      throw e;
    }
  }

  Future<String> _uploadImage(File imageFile, String productId) async {
    try {

      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      String fileExtension = path.extension(imageFile.path).toLowerCase();
      final storageRef = _storage
          .ref()
          .child('product_images')
          .child(productId)
          .child('$fileName$fileExtension');

      final uploadTask = storageRef.putFile(imageFile);

      await uploadTask;
      final downloadUrl = await storageRef.getDownloadURL();
      print('Image uploaded successfully: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return 'https://via.placeholder.com/400x400?text=Image+Not+Available';
    }
  }

  Future<File> compressImage(File imageFile) async {
    final img.Image? image = img.decodeImage(imageFile.readAsBytesSync());
    if (image == null) return imageFile;
    final img.Image resized = img.copyResize(image, width: 600);

    final compressedFile = File(
      '${imageFile.parent.path}/compressed_${imageFile.uri.pathSegments.last}',
    );
    compressedFile.writeAsBytesSync(img.encodeJpg(resized, quality: 80));

    return compressedFile;
  }

  Future<void> updateProduct(
    String productId,
    String name,
    double price,
    String description, {
    File? newImageFile,
  }) async {
    try {
      final updates = {
        'name': name,
        'price': price,
        'description': description,
        'updatedAt': FieldValue.serverTimestamp(),
      };

      if (newImageFile != null) {
        String imageUrl = await _uploadImage(newImageFile, productId);
        updates['imageUrl'] = imageUrl;
      }

      await _firestore
          .collection(productsCollection)
          .doc(productId)
          .update(updates);
    } catch (e) {
      print('Error updating product: $e');
      throw e;
    }
  }

  // Get all products
  Stream<List<Product>> getProducts() {
    return _firestore
        .collection(productsCollection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => Product.fromMap(doc.data(), doc.id))
              .toList();
        });
  }

  Future<Product?> getProductById(String productId) async {
    try {
      final doc =
          await _firestore.collection(productsCollection).doc(productId).get();
      if (doc.exists && doc.data() != null) {
        return Product.fromMap(doc.data()!, doc.id);
      }
      return null;
    } catch (e) {
      print('Error getting product: $e');
      throw e;
    }
  }

  Future<void> deleteProduct(String productId, String imageUrl) async {
    try {
      await _firestore.collection(productsCollection).doc(productId).delete();
      if (imageUrl.isNotEmpty && !imageUrl.contains('placeholder.com')) {
        try {
          final ref = _storage.refFromURL(imageUrl);
          await ref.delete();
          print('Image deleted successfully');
        } catch (e) {
          print('Error deleting image: $e');
          try {
            final productRef = _storage
                .ref()
                .child('product_images')
                .child(productId);
            final ListResult result = await productRef.listAll();
            for (var item in result.items) {
              await item.delete();
            }
            print('Product images folder deleted');
          } catch (folderError) {
            print('Error deleting product images folder: $folderError');
          }
        }
      }
    } catch (e) {
      print('Error deleting product: $e');
      throw e;
    }
  }
}
