// ignore_for_file: deprecated_member_use
import 'package:cloud_mart/providers/add_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AddProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color.fromARGB(255, 3, 5, 24),
      appBar: _buildAppBar(context),
      body: Container(
        width: 100.w,
        height: 100.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 14, 7, 51),
              Color.fromARGB(255, 4, 12, 98),
              Color.fromARGB(255, 3, 5, 24),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: -10.h,
                right: -10.w,
                child: Container(
                  height: 30.h,
                  width: 30.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF5E35B1).withOpacity(0.1),
                  ),
                ),
              ),
              Positioned(
                bottom: -5.h,
                left: -10.w,
                child: Container(
                  height: 25.h,
                  width: 25.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF3949AB).withOpacity(0.08),
                  ),
                ),
              ),

              Consumer<AddProductProvider>(
                builder: (context, provider, child) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 2.h,
                    ),
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeaderSection(context, "Add Product"),
                        SizedBox(height: 3.h),
                        _buildImagePicker(context, provider),
                        SizedBox(height: 4.h),
                        _buildInputSection(context, provider),
                        SizedBox(height: 5.h),
                        _buildSaveButton(context, provider),
                        SizedBox(height: 3.h),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: EdgeInsets.only(left: 5.w, top: 2.h),
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.05), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 5.w),
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 5.w, top: 2.h),
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.05), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Icon(Icons.more_vert, color: Colors.white, size: 5.w),
        ),
      ],
    );
  }

  Widget _buildHeaderSection(BuildContext context, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        Text(
          'Enter your product details below',
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildImagePicker(BuildContext context, AddProductProvider provider) {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: provider.pickImage,
            child: Container(
              height: 30.h,
              width: 70.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF3949AB).withOpacity(0.3),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      child:
                          provider.imageFile == null
                              ? Container(
                                color: Colors.white.withOpacity(0.05),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_a_photo,
                                        color: Colors.white.withOpacity(0.7),
                                        size: 12.w,
                                      ),
                                      SizedBox(height: 2.h),
                                      Text(
                                        'Add Product Image',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.7),
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              : Stack(
                                children: [
                                  Image.file(
                                    provider.imageFile!,
                                    fit: BoxFit.cover,
                                    height: double.infinity,
                                    width: double.infinity,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withOpacity(0.4),
                                        ],
                                        stops: [0.7, 1.0],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                    ),
                  ),

                  Positioned(
                    bottom: 15,
                    right: 15,
                    child: Container(
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF5E35B1), Color(0xFF3949AB)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF3949AB).withOpacity(0.5),
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                        size: 6.w,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Tap on camera icon to add image',
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputSection(BuildContext context, AddProductProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInputField(
          initialValue: provider.name,
          onChanged: provider.setName,
          label: 'Product Name',
          icon: Icons.inventory_2_outlined,
          hintText: 'Enter product name',
        ),
        SizedBox(height: 2.h),
        _buildInputField(
          initialValue: provider.price.toString(),
          onChanged: provider.setPrice,
          label: 'Price (\$)',
          icon: Icons.attach_money,
          keyboardType: TextInputType.number,
          hintText: 'Enter price',
        ),
        SizedBox(height: 2.h),
        _buildMultilineInputField(
          initialValue: provider.description,
          onChanged: provider.setDescription,
          label: 'Description',
          hintText: 'Enter product description...',
        ),
      ],
    );
  }

  Widget _buildInputField({
    required String initialValue,
    required Function(String) onChanged,
    required String label,
    required IconData icon,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.08),
            Colors.white.withOpacity(0.03),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 4.w,
              right: 4.w,
              top: 2.h,
              bottom: 1.h,
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 5.w),
                SizedBox(width: 3.w),
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.w, right: 4.w, bottom: 2.h),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: TextFormField(
                initialValue: initialValue,
                onChanged: onChanged,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.9),
                    fontSize: 13.sp,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 1.h),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMultilineInputField({
    required String initialValue,
    required Function(String) onChanged,
    required String label,
    required String hintText,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.08),
            Colors.white.withOpacity(0.03),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 4.w,
              right: 4.w,
              top: 2.h,
              bottom: 1.h,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.description_outlined,
                  color: Colors.white,
                  size: 5.w,
                ),
                SizedBox(width: 3.w),
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 4.w, right: 4.w, bottom: 1.h),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: TextFormField(
                initialValue: initialValue,
                onChanged: onChanged,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.9),
                    fontSize: 14.sp,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 1.h),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context, AddProductProvider provider) {
    return Container(
      width: double.infinity,
      height: 7.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 116, 58, 231),
            Color.fromARGB(255, 12, 28, 131),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF3949AB).withOpacity(0.5),
            blurRadius: 15,
            offset: Offset(0, 8),
            spreadRadius: -5,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => provider.saveProduct(context),
          borderRadius: BorderRadius.circular(16),
          splashColor: Colors.white.withOpacity(0.1),
          highlightColor: Colors.white.withOpacity(0.05),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.save_outlined, color: Colors.white, size: 6.w),
                SizedBox(width: 3.w),
                Text(
                  'SAVE PRODUCT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
