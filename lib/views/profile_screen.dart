// lib/views/profile_screen.dart

// ignore_for_file: use_build_context_synchronously, use_super_parameters

import 'package:cloud_mart/views/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../services/auth_service.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Widget _InfoCard({required IconData icon, required String title, required String subtitle}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 1.h),
      child: ListTile(
        leading: Icon(icon, size: 6.w),
        title: Text(title, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 12.sp, color: Colors.grey[700])),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);
    final user = auth.currentUser;
    final display = user?.displayName ?? 'Your Name';
    final email = user?.email ?? 'you@example.com';
    final photo = user?.photoURL;
    final phone = user?.phoneNumber ?? 'Not set';
    final joined = user?.metadata.creationTime;

    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar and background
              Container(
                width: double.infinity,
                height: 25.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade400, Colors.blue.shade800],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(4.w),
                ),
                child: Center(
                  child: CircleAvatar(
                    radius: 8.h,
                    backgroundColor: Colors.white,
                    backgroundImage: photo != null
                        ? NetworkImage(photo)
                        : const AssetImage('assets/images/placeholder.png')
                            as ImageProvider,
                  ),
                ),
              ),
              SizedBox(height: 4.h),

              Text(display, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 1.h),
              Text(email, style: TextStyle(fontSize: 12.sp, color: Colors.grey[700])),
              SizedBox(height: 4.h),

              _InfoCard(icon: Icons.phone, title: 'Phone', subtitle: phone),
              SizedBox(height: 2.h),
              _InfoCard(
                icon: Icons.calendar_today,
                title: 'Member Since',
                subtitle: joined != null
                    ? '${joined.month}/${joined.day}/${joined.year}'
                    : 'Unknown',
              ),
              SizedBox(height: 6.h),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit Profile'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.w),
                        ),
                      ),
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                        );
                        if (result == true) {
                          setState(() {}); 
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.logout),
                      label: const Text('Logout'),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.w),
                        ),
                        side: BorderSide(color: Theme.of(context).colorScheme.error),
                      ),
                      onPressed: () async {
                        await auth.signOut();
                        Navigator.pushReplacementNamed(context, '/signin');
                      },
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
