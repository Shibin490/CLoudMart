import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 5, 24),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 14, 7, 51),
        elevation: 0,
        title: Text(
          'My Wishlist',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        width: 100.w,
        height: 100.h,
        color: Color.fromARGB(255, 3, 5, 24),
        child:
            _dummyWishlistData.isEmpty
                ? _buildEmptyWishlist()
                : _buildWishlistGrid(),
      ),
    );
  }

  Widget _buildEmptyWishlist() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 15.w,
            color: Colors.white.withOpacity(0.7),
          ),
          SizedBox(height: 2.h),
          Text(
            'Your wishlist is empty',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Items you like will appear here',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistGrid() {
    return GridView.builder(
      padding: EdgeInsets.all(4.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 3.w,
        mainAxisSpacing: 3.w,
      ),
      itemCount: _dummyWishlistData.length,
      itemBuilder: (context, index) {
        final item = _dummyWishlistData[index];

        return Card(
          color: Colors.white.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                    color: Colors.white.withOpacity(0.05),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                    child: Image.network(
                      item['imageUrl'],
                      fit: BoxFit.cover,
                      errorBuilder:
                          (ctx, obj, stacktrace) => Center(
                            child: Icon(
                              Icons.image_not_supported,
                              color: Colors.white,
                            ),
                          ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(2.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item['name'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        '\$${item['price']}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                            size: 5.w,
                          ),
                          Icon(
                            Icons.favorite,
                            color: Colors.redAccent,
                            size: 5.w,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  final List<Map<String, dynamic>> _dummyWishlistData = [
    {
      'name': 'Wireless Headphones',
      'price': '129.99',
      'imageUrl': 'https://picsum.photos/200/300',
    },
    {
      'name': 'Smart Watch',
      'price': '249.99',
      'imageUrl': 'https://picsum.photos/200/301',
    },
    {
      'name': 'Fitness Tracker',
      'price': '89.99',
      'imageUrl': 'https://picsum.photos/200/302',
    },
    {
      'name': 'Bluetooth Speaker',
      'price': '79.99',
      'imageUrl': 'https://picsum.photos/200/303',
    },
  ];
}
