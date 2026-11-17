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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF121417) : AppColors.lightBackground;
    final titleColor = isDark ? Colors.white : AppColors.primaryNavy;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Manage Bookings',
          style: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.bold,
            color: titleColor,
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
                return _BookingAdminCard(booking: booking, isDark: isDark);
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
  final bool isDark;

  const _BookingAdminCard({required this.booking, required this.isDark});

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
    final surfaceColor = isDark ? const Color(0xFF1E1F22) : AppColors.lightSurface;
    final titleColor = isDark ? Colors.white : AppColors.primaryNavy;
    final greyColor = isDark ? Colors.white70 : AppColors.lightTextGrey;

    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Colors.grey.withOpacity(0.2)),
      ),
      color: surfaceColor,
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
                    color: greyColor,
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
                color: titleColor,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(LucideIcons.user, size: 16, color: greyColor),
                const SizedBox(width: 5),
                Text(
                  booking['customer'],
                  style: GoogleFonts.dmSans(color: greyColor),
                ),
                const SizedBox(width: 15),
                Icon(LucideIcons.calendar, size: 16, color: greyColor),
                const SizedBox(width: 5),
                Text(
                  booking['date'],
                  style: GoogleFonts.dmSans(color: greyColor),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(LucideIcons.mapPin, size: 16, color: greyColor),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    booking['address'],
                    style: GoogleFonts.dmSans(color: greyColor),
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
                    color: titleColor,
                  ),
                ),
                DropdownButton<String>(
                  value: booking['status'],
                  dropdownColor: surfaceColor,
                  style: GoogleFonts.dmSans(color: titleColor),
                  underline: const SizedBox(),
                  icon: Icon(LucideIcons.chevronDown, color: titleColor),
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