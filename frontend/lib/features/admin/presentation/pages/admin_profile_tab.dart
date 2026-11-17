import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_cubit.dart';

class AdminProfileTab extends StatefulWidget {
  const AdminProfileTab({super.key});

  @override
  State<AdminProfileTab> createState() => _AdminProfileTabState();
}

class _AdminProfileTabState extends State<AdminProfileTab> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E1F22) : AppColors.lightSurface;
    final textColor = isDark ? Colors.white : AppColors.lightTextDark;
    final titleColor = isDark ? Colors.white : AppColors.primaryNavy;
    final bgColor = isDark ? const Color(0xFF121417) : AppColors.lightBackground;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Admin Profile',
          style: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
        ),
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
                color: titleColor,
              ),
            ),
            Text(
              'boss@icebocleaning.com',
              style: GoogleFonts.dmSans(
                fontSize: 16,
                color: isDark ? Colors.white70 : AppColors.lightTextGrey,
              ),
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
                    ListTile(
                      leading: Icon(LucideIcons.user, color: textColor),
                      title: Text('Personal Information', style: GoogleFonts.dmSans(color: textColor)),
                      trailing: Icon(LucideIcons.chevronRight, size: 20, color: textColor),
                      onTap: () {},
                    ),
                    Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
                    ListTile(
                      leading: Icon(LucideIcons.lock, color: textColor),
                      title: Text('Change Password', style: GoogleFonts.dmSans(color: textColor)),
                      trailing: Icon(LucideIcons.chevronRight, size: 20, color: textColor),
                      onTap: () {},
                    ),
                    Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
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
                      leading: Icon(LucideIcons.bell, color: textColor),
                      title: Text('System Notifications', style: GoogleFonts.dmSans(color: textColor)),
                      trailing: Switch(
                        value: _notificationsEnabled,
                        onChanged: (val) => setState(() => _notificationsEnabled = val),
                        activeColor: AppColors.accentDarkGreen,
                      ),
                      onTap: () => setState(() => _notificationsEnabled = !_notificationsEnabled),
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