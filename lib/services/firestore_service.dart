// ignore_for_file: avoid_print, use_rethrow_when_possible

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_mart/models/product_mode.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final String productsCollection = 'products';

  Future<String> addProduct(String name, double price, String description, File imageFile) async {
    try {
      String productId = const Uuid().v4();
            String imageUrl = await _uploadImage(imageFile, productId);
      
      Product product = Product(
        id: productId,
        name: name,
        price: price,
        imageUrl: imageUrl,
        description: description,
      );
      
      await _firestore.collection(productsCollection).doc(productId).set(product.toMap());
      
      return productId;
    } catch (e) {
      print('Error adding product: $e');
      throw e;
    }
  }
  
  Future<String> _uploadImage(File imageFile, String productId) async {
    try {
      Reference ref = _storage.ref().child('product_images').child('$productId.jpg');
      
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
            String imageUrl = await snapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      throw e;
    }
  }
  
  Stream<List<Product>> getProducts() {
    return _firestore.collection(productsCollection).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }
  
  Future<Product?> getProduct(String productId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection(productsCollection).doc(productId).get();
      if (doc.exists) {
        return Product.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }
      return null;
    } catch (e) {
      print('Error getting product: $e');
      throw e;
    }
  }
  
  Future<void> updateProduct(String productId, String name, double price, String description, {File? imageFile}) async {
    try {
      Map<String, dynamic> data = {
        'name': name,
        'price': price,
        'description': description,
      };
      
      if (imageFile != null) {
        String imageUrl = await _uploadImage(imageFile, productId);
        data['imageUrl'] = imageUrl;
      }
      
      await _firestore.collection(productsCollection).doc(productId).update(data);
    } catch (e) {
      print('Error updating product: $e');
      throw e;
    }
  }
  
  Future<void> deleteProduct(String productId) async {
    try {
      await _firestore.collection(productsCollection).doc(productId).delete();
            try {
        await _storage.ref().child('product_images').child('$productId.jpg').delete();
      } catch (e) {
        print('Error deleting image (it may not exist): $e');
      }
    } catch (e) {
      print('Error deleting product: $e');
      throw e;
    }
  }
}