import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_cubit.dart';

class EmployeeProfileTab extends StatelessWidget {
  const EmployeeProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E1F22) : AppColors.lightSurface;
    final textColor = isDark ? Colors.white : AppColors.lightTextDark;
    final titleColor = isDark ? Colors.white : AppColors.primaryNavy;
    final greyColor = isDark ? Colors.white70 : AppColors.lightTextGrey;
    final bgColor = isDark ? const Color(0xFF121417) : AppColors.lightBackground;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Worker Profile',
          style: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(LucideIcons.edit, color: titleColor),
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
                color: titleColor,
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
                      color: cardColor,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '18',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: titleColor,
                          ),
                        ),
                        Text(
                          'Jobs Completed',
                          style: GoogleFonts.dmSans(color: greyColor),
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
                      color: cardColor,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
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
                          style: GoogleFonts.dmSans(color: greyColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Material(
              color: cardColor,
              borderRadius: BorderRadius.circular(15),
              clipBehavior: Clip.antiAlias,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                ),
                child: Column(
                  children: [
                    _DetailRow(icon: LucideIcons.phone, label: 'Phone', value: '071 234 5678', textColor: textColor, greyColor: greyColor),
                    Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
                    _DetailRow(icon: LucideIcons.mail, label: 'Email', value: 'john@icebo.com', textColor: textColor, greyColor: greyColor),
                    Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
                    _DetailRow(icon: LucideIcons.mapPin, label: 'Address', value: '123 Main St, Emalahleni', textColor: textColor, greyColor: greyColor),
                    Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
                    _DetailRow(icon: LucideIcons.shieldAlert, label: 'Emergency Contact', value: 'Mary Doe (Wife) - 082 345 6789', textColor: textColor, greyColor: greyColor),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Material(
              color: cardColor,
              borderRadius: BorderRadius.circular(15),
              clipBehavior: Clip.antiAlias,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(LucideIcons.moon, color: textColor),
                      title: Text('Dark Mode', style: GoogleFonts.dmSans(color: textColor)),
                      trailing: BlocBuilder<ThemeCubit, ThemeMode>(
                        builder: (context, themeMode) {
                          return Switch(
                            value: themeMode == ThemeMode.dark,
                            onChanged: (val) {
                              context.read<ThemeCubit>().toggleTheme(val);
                            },
                            activeColor: AppColors.accentDarkGreen,
                          );
                        },
                      ),
                      onTap: () {
                        final currentMode = context.read<ThemeCubit>().state;
                        context.read<ThemeCubit>().toggleTheme(currentMode != ThemeMode.dark);
                      },
                    ),
                    Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
                    ListTile(
                      leading: Icon(LucideIcons.lock, color: textColor),
                      title: Text('Change Password', style: GoogleFonts.dmSans(color: textColor)),
                      trailing: Icon(LucideIcons.chevronRight, size: 20, color: textColor),
                      onTap: () {},
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

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color textColor;
  final Color greyColor;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.textColor,
    required this.greyColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: textColor, size: 20),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: GoogleFonts.dmSans(fontSize: 12, color: greyColor)),
                Text(value, style: GoogleFonts.dmSans(fontSize: 16, color: textColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}