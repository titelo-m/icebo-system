import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        context.go('/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Very dark, almost black but reflective grey
      backgroundColor: const Color(0xFF121417), 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.03), // Reflective feel
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.08), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accentDarkGreen.withOpacity(0.1),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              // LAUNDRY ICON AS REQUESTED
              child: const Icon(
                LucideIcons.washingMachine, 
                size: 80,
                color: AppColors.accentDarkGreen,
              ),
            ),
            const SizedBox(height: 30),
            RichText(
              text: TextSpan(
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1.5,
                ),
                children: const [
                  TextSpan(
                    text: 'Icebo',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextSpan(
                    text: 'Cleaning',
                    style: TextStyle(color: AppColors.accentDarkGreen),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(
              color: AppColors.accentDarkGreen,
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}