import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';

import 'overview_tab.dart';
import 'bookings_tab.dart';
import 'profile_tab.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = [
    const OverviewTab(),
    const BookingsTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: Row(
        children: [
          if (isDesktop)
            Container(
              width: 250,
              color: AppColors.primaryNavy,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                      children: const [
                        TextSpan(text: 'Icebo', style: TextStyle(color: Colors.white)),
                        TextSpan(text: 'Cleaning', style: TextStyle(color: AppColors.accentDarkGreen)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  _SidebarItem(
                    icon: LucideIcons.layoutDashboard,
                    title: 'Overview',
                    isSelected: _selectedIndex == 0,
                    onTap: () => setState(() => _selectedIndex = 0),
                  ),
                  _SidebarItem(
                    icon: LucideIcons.calendar,
                    title: 'My Bookings',
                    isSelected: _selectedIndex == 1,
                    onTap: () => setState(() => _selectedIndex = 1),
                  ),
                  _SidebarItem(
                    icon: LucideIcons.user,
                    title: 'Profile',
                    isSelected: _selectedIndex == 2,
                    onTap: () => setState(() => _selectedIndex = 2),
                  ),
                  const Spacer(),
                  _SidebarItem(
                    icon: LucideIcons.logOut,
                    title: 'Logout',
                    isSelected: false,
                    onTap: () => context.go('/login'),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          Expanded(
            child: _tabs[_selectedIndex],
          ),
        ],
      ),
      bottomNavigationBar: isDesktop
          ? null
          : BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) => setState(() => _selectedIndex = index),
              selectedItemColor: AppColors.accentDarkGreen,
              unselectedItemColor: AppColors.lightTextGrey,
              backgroundColor: AppColors.lightSurface,
              items: const [
                BottomNavigationBarItem(icon: Icon(LucideIcons.layoutDashboard), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(LucideIcons.calendar), label: 'Bookings'),
                BottomNavigationBarItem(icon: Icon(LucideIcons.user), label: 'Profile'),
              ],
            ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accentDarkGreen.withOpacity(0.2) : Colors.transparent,
          border: Border(
            left: BorderSide(
              color: isSelected ? AppColors.accentDarkGreen : Colors.transparent,
              width: 4,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.accentDarkGreen : Colors.white70,
              size: 20,
            ),
            const SizedBox(width: 15),
            Text(
              title,
              style: GoogleFonts.dmSans(
                color: isSelected ? AppColors.accentDarkGreen : Colors.white70,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}