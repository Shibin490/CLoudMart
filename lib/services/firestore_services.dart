import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_mart/models/product_mode.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;


  Future<void> addProduct(Product product) async {
    try {
      final productRef = _db.collection('products').doc();
      product.id = productRef.id; 
      await productRef.set(product.toMap());
    } catch (e) {
      print('Error adding product: $e');
      rethrow;
    }
  }


  Stream<List<Product>> getProducts() {
    return _db.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product.fromMap(doc.data(), id: doc.id);
      }).toList();
    });
  }

  Future<Product?> getProductById(String productId) async {
    try {
      final docSnapshot = await _db.collection('products').doc(productId).get();
      if (docSnapshot.exists) {
        return Product.fromMap(
          docSnapshot.data() as Map<String, dynamic>,
          id: docSnapshot.id,
        );
      }
      return null;
    } catch (e) {
      print('Error getting product by ID: $e');
      return null;
    }
  }

  Future<String?> updateProduct(Product product) async {
    try {
      if (product.id != null) {
        await _db
            .collection('products')
            .doc(product.id)
            .update(product.toMap());
        return "Product updated successfully!";
      } else {
        return "Product ID is null. Cannot update product.";
      }
    } catch (e) {
      print('Error updating product: $e');
      return "Error updating product. Please try again.";
    }
  }

  Future<String?> deleteProduct(String productId) async {
    try {
      if (productId.isNotEmpty) {
        await _db.collection('products').doc(productId).delete();
        return "Product deleted successfully!";
      } else {
        return "Product ID is invalid. Cannot delete product.";
      }
    } catch (e) {
      print('Error deleting product: $e');
      return "Error deleting product. Please try again.";
    }
  }
}
