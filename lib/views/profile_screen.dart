import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';
import '../services/auth_service.dart';
import '../providers/profile_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProfileProvider(auth.currentUser),
      child: const ProfileContent(),
    );
  }
}

class ProfileContent extends StatelessWidget {
  const ProfileContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context);
    final user = provider.user;

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 3, 5, 24),
      appBar: _buildAppBar(context),
      body: Container(
        width: 100.w,
        height: 100.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 14, 7, 51),
              const Color.fromARGB(255, 4, 12, 98),
              const Color.fromARGB(255, 3, 5, 24),
            ],
            stops: const [0.0, 0.5, 1.0],
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
                    color: const Color(0xFF5E35B1).withOpacity(0.1),
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
                    color: const Color(0xFF3949AB).withOpacity(0.08),
                  ),
                ),
              ),

              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderSection(context, "My Profile"),
                    SizedBox(height: 3.h),
                    _buildProfileImageSection(user),
                    SizedBox(height: 4.h),
                    _buildInfoSection(user),
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
                offset: const Offset(0, 3),
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
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(Icons.settings, color: Colors.white, size: 5.w),
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
          'Manage your account information',
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImageSection(user) {
    final displayName = user?.displayName ?? 'Your Name';
    final email = user?.email ?? 'you@example.com';
    final photoURL = user?.photoURL;

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
                  color: const Color(0xFF3949AB).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color.fromARGB(255, 18, 10, 61),
                      const Color.fromARGB(255, 8, 20, 121),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 15.h,
                      width: 15.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child:
                            photoURL != null
                                ? Image.network(
                                  photoURL,
                                  fit: BoxFit.cover,
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
                                        color: Colors.white.withOpacity(0.1),
                                        child: Center(
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.white,
                                            size: 10.w,
                                          ),
                                        ),
                                      ),
                                )
                                : Container(
                                  color: Colors.white.withOpacity(0.1),
                                  child: Center(
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 10.w,
                                    ),
                                  ),
                                ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      displayName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      email,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(user) {
    final phone = user?.phoneNumber ?? 'Not set';
    final joined = user?.metadata.creationTime;
    final joinedDate =
        joined != null
            ? '${joined.month}/${joined.day}/${joined.year}'
            : 'Unknown';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoCard(
          icon: Icons.phone_outlined,
          label: 'Phone Number',
          value: phone,
        ),
        SizedBox(height: 2.h),
        _buildInfoCard(
          icon: Icons.calendar_today_outlined,
          label: 'Member Since',
          value: joinedDate,
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
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
            offset: const Offset(0, 4),
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
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, ProfileProvider provider) {
    return Column(
      children: [
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
              onTap: () => _showLogoutConfirmation(context, provider),
              borderRadius: BorderRadius.circular(16),
              splashColor: Colors.red.withOpacity(0.1),
              highlightColor: Colors.red.withOpacity(0.05),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout_outlined,
                      color: Colors.red.shade300,
                      size: 6.w,
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      'LOGOUT',
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

  void _showLogoutConfirmation(BuildContext context, ProfileProvider provider) {
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
                gradient: const LinearGradient(
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
                    offset: const Offset(0, 10),
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
                      Icons.logout_outlined,
                      color: Colors.white,
                      size: 10.w,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'Are you sure you want to logout?',
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
                            await provider.signOut();
                            Navigator.pushReplacementNamed(context, '/signin');
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 1.5.h),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
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
                                  color: const Color(
                                    0xFFF50057,
                                  ).withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'Logout',
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
