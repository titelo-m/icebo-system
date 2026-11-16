import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../dashboard/presentation/widgets/book_service_modal.dart';
import '../../bloc/admin_bloc.dart';
import '../../bloc/admin_state.dart';

class AdminOverviewTab extends StatelessWidget {
  const AdminOverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Admin Overview',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome, Boss!',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryNavy,
                            ),
                          ),
                          Text(
                            'Here is the overall performance of Icebo Cleaning.',
                            style: GoogleFonts.dmSans(
                              fontSize: 16,
                              color: AppColors.lightTextGrey,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => const BookServiceModal(),
                          );
                        },
                        icon: const Icon(LucideIcons.plus, size: 18),
                        label: const Text('Walk-in Booking'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentDarkGreen,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(
                        child: _AdminStatCard(
                          title: 'Total Revenue',
                          value: 'R ${totalRevenue.toStringAsFixed(2)}',
                          icon: LucideIcons.wallet,
                          color: AppColors.accentDarkGreen,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _AdminStatCard(
                          title: 'Pending Bookings',
                          value: '$pendingBookings',
                          icon: LucideIcons.clock,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _AdminStatCard(
                          title: 'Completed',
                          value: '$completedBookings',
                          icon: LucideIcons.checkCircle,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Recent Activity',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryNavy,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.bookings.length,
                    itemBuilder: (context, index) {
                      final booking = state.bookings[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.grey.withOpacity(0.2)),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppColors.primaryNavy.withOpacity(0.1),
                            child: const Icon(LucideIcons.calendar, color: AppColors.primaryNavy),
                          ),
                          title: Text(
                            booking['service'],
                            style: GoogleFonts.dmSans(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${booking['customer']} - ${booking['date']}',
                            style: GoogleFonts.dmSans(color: AppColors.lightTextGrey),
                          ),
                          trailing: Text(
                            'R ${booking['amount']}',
                            style: GoogleFonts.spaceGrotesk(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryNavy,
                            ),
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

  const _AdminStatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

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
          Icon(icon, color: color, size: 30),
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