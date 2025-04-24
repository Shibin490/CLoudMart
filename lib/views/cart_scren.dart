// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class CartScreen extends StatelessWidget {
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
              // Background design elements
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
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                    child: _buildHeaderSection(context, "Shopping Cart"),
                  ),
                                    Expanded(
                    child: _dummyCartData.isEmpty 
                        ? _buildEmptyCart() 
                        : _buildCartItemsList(),
                  ),
                  
                  _dummyCartData.isEmpty 
                      ? SizedBox() 
                      : _buildCheckoutSection(context),
                ],
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
          child: Icon(Icons.refresh, color: Colors.white, size: 5.w),
        ),
      ],
    );
  }

  Widget _buildHeaderSection(BuildContext context, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
            SizedBox(width: 3.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                "${_dummyCartData.length} Items",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 10.sp,
                ),
              ),
            ),
          ],
        ),
        Text(
          _dummyCartData.isEmpty 
              ? 'Your cart is empty' 
              : 'Review your items and checkout',
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white.withOpacity(0.7),
              size: 15.w,
            ),
          ),
          SizedBox(height: 3.h),
          Text(
            "Your cart is empty",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            "Looks like you haven't added\nanything to your cart yet",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 5.h),
          Container(
            width: 70.w,
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
                onTap: () {},
                borderRadius: BorderRadius.circular(16),
                splashColor: Colors.white.withOpacity(0.1),
                highlightColor: Colors.white.withOpacity(0.05),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 6.w),
                      SizedBox(width: 3.w),
                      Text(
                        'START SHOPPING',
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
        ],
      ),
    );
  }

  Widget _buildCartItemsList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      physics: BouncingScrollPhysics(),
      itemCount: _dummyCartData.length,
      itemBuilder: (context, index) {
        final item = _dummyCartData[index];
        return _buildCartItem(item);
      },
    );
  }

  Widget _buildCartItem(CartItem item) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
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
      child: Row(
        children: [
          Container(
            height: 12.h,
            width: 25.w,
            margin: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Colors.white.withOpacity(0.05),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
                errorBuilder: (ctx, obj, stacktrace) => Container(
                  color: Colors.white.withOpacity(0.05),
                  child: Center(
                    child: Icon(
                      Icons.image_not_supported,
                      color: Colors.white.withOpacity(0.3),
                      size: 10.w,
                    ),
                  ),
                ),
              ),
            ),
          ),
                    Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    "\$${item.price.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      _quantityButton(Icons.remove, () {}),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2.w),
                        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "${item.quantity}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      _quantityButton(Icons.add, () {}),
                    ],
                  ),
                ],
              ),
            ),
          ),
                    Padding(
            padding: EdgeInsets.all(2.w),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red.withOpacity(0.3)),
                ),
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.red.shade300,
                  size: 5.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _quantityButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(1.w),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Icon(
          icon,
          color: Colors.white70,
          size: 4.w,
        ),
      ),
    );
  }

  Widget _buildCheckoutSection(BuildContext context) {
    final subtotal = _dummyCartData.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
    final shipping = 5.99;
    final total = subtotal + shipping;
    
    return Container(
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.05),
            Colors.white.withOpacity(0.02),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 12.sp,
                ),
              ),
              Text(
                "\$${subtotal.toStringAsFixed(2)}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shipping",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 12.sp,
                ),
              ),
              Text(
                "\$${shipping.toStringAsFixed(2)}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.5.h),
            child: Divider(color: Colors.white.withOpacity(0.1)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "\$${total.toStringAsFixed(2)}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
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
                onTap: () {},
                borderRadius: BorderRadius.circular(16),
                splashColor: Colors.white.withOpacity(0.1),
                highlightColor: Colors.white.withOpacity(0.05),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 6.w),
                      SizedBox(width: 3.w),
                      Text(
                        'CHECKOUT',
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
        ],
      ),
    );
  }

  final List<CartItem> _dummyCartData = [
    CartItem(
      id: '1',
      name: 'Premium Wireless Headphones',
      price: 129.99,
      quantity: 1,
      imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e',
    ),
    CartItem(
      id: '2',
      name: 'Smart Watch Series 5',
      price: 199.99,
      quantity: 1,
      imageUrl: 'https://images.unsplash.com/photo-1546868871-7041f2a55e12',
    ),
    CartItem(
      id: '3',
      name: 'Fitness Tracker Band',
      price: 49.99,
      quantity: 2,
      imageUrl: 'https://images.unsplash.com/photo-1557935728-e6d1eaabe558',
    ),
  ];
}

class CartItem {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String imageUrl;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });
}