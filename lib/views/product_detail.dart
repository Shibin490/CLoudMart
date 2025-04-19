// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:cloud_mart/providers/product_detail_provider.dart';
import 'package:cloud_mart/views/edit_product.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    if (productProvider.product == null) {
      productProvider.fetchProduct(productId);
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 26, 5, 146), 
            Color.fromARGB(255, 2, 7, 13), 
            Color.fromARGB(255, 5, 19, 124), 
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: productProvider.isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 0.8.w,
                ),
              )
            : productProvider.product == null
                ? Center(
                    child: Text(
                      'Product not found',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        expandedHeight: 40.h, 
                        pinned: true,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Hero(
                            tag: 'product-${productProvider.product!.id}',
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(4.w),
                                  bottomRight: Radius.circular(4.w),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 1.w,
                                    blurRadius: 2.w,
                                    offset: Offset(0, 0.5.h),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(4.w),
                                  bottomRight: Radius.circular(4.w),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: productProvider.product!.imageUrl,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    color: Colors.grey.shade200,
                                    child: Center(
                                      child: SizedBox(
                                        width: 10.w,
                                        height: 10.w,
                                        child: const CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Container(
                                    color: Colors.grey.shade200,
                                    child: Icon(
                                      Icons.error,
                                      color: Colors.red,
                                      size: 12.w,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        actions: [
                          Container(
                            margin: EdgeInsets.all(1.w),
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(2.w),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 5.w,
                              ),
                              onPressed: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditProductScreen(
                                      product: productProvider.product!,
                                    ),
                                  ),
                                );
                                if (result == true) {
                                  productProvider.fetchProduct(productId);
                                }
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(1.w),
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(2.w),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 5.w,
                              ),
                              onPressed: () {
                                _showDeleteConfirmation(context, productProvider);
                              },
                            ),
                          ),
                          SizedBox(width: 1.w),
                        ],
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color.fromARGB(255, 26, 5, 146).withOpacity(0.8),
                                const Color.fromARGB(255, 2, 7, 13).withOpacity(0.9),
                                const Color.fromARGB(255, 5, 19, 124).withOpacity(0.8),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6.w),
                              topRight: Radius.circular(6.w),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 1.w,
                                blurRadius: 2.w,
                                offset: Offset(0, -0.5.h),
                              ),
                            ],
                          ),
                          margin: EdgeInsets.only(top: 2.h),
                          child: Padding(
                            padding: EdgeInsets.all(5.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        productProvider.product!.name,
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          shadows: [
                                            Shadow(
                                              color: Colors.black.withOpacity(0.5),
                                              blurRadius: 1.w,
                                              offset: Offset(0, 0.2.h),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 3.w,
                                        vertical: 1.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(4.w),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Theme.of(context).primaryColor.withOpacity(0.5),
                                            spreadRadius: 0.5.w,
                                            blurRadius: 1.w,
                                            offset: Offset(0, 0.2.h),
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        '\$${productProvider.product!.price.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 3.h),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(3.w),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white.withOpacity(0.1),
                                        Colors.white.withOpacity(0.05),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(3.w),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.2),
                                      width: 0.1.w,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Description',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 1.h),
                                      Text(
                                        productProvider.product!.description,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          height: 1.5,
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.w),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                                        spreadRadius: 0.5.w,
                                        blurRadius: 2.w,
                                        offset: Offset(0, 0.5.h),
                                      ),
                                    ],
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Added to cart!',
                                            style: TextStyle(fontSize: 12.sp),
                                          ),
                                          backgroundColor: Theme.of(context).primaryColor,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(2.w),
                                          ),
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 4.w,
                                            vertical: 2.h,
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: Theme.of(context).primaryColor,
                                      minimumSize: Size(double.infinity, 7.h),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4.w),
                                      ),
                                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                                      elevation: 0,),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.shopping_cart, size: 6.w),
                                        SizedBox(width: 2.w),
                                        Text(
                                          'Add to Cart',
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4.h),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, ProductProvider productProvider) {
    final product = productProvider.product!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 5, 19, 124),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.w),
        ),
        title: Text(
          'Delete Product',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to delete "${product.name}"?',
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 12.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12.sp,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.8),
              borderRadius: BorderRadius.circular(2.w),
            ),
            child: TextButton(
              onPressed: () async {
                Navigator.pop(context);
                try {
                  await productProvider.deleteProduct(product.id, product.imageUrl);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Product deleted successfully',
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.w),
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 2.h,
                      ),
                    ),
                  );
                  Navigator.pop(context); 
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Error deleting product: $e',
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.w),
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 2.h,
                      ),
                    ),
                  );
                }
              },
              child: Text(
                'Delete',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}