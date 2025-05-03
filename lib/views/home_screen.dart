
import 'package:cloud_mart/providers/home_provider.dart';
import 'package:cloud_mart/services/firestore_services.dart';
import 'package:cloud_mart/views/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_mart/models/product_mode.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

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
          child: Column(
            children: [
              _buildWelcomeSection(),
              _buildSearchBar(),
              _buildCategorySelector(),
              Expanded(
                child: Consumer<HomeProvider>(
                  builder: (context, homeProvider, child) {
                    return StreamBuilder<List<Product>>(
                      stream: _firestoreService.getProducts(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return _buildLoadingState();
                        }

                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return _buildEmptyState();
                        }

                        final products = snapshot.data!;
                        return _buildProductGrid(products, context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
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
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/addProduct'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Icon(Icons.add, color: Colors.white, size: 7.w),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leadingWidth: 0,
      titleSpacing: 5.w,
      title: Row(
        children: [
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF5E35B1).withOpacity(0.7),
                  Color(0xFF3949AB).withOpacity(0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Icon(Icons.shopping_bag, color: Colors.white, size: 5.w),
          ),
          SizedBox(width: 3.w),
          Text(
            'CLOUD MART',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 1.2,
              fontSize: 15.sp,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: EdgeInsets.all(1.5.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white.withOpacity(0.05),
                width: 1,
              ),
            ),
            child: Icon(
              Icons.notifications_outlined,
              color: Colors.white,
              size: 5.w,
            ),
          ),
          onPressed: () {},
        ),
        SizedBox(width: 3.w),
      ],
    );
  }

  Widget _buildWelcomeSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back,',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(height: 0.5.h),
              Text(
                'Find your products',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      child: Container(
        height: 6.5.h,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: TextField(
          style: TextStyle(color: Colors.grey[900], fontSize: 12.sp),
          decoration: InputDecoration(
            hintText: 'Search products...',
            hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
            prefixIcon: Padding(
              padding: EdgeInsets.all(2.w),
              child: Icon(Icons.search, color: Colors.grey[400], size: 5.w),
            ),
            suffixIcon: Container(
              margin: EdgeInsets.all(1.w),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.tune, color: Colors.grey[400], size: 5.w),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: EdgeInsets.symmetric(vertical: 2.h),
          ),
          onChanged: (value) {
          },
        ),
      ),
    );
  }

  Widget _buildCategorySelector() {
    final categories = ['All', 'Popular', 'Recent', 'Featured', 'Sale'];

    return Container(
      height: 5.h,
      margin: EdgeInsets.only(bottom: 2.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isSelected = index == 0;
          return Container(
            margin: EdgeInsets.only(right: 4.w),
            decoration: BoxDecoration(
              gradient:
                  isSelected
                      ? LinearGradient(
                        colors: [Color(0xFF5E35B1), Color(0xFF3949AB)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                      : null,
              color: isSelected ? null : Colors.white.withOpacity(0.07),
              borderRadius: BorderRadius.circular(10),
              boxShadow:
                  isSelected
                      ? [
                        BoxShadow(
                          color: Color(0xFF3949AB).withOpacity(0.3),
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ]
                      : null,
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Text(
                  categories[index],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 11.sp,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(3.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 0.8.w,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            'Loading products...',
            style: TextStyle(color: Colors.white70, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(5.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF5E35B1).withOpacity(0.1),
                  Color(0xFF3949AB).withOpacity(0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Icon(
              Icons.shopping_bag_outlined,
              size: 10.h,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 3.h),
          Text(
            'No products yet',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Tap + to add your first product',
            style: TextStyle(color: Colors.white70, fontSize: 12.sp),
          ),
          SizedBox(height: 4.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.5.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF5E35B1), Color(0xFF3949AB)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF3949AB).withOpacity(0.3),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Text(
              'Add First Product',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid(List<Product> products, BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 4.w,
        mainAxisSpacing: 3.h,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return _buildProductCard(product, context);
      },
    );
  }

  Widget _buildProductCard(Product product, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.07),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 15,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                  ),
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (ctx, obj, stacktrace) => Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.white.withOpacity(0.3),
                            size: 8.w,
                          ),
                        ),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          value:
                              loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(3.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 0.3.h),
                    Text(
                      product.description,
                      style: TextStyle(color: Colors.white60, fontSize: 9.sp),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 13.sp,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF5E35B1), Color(0xFF3949AB)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF3949AB).withOpacity(0.3),
                                blurRadius: 8,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.add_shopping_cart_outlined,
                            color: Colors.white,
                            size: 4.w,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
