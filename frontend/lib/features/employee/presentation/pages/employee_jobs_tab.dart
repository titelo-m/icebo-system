import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../dashboard/presentation/widgets/book_service_modal.dart';
import '../widgets/job_detail_modal.dart';
import '../../bloc/employee_bloc.dart';
import '../../bloc/employee_event.dart';
import '../../bloc/employee_state.dart';

class EmployeeJobsTab extends StatelessWidget {
  const EmployeeJobsTab({super.key});

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
          'My Assigned Jobs',
          style: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: ElevatedButton.icon(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const BookServiceModal(),
                );
              },
              icon: const Icon(LucideIcons.plus, size: 18),
              label: const Text('Walk-in'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentDarkGreen,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is EmployeeJobsLoaded) {
            if (state.jobs.isEmpty) {
              return Center(child: Text('No jobs assigned yet.', style: TextStyle(color: titleColor)));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: state.jobs.length,
              itemBuilder: (context, index) {
                final job = state.jobs[index];
                return _JobCard(job: job, isDark: isDark);
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
  final bool isDark;

  const _JobCard({required this.job, required this.isDark});

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
    final surfaceColor = isDark ? const Color(0xFF1E1F22) : AppColors.lightSurface;
    final titleColor = isDark ? Colors.white : AppColors.primaryNavy;
    final greyColor = isDark ? Colors.white70 : AppColors.lightTextGrey;

    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (modalContext) => JobDetailModal(
            job: job,
            onUpdateStatus: () {
              if (job['status'] == 'Scheduled') {
                context.read<EmployeeBloc>().add(
                  UpdateJobStatus(jobId: job['id'], newStatus: 'In Progress'),
                );
              } else if (job['status'] == 'In Progress') {
                context.read<EmployeeBloc>().add(
                  UpdateJobStatus(jobId: job['id'], newStatus: 'Completed'),
                );
              }
            },
          ),
        );
      },
      borderRadius: BorderRadius.circular(15),
      child: Card(
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
                    job['id'],
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
                  color: titleColor,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Icon(LucideIcons.user, size: 16, color: greyColor),
                  const SizedBox(width: 5),
                  Text(
                    job['customer'],
                    style: GoogleFonts.dmSans(color: greyColor),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Icon(LucideIcons.clock, size: 16, color: greyColor),
                  const SizedBox(width: 5),
                  Text(
                    '${job['date']} at ${job['time']}',
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
                      job['address'],
                      style: GoogleFonts.dmSans(color: greyColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (job['status'] == 'Scheduled')
                    Text(
                      'Tap to Start',
                      style: GoogleFonts.dmSans(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (job['status'] == 'In Progress')
                    Text(
                      'Tap to Complete',
                      style: GoogleFonts.dmSans(
                        color: AppColors.accentDarkGreen,
                        fontWeight: FontWeight.bold,
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
      ),
    );
  }
}