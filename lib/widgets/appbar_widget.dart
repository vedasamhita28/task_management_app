import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_management_app/constants/colors.dart';
import 'package:task_management_app/widgets/primary_button.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool backArraw;
  // final bool logout;

  AppbarWidget({
    super.key,
    required this.title,
    this.backArraw = false,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryBgColor,
        title: Stack(
          alignment: Alignment.center,
          children: [
            if (backArraw)
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: Icon(Icons.arrow_back_ios,
                      size: 20, color: AppColors.primaryBlue),
                ),
              ),
            Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (!backArraw)
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.logout, color: AppColors.primaryBlue),
                  onPressed: () {
                    _showLogoutDialog(context);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          PrimaryButton(
            fontSize: 12,
            height: 30,
            width: 60,
            onPressed: () => Navigator.of(context).pop(), // close dialog
            text: 'Cancel',
          ),
          PrimaryButton(
            fontSize: 12,
            height: 30,
            width: 60,
            onPressed: () async{
               await FirebaseAuth.instance.signOut();
              Navigator.of(context).pop(); 
              context.go('/welcome');
            },
            text: 'Yes',
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
