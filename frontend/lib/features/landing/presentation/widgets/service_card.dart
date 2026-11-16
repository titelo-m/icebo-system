import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final IconData icon;
  
  const ServiceCard({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.lightSurface,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: AppColors.primaryNavy.withOpacity(0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon, 
              size: 40, 
              color: AppColors.primaryNavy, 
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.w600,
                  color: AppColors.lightTextDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}