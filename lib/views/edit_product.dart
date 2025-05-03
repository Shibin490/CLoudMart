import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../models/product_mode.dart';
import '../providers/edit_screen_provider.dart';
import 'package:flutter/services.dart';

class EditProductScreen extends StatelessWidget {
  final Product product;

  const EditProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditProductProvider(product),
      child: EditProductContent(),
    );
  }
}

class EditProductContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EditProductProvider>(context);
    final product = provider.product;
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

              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderSection(context, "Edit Product"),
                    SizedBox(height: 3.h),
                    _buildImageSection(provider, product),
                    SizedBox(height: 4.h),
                    _buildInputSection(provider),
                    SizedBox(height: 5.h),
                    _buildActionButtons(context, provider),
                    SizedBox(height: 3.h),
                  ],
                ),
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
          'Update your product details below',
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildImageSection(EditProductProvider provider, Product product) {
    return Center(
      child: Column(
        children: [
          Container(
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
                        provider.pickedImage == null
                            ? Stack(
                              children: [
                                Image.network(
                                  product.imageUrl,
                                  fit: BoxFit.cover,
                                  height: double.infinity,
                                  width: double.infinity,
                                  loadingBuilder: (
                                    context,
                                    child,
                                    loadingProgress,
                                  ) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      color: Colors.white.withOpacity(0.05),
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          value:
                                              loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                        ),
                                      ),
                                    );
                                  },
                                  errorBuilder:
                                      (ctx, obj, stacktrace) => Container(
                                        color: Colors.white.withOpacity(0.05),
                                        child: Center(
                                          child: Icon(
                                            Icons.image_not_supported,
                                            color: Colors.white.withOpacity(
                                              0.3,
                                            ),
                                            size: 10.w,
                                          ),
                                        ),
                                      ),
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
                            )
                            : Stack(
                              children: [
                                Image.file(
                                  provider.pickedImage!,
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
                  child: GestureDetector(
                    onTap: provider.pickImage,
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
                ),
              ],
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Tap on camera icon to change image',
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputSection(EditProductProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInputField(
          controller: provider.nameController,
          label: 'Product Name',
          icon: Icons.inventory_2_outlined,
          hintText: 'Enter product name',
        ),
        SizedBox(height: 2.h),
        _buildInputField(
          controller: provider.priceController,
          label: 'Price (\$)',
          icon: Icons.attach_money,
          keyboardType: TextInputType.number,
          hintText: 'Enter price',
        ),
        SizedBox(height: 2.h),
        _buildMultilineInputField(
          controller: provider.descriptionController,
          label: 'Description',
          hintText: 'Enter product description...',
        ),
      ],
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
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
              child: TextField(
                controller: controller,
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
    required TextEditingController controller,
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
              child: TextField(
                controller: controller,
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

  Widget _buildActionButtons(
    BuildContext context,
    EditProductProvider provider,
  ) {
    return Column(
      children: [
        Container(
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
                      'SAVE CHANGES',
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
        ),
        SizedBox(height: 3.h),
        Container(
          width: double.infinity,
          height: 7.h,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.red.withOpacity(0.5), width: 1.5),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _showDeleteConfirmation(context, provider),
              borderRadius: BorderRadius.circular(16),
              splashColor: Colors.red.withOpacity(0.1),
              highlightColor: Colors.red.withOpacity(0.05),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.delete_outline,
                      color: Colors.red.shade300,
                      size: 6.w,
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      'DELETE PRODUCT',
                      style: TextStyle(
                        color: Colors.red.shade300,
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
        ),
      ],
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    EditProductProvider provider,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            insetPadding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Container(
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 14, 7, 51),
                    Color.fromARGB(255, 4, 12, 98),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    offset: Offset(0, 10),
                  ),
                ],
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.delete_outline,
                      color: Colors.white,
                      size: 10.w,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    'Delete Product',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'Are you sure you want to delete this product?',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 1.5.h),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.1),
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            Navigator.of(context).pop();
                            await provider.deleteProduct();
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "${provider.product.name} has been deleted",
                                ),
                                backgroundColor: Color(0xFF3949AB),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 1.5.h),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 198, 6, 38),
                                  Color.fromARGB(255, 121, 4, 8),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFF50057).withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
