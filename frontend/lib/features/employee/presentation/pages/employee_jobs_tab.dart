import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../bloc/employee_bloc.dart';
import '../../bloc/employee_event.dart';
import '../../bloc/employee_state.dart';

class EmployeeJobsTab extends StatelessWidget {
  const EmployeeJobsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'My Assigned Jobs',
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
      body: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is EmployeeJobsLoaded) {
            if (state.jobs.isEmpty) {
              return const Center(child: Text('No jobs assigned yet.'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: state.jobs.length,
              itemBuilder: (context, index) {
                final job = state.jobs[index];
                return _JobCard(job: job);
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  final Map<String, dynamic> job;

  const _JobCard({required this.job});

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
    final statusColor = _getStatusColor(job['status']);

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
                  job['id'],
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
                    job['status'],
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
              job['service'],
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
                  job['customer'],
                  style: GoogleFonts.dmSans(color: AppColors.lightTextGrey),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(LucideIcons.clock, size: 16, color: AppColors.lightTextGrey),
                const SizedBox(width: 5),
                Text(
                  '${job['date']} at ${job['time']}',
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
                    job['address'],
                    style: GoogleFonts.dmSans(color: AppColors.lightTextGrey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            if (job['notes'] != null && job['notes'].isNotEmpty) ...[
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.amber.withOpacity(0.3)),
                ),
                child: Text(
                  'Note: ${job['notes']}',
                  style: GoogleFonts.dmSans(
                    fontSize: 13,
                    color: Colors.brown,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (job['status'] == 'Scheduled')
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<EmployeeBloc>().add(
                        UpdateJobStatus(jobId: job['id'], newStatus: 'In Progress'),
                      );
                    },
                    icon: const Icon(LucideIcons.play, size: 16),
                    label: const Text('Start Job'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                if (job['status'] == 'In Progress')
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<EmployeeBloc>().add(
                        UpdateJobStatus(jobId: job['id'], newStatus: 'Completed'),
                      );
                    },
                    icon: const Icon(LucideIcons.check, size: 16),
                    label: const Text('Complete Job'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentDarkGreen,
                      foregroundColor: Colors.white,
                    ),
                  ),
                if (job['status'] == 'Completed')
                  Text(
                    'Job Done',
                    style: GoogleFonts.dmSans(
                      color: AppColors.accentDarkGreen,
                      fontWeight: FontWeight.bold,
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