import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../bloc/admin_bloc.dart';
import '../../bloc/admin_state.dart';

class AdminUsersTab extends StatelessWidget {
  const AdminUsersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Manage Users',
          style: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryNavy,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(LucideIcons.plus, size: 18),
              label: const Text('Add User'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryNavy,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<AdminBloc, AdminState>(
        builder: (context, state) {
          if (state is AdminLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AdminLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                final isEmployee = user['role'] == 'Employee';
                
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: AppColors.primaryNavy.withOpacity(0.1)),
                  ),
                  color: AppColors.lightSurface,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    leading: CircleAvatar(
                      backgroundColor: isEmployee 
                          ? AppColors.accentDarkGreen.withOpacity(0.1) 
                          : AppColors.primaryNavy.withOpacity(0.1),
                      child: Icon(
                        isEmployee ? LucideIcons.briefcase : LucideIcons.user,
                        color: isEmployee ? AppColors.accentDarkGreen : AppColors.primaryNavy,
                      ),
                    ),
                    title: Text(
                      user['name'],
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.primaryNavy,
                      ),
                    ),
                    subtitle: Text(
                      user['email'],
                      style: GoogleFonts.dmSans(color: AppColors.lightTextGrey),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isEmployee 
                            ? AppColors.accentDarkGreen.withOpacity(0.1) 
                            : Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        user['role'],
                        style: GoogleFonts.dmSans(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isEmployee ? AppColors.accentDarkGreen : Colors.blue,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}