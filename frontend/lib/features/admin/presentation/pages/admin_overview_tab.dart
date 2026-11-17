import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../bloc/admin_bloc.dart';
import '../../bloc/admin_state.dart';

class AdminOverviewTab extends StatelessWidget {
  const AdminOverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF121417) : AppColors.lightBackground;
    final surfaceColor = isDark ? const Color(0xFF1E1F22) : AppColors.lightSurface;
    final titleColor = isDark ? Colors.white : AppColors.primaryNavy;
    final greyColor = isDark ? Colors.white70 : AppColors.lightTextGrey;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Admin Overview',
          style: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(LucideIcons.bell, color: titleColor),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: BlocBuilder<AdminBloc, AdminState>(
        builder: (context, state) {
          if (state is AdminLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AdminLoaded) {
            final totalRevenue = state.bookings.fold(0.0, (sum, item) => sum + (item['amount'] as double));
            final pendingBookings = state.bookings.where((b) => b['status'] == 'Pending').length;
            final completedBookings = state.bookings.where((b) => b['status'] == 'Completed').length;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, Boss!',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: titleColor,
                    ),
                  ),
                  Text(
                    'Here is the overall performance of Icebo Cleaning.',
                    style: GoogleFonts.dmSans(
                      fontSize: 16,
                      color: greyColor,
                    ),
                  ),
                  const SizedBox(height: 25),

                  Wrap(
                    spacing: 15,
                    runSpacing: 15,
                    children: [
                      _AdminStatCard(
                        title: 'Total Revenue',
                        value: 'R ${totalRevenue.toStringAsFixed(2)}',
                        icon: LucideIcons.wallet,
                        color: AppColors.accentDarkGreen,
                        surfaceColor: surfaceColor,
                        titleColor: titleColor,
                        greyColor: greyColor,
                      ),
                      _AdminStatCard(
                        title: 'Pending Bookings',
                        value: '$pendingBookings',
                        icon: LucideIcons.clock,
                        color: Colors.orange,
                        surfaceColor: surfaceColor,
                        titleColor: titleColor,
                        greyColor: greyColor,
                      ),
                      _AdminStatCard(
                        title: 'Completed',
                        value: '$completedBookings',
                        icon: LucideIcons.checkCircle,
                        color: Colors.blue,
                        surfaceColor: surfaceColor,
                        titleColor: titleColor,
                        greyColor: greyColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  Text(
                    'Business Reports',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: titleColor,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Wrap(
                    spacing: 15,
                    runSpacing: 15,
                    children: [
                      _ReportButton(
                        icon: LucideIcons.fileDown,
                        title: 'Export Monthly PDF',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Generating Monthly PDF Report...')),
                          );
                        },
                        isDark: isDark,
                      ),
                      _ReportButton(
                        icon: LucideIcons.trendingUp,
                        title: 'View Weekly Insights',
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Loading Weekly Insights...')),
                          );
                        },
                        isDark: isDark,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  Text(
                    'Recent Activity',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: titleColor,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.bookings.length,
                    itemBuilder: (context, index) {
                      final booking = state.bookings[index];
                      final isWalkIn = index % 2 == 0;

                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.grey.withOpacity(0.2)),
                        ),
                        color: surfaceColor,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: isDark ? Colors.white10 : AppColors.primaryNavy.withOpacity(0.1),
                                child: Icon(LucideIcons.calendar, color: titleColor),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      booking['service'],
                                      style: GoogleFonts.dmSans(
                                        fontWeight: FontWeight.bold,
                                        color: titleColor,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${booking['customer']} • ${booking['address']}',
                                      style: GoogleFonts.dmSans(
                                        fontSize: 12,
                                        color: greyColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: isWalkIn ? Colors.purple.withOpacity(0.1) : Colors.blue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  isWalkIn ? 'Walk-in' : 'Online',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: isWalkIn ? Colors.purple : Colors.blue,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Text(
                                'R ${booking['amount']}',
                                style: GoogleFonts.spaceGrotesk(
                                  fontWeight: FontWeight.bold,
                                  color: titleColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class _AdminStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final Color surfaceColor;
  final Color titleColor;
  final Color greyColor;

  const _AdminStatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.surfaceColor,
    required this.titleColor,
    required this.greyColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 15),
          Text(
            value,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: GoogleFonts.dmSans(
              fontSize: 14,
              color: greyColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDark;

  const _ReportButton({
    required this.icon,
    required this.title,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: isDark ? AppColors.accentDarkGreen : AppColors.primaryNavy,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Text(
              title,
              style: GoogleFonts.dmSans(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}