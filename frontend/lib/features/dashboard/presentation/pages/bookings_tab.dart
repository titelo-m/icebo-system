import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';

class BookingsTab extends StatelessWidget {
  const BookingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'My Bookings',
          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryNavy),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          _BookingCard(
            date: '24 Oct 2026',
            service: 'Commercial Cleaning',
            status: 'Upcoming',
            statusColor: AppColors.accentDarkGreen,
            icon: LucideIcons.building,
          ),
          SizedBox(height: 15),
          _BookingCard(
            date: '12 Sep 2026',
            service: 'Laundry Services',
            status: 'Completed',
            statusColor: Colors.grey,
            icon: LucideIcons.washingMachine,
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

  const _BookingCard({
    required this.date,
    required this.service,
    required this.status,
    required this.statusColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              color: AppColors.primaryNavy.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primaryNavy, size: 30),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryNavy,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  date,
                  style: const TextStyle(fontSize: 14, color: AppColors.lightTextGrey),
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
              style: TextStyle(
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