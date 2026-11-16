import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/book_service_modal.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Dashboard',
          style: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryNavy,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.bell, color: AppColors.primaryNavy),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${_getGreeting()}, Titelo!',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryNavy,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Here is an overview of your cleaning services.',
              style: GoogleFonts.dmSans(
                fontSize: 16,
                color: AppColors.lightTextGrey,
              ),
            ),
            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: AppColors.primaryNavy,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryNavy.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Need a clean space?',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Book a new service and we will handle the rest.',
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => const BookServiceModal(),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accentDarkGreen,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Book Now'),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    LucideIcons.calendarPlus,
                    size: 70,
                    color: AppColors.accentDarkGreen,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            Text(
              'Next Upcoming Service',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryNavy,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.lightSurface,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.primaryNavy.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColors.accentDarkGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(LucideIcons.building, color: AppColors.accentDarkGreen, size: 30),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Commercial Cleaning',
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.primaryNavy,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '24 Oct 2026 at 09:00 AM',
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            color: AppColors.lightTextGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.accentDarkGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Upcoming',
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accentDarkGreen,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            Text(
              'Quick Actions',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryNavy,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: _QuickActionCard(
                    icon: LucideIcons.calendar,
                    title: 'My\nBookings',
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _QuickActionCard(
                    icon: LucideIcons.fileText,
                    title: 'Invoices',
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _QuickActionCard(
                    icon: LucideIcons.headphones,
                    title: 'Support',
                    onTap: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Total Cleanings',
                    value: '12',
                    icon: LucideIcons.checkCircle,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _StatCard(
                    title: 'Total Spent',
                    value: 'R 4,800',
                    icon: LucideIcons.wallet,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.lightSurface,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.primaryNavy.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primaryNavy, size: 30),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryNavy,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({required this.title, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.primaryNavy.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.accentDarkGreen, size: 30),
          const SizedBox(height: 15),
          Text(
            value,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryNavy,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: GoogleFonts.dmSans(
              fontSize: 14,
              color: AppColors.lightTextGrey,
            ),
          ),
        ],
      ),
    );
  }
}