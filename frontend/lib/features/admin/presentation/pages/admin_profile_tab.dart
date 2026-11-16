import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';

class AdminProfileTab extends StatelessWidget {
  const AdminProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Admin Profile',
          style: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryNavy,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.settings, color: AppColors.primaryNavy),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.primaryNavy,
              child: Text(
                'B',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Bongani Nkosi',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryNavy,
              ),
            ),
            Text(
              'boss@icebocleaning.com',
              style: GoogleFonts.dmSans(
                fontSize: 16,
                color: AppColors.lightTextGrey,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: AppColors.lightSurface,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.primaryNavy.withOpacity(0.1)),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(LucideIcons.user, color: AppColors.primaryNavy),
                    title: Text('Personal Information', style: GoogleFonts.dmSans()),
                    trailing: const Icon(LucideIcons.chevronRight, size: 20),
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(LucideIcons.lock, color: AppColors.primaryNavy),
                    title: Text('Change Password', style: GoogleFonts.dmSans()),
                    trailing: const Icon(LucideIcons.chevronRight, size: 20),
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(LucideIcons.bell, color: AppColors.primaryNavy),
                    title: Text('System Notifications', style: GoogleFonts.dmSans()),
                    trailing: Switch(
                      value: true,
                      onChanged: (val) {},
                      activeColor: AppColors.accentDarkGreen,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}