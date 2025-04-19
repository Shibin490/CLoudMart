// ignore_for_file: deprecated_member_use

import 'package:cloud_mart/providers/edit_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sizer/sizer.dart';
import '../models/product_mode.dart';

class EditProductScreen extends StatelessWidget {
  final Product product;

  const EditProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductEditProvider>(
      create: (_) {
        final provider = ProductEditProvider();
        provider.init(product);
        return provider;
      },
      child: Consumer<ProductEditProvider>(
        builder: (context, provider, _) {
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
              appBar: AppBar(
                title: Text(
                  'Edit Product',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                iconTheme: const IconThemeData(color: Colors.white),
              ),
              body: provider.isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 0.8.w,
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.1),
                            Colors.white.withOpacity(0.05),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(5.w),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 0.1.w,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 2.w,
                            spreadRadius: 0.5.w,
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(4.w),
                        child: Form(
                          key: provider.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Product Details',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              GestureDetector(
                                onTap: provider.pickImage,
                                child: Container(
                                  height: 30.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(4.w),
                                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 2.w,
                                        spreadRadius: 0.5.w,
                                      ),
                                    ],
                                  ),
                                  child: provider.imageChanged && provider.imageFile != null
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(4.w),
                                          child: Image.file(
                                            provider.imageFile!,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius: BorderRadius.circular(4.w),
                                          child: CachedNetworkImage(
                                            imageUrl: provider.product.imageUrl,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) => Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 0.8.w,
                                              ),
                                            ),
                                            errorWidget: (context, url, error) => Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.error,
                                                  size: 10.w,
                                                  color: Colors.red.shade400,
                                                ),
                                                SizedBox(height: 1.h),
                                                Text(
                                                  'Failed to load image',
                                                  style: TextStyle(
                                                    color: Colors.red.shade400,
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white.withOpacity(0.2),
                                        Colors.white.withOpacity(0.1),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(3.w),
                                  ),
                                  child: TextButton.icon(
                                    onPressed: provider.pickImage,
                                    icon: Icon(
                                      Icons.photo_camera,
                                      color: Colors.white,
                                      size: 5.w,
                                    ),
                                    label: Text(
                                      'Change Image',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 4.w,
                                        vertical: 1.h,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3.w),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 3.h),
                              inputFieldLabel('Product Name'),
                              SizedBox(height: 1.h),
                              TextFormField(
                                controller: provider.nameController,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.black.withOpacity(0.2),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3.w),
                                    borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3.w),
                                    borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3.w),
                                    borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.6),
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.shopping_bag,
                                    color: Colors.white.withOpacity(0.7),
                                    size: 5.w,
                                  ),
                                  hintText: 'Enter product name',
                                  hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 11.sp,
                                  ),
                                ),
                                validator: (value) => (value == null || value.trim().isEmpty)
                                    ? 'Please enter product name'
                                    : null,
                              ),
                              SizedBox(height: 3.h),
                              inputFieldLabel('Price'),
                              SizedBox(height: 1.h),
                              TextFormField(
                                controller: provider.priceController,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.black.withOpacity(0.2),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3.w),
                                    borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3.w),
                                    borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3.w),
                                    borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.6),
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.attach_money,
                                    color: Colors.white.withOpacity(0.7),
                                    size: 5.w,
                                  ),
                                  hintText: 'Enter price',
                                  hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 11.sp,
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter price';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Please enter a valid number';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 3.h),
                              inputFieldLabel('Description'),
                              SizedBox(height: 1.h),
                              TextFormField(
                                controller: provider.descriptionController,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                ),
                                maxLines: 5,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.black.withOpacity(0.2),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3.w),
                                    borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3.w),
                                    borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3.w),
                                    borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.6),
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.description,
                                    color: Colors.white.withOpacity(0.7),
                                    size: 5.w,
                                  ),
                                  hintText: 'Enter product description',
                                  hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 11.sp,
                                  ),
                                ),
                                validator: (value) => (value == null || value.trim().isEmpty)
                                    ? 'Please enter description'
                                    : null,
                              ),
                              SizedBox(height: 4.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            blurRadius: 2.w,
                                            spreadRadius: 0.5.w,
                                          ),
                                        ],
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () => Navigator.pop(context),
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: const Color.fromARGB(255, 26, 5, 146),
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(3.w),
                                          ),
                                          padding: EdgeInsets.symmetric(vertical: 1.8.h),
                                        ),
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color.fromARGB(255, 26, 5, 146).withOpacity(0.5),
                                            blurRadius: 2.w,
                                            spreadRadius: 0.5.w,
                                          ),
                                        ],
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () => provider.updateProduct(context),
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: const Color.fromARGB(255, 26, 5, 146),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(3.w),
                                          ),
                                          padding: EdgeInsets.symmetric(vertical: 1.8.h),
                                        ),
                                        child: Text(
                                          'Save Changes',
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.h),
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
  Widget inputFieldLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(left: 1.w),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}