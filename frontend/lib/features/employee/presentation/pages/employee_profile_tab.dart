import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';

class EmployeeProfileTab extends StatelessWidget {
  const EmployeeProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Worker Profile',
          style: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryNavy,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.edit, color: AppColors.primaryNavy),
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
                'J',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'John Doe',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryNavy,
              ),
            ),
            Text(
              'EMP001',
              style: GoogleFonts.dmSans(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.accentDarkGreen,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColors.lightSurface,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: AppColors.primaryNavy.withOpacity(0.1)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '18',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryNavy,
                          ),
                        ),
                        Text(
                          'Jobs Completed',
                          style: GoogleFonts.dmSans(color: AppColors.lightTextGrey),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColors.lightSurface,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: AppColors.primaryNavy.withOpacity(0.1)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '4.9',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.accentDarkGreen,
                          ),
                        ),
                        Text(
                          'Rating',
                          style: GoogleFonts.dmSans(color: AppColors.lightTextGrey),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
                  _DetailRow(icon: LucideIcons.phone, label: 'Phone', value: '071 234 5678'),
                  const Divider(height: 1),
                  _DetailRow(icon: LucideIcons.mail, label: 'Email', value: 'john@icebo.com'),
                  const Divider(height: 1),
                  _DetailRow(icon: LucideIcons.mapPin, label: 'Address', value: '123 Main St, Emalahleni'),
                  const Divider(height: 1),
                  _DetailRow(icon: LucideIcons.shieldAlert, label: 'Emergency Contact', value: 'Mary Doe (Wife) - 082 345 6789'),
                  const Divider(height: 1),
                  _DetailRow(icon: LucideIcons.briefcase, label: 'Department', value: 'Field Operations'),
                ],
              ),
            ),
            const SizedBox(height: 20),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryNavy, size: 20),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.lightTextGrey),
                ),
                Text(
                  value,
                  style: GoogleFonts.dmSans(fontSize: 16, color: AppColors.lightTextDark),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}