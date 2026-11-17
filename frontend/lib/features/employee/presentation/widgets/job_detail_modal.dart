import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';

class JobDetailModal extends StatelessWidget {
  final Map<String, dynamic> job;
  final VoidCallback onUpdateStatus;

  const JobDetailModal({
    super.key,
    required this.job,
    required this.onUpdateStatus,
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Scheduled':
        return Colors.blue;
      case 'In Progress':
        return Colors.orange;
      case 'Completed':
        return AppColors.accentDarkGreen;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1E1F22) : Colors.white;
    final textColor = isDark ? Colors.white : AppColors.primaryNavy;
    final greyColor = isDark ? Colors.white70 : AppColors.lightTextGrey;
    final statusColor = _getStatusColor(job['status']);

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                job['id'],
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  job['status'],
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            job['service'],
            style: GoogleFonts.dmSans(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          Divider(height: 30, color: Colors.grey.withOpacity(0.2)),
          
          _DetailRow(icon: LucideIcons.user, label: 'Customer', value: job['customer'], textColor: textColor, greyColor: greyColor),
          _DetailRow(icon: LucideIcons.phone, label: 'Phone', value: '071 234 5678', textColor: textColor, greyColor: greyColor),
          _DetailRow(icon: LucideIcons.mapPin, label: 'Address', value: job['address'], textColor: textColor, greyColor: greyColor),
          _DetailRow(icon: LucideIcons.calendar, label: 'Date & Time', value: '${job['date']} at ${job['time']}', textColor: textColor, greyColor: greyColor),
          
          if (job['notes'] != null && job['notes'].isNotEmpty) ...[
            const SizedBox(height: 20),
            Text(
              'Special Instructions',
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.amber.withOpacity(0.3)),
              ),
              child: Text(
                job['notes'],
                style: GoogleFonts.dmSans(
                  color: isDark ? Colors.amber : Colors.brown,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],

          const Spacer(),

          if (job['status'] == 'Scheduled')
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  onUpdateStatus();
                  Navigator.pop(context);
                },
                icon: const Icon(LucideIcons.play),
                label: const Text('Start Job'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
          if (job['status'] == 'In Progress')
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  onUpdateStatus();
                  Navigator.pop(context);
                },
                icon: const Icon(LucideIcons.check),
                label: const Text('Complete Job'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentDarkGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
          if (job['status'] == 'Completed')
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: Text('Close', style: TextStyle(color: textColor)),
              ),
            ),
          const SizedBox(height: 10),
        ],
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

  const _DetailRow({required this.icon, required this.label, required this.value, required this.textColor, required this.greyColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: greyColor, size: 20),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.dmSans(fontSize: 12, color: greyColor),
                ),
                Text(
                  value,
                  style: GoogleFonts.dmSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}