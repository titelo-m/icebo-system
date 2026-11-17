import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';

class BookingsTab extends StatelessWidget {
  const BookingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF121417) : AppColors.lightBackground;
    final surfaceColor = isDark ? const Color(0xFF1E1F22) : AppColors.lightSurface;
    final titleColor = isDark ? Colors.white : AppColors.primaryNavy;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'My Bookings',
          style: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _BookingCard(
            date: '24 Oct 2026',
            service: 'Commercial Cleaning',
            status: 'Upcoming',
            statusColor: AppColors.accentDarkGreen,
            icon: LucideIcons.building,
            surfaceColor: surfaceColor,
            titleColor: titleColor,
            isDark: isDark,
          ),
          const SizedBox(height: 15),
          _BookingCard(
            date: '12 Sep 2026',
            service: 'Laundry Services',
            status: 'Completed',
            statusColor: Colors.grey,
            icon: LucideIcons.washingMachine,
            surfaceColor: surfaceColor,
            titleColor: titleColor,
            isDark: isDark,
          ),
        ],
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  final String date;
  final String service;
  final String status;
  final Color statusColor;
  final IconData icon;
  final Color surfaceColor;
  final Color titleColor;
  final bool isDark;

  const _BookingCard({
    required this.date,
    required this.service,
    required this.status,
    required this.statusColor,
    required this.icon,
    required this.surfaceColor,
    required this.titleColor,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: isDark ? Colors.white10 : AppColors.primaryNavy.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: titleColor, size: 30),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  date,
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    color: isDark ? Colors.white70 : AppColors.lightTextGrey,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: GoogleFonts.dmSans(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}