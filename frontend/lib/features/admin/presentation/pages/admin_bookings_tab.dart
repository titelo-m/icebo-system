import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../bloc/admin_bloc.dart';
import '../../bloc/admin_event.dart';
import '../../bloc/admin_state.dart';

class AdminBookingsTab extends StatelessWidget {
  const AdminBookingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Manage Bookings',
          style: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryNavy,
          ),
        ),
      ),
      body: BlocBuilder<AdminBloc, AdminState>(
        builder: (context, state) {
          if (state is AdminLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AdminLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: state.bookings.length,
              itemBuilder: (context, index) {
                final booking = state.bookings[index];
                return _BookingAdminCard(booking: booking);
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class _BookingAdminCard extends StatelessWidget {
  final Map<String, dynamic> booking;

  const _BookingAdminCard({required this.booking});

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Scheduled':
        return Colors.blue;
      case 'In Progress':
        return Colors.purple;
      case 'Completed':
        return AppColors.accentDarkGreen;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(booking['status']);

    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: AppColors.primaryNavy.withOpacity(0.1)),
      ),
      color: AppColors.lightSurface,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  booking['id'],
                  style: GoogleFonts.spaceGrotesk(
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightTextGrey,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    booking['status'],
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              booking['service'],
              style: GoogleFonts.dmSans(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryNavy,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(LucideIcons.user, size: 16, color: AppColors.lightTextGrey),
                const SizedBox(width: 5),
                Text(
                  booking['customer'],
                  style: GoogleFonts.dmSans(color: AppColors.lightTextGrey),
                ),
                const SizedBox(width: 15),
                const Icon(LucideIcons.calendar, size: 16, color: AppColors.lightTextGrey),
                const SizedBox(width: 5),
                Text(
                  booking['date'],
                  style: GoogleFonts.dmSans(color: AppColors.lightTextGrey),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(LucideIcons.mapPin, size: 16, color: AppColors.lightTextGrey),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    booking['address'],
                    style: GoogleFonts.dmSans(color: AppColors.lightTextGrey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'R ${booking['amount'].toStringAsFixed(2)}',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryNavy,
                  ),
                ),
                DropdownButton<String>(
                  value: booking['status'],
                  underline: const SizedBox(),
                  icon: const Icon(LucideIcons.chevronDown),
                  items: const [
                    DropdownMenuItem(value: 'Pending', child: Text('Pending')),
                    DropdownMenuItem(value: 'Scheduled', child: Text('Scheduled')),
                    DropdownMenuItem(value: 'In Progress', child: Text('In Progress')),
                    DropdownMenuItem(value: 'Completed', child: Text('Completed')),
                  ],
                  onChanged: (newStatus) {
                    if (newStatus != null) {
                      context.read<AdminBloc>().add(
                        UpdateBookingStatus(
                          bookingId: booking['id'],
                          newStatus: newStatus,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}