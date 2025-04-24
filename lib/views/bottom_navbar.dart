import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.h,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        border: Border.all(color: Colors.white, width: 1),
        boxShadow: [
          BoxShadow(color: Colors.black, blurRadius: 10, offset: Offset(0, -3)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.home_filled, 0),
          _buildNavItem(Icons.shopping_cart_outlined, 1),
          _buildNavItem(Icons.favorite_outline, 2),
          _buildNavItem(Icons.person_outline, 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final bool isActive = index == currentIndex;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          gradient:
              isActive
                  ? LinearGradient(
                    colors: [Color(0xFF5E35B1), Color(0xFF3949AB)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                  : null,
          color: isActive ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow:
              isActive
                  ? [
                    BoxShadow(
                      color: Color(0xFF3949AB),
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ]
                  : null,
        ),
        child: Icon(
          icon,
          color: isActive ? Colors.white : Colors.white54,
          size: 6.w,
        ),
      ),
    );
  }
}
