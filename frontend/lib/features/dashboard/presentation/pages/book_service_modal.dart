import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';

class BookServiceModal extends StatefulWidget {
  const BookServiceModal({super.key});

  @override
  State<BookServiceModal> createState() => _BookServiceModalState();
}

class _BookServiceModalState extends State<BookServiceModal> {
  String? _selectedService;

  final List<String> _services = [
    'Commercial Cleaning',
    'Residential Cleaning',
    'Laundry Services',
    'Carpet & Upholstery',
    'Post-Construction',
    'Car Valet',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: AppColors.lightBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
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
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Book a Service',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryNavy,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Fill in the details below to schedule your cleaning.',
            style: GoogleFonts.dmSans(color: AppColors.lightTextGrey),
          ),
          const SizedBox(height: 30),

          // Service Dropdown
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Select Service',
              prefixIcon: const Icon(LucideIcons.sparkles),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: Colors.white,
            ),
            items: _services.map((service) {
              return DropdownMenuItem(
                value: service,
                child: Text(service),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedService = value;
              });
            },
          ),
          const SizedBox(height: 20),

          // Date Picker (Dummy for now)
          TextField(
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Preferred Date',
              prefixIcon: const Icon(LucideIcons.calendar),
              suffixIcon: const Icon(LucideIcons.chevronDown),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: Colors.white,
            ),
            onTap: () async {
              await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
            },
          ),
          const SizedBox(height: 20),

          // Address
          TextField(
            decoration: InputDecoration(
              labelText: 'Service Address',
              prefixIcon: const Icon(LucideIcons.mapPin),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 20),

          // Notes
          TextField(
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Special Instructions (Optional)',
              alignLabelWithHint: true,
              prefixIcon: const Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Icon(LucideIcons.messageSquare),
              ),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const Spacer(),

          // Submit Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Booking Request Sent Successfully!'),
                    backgroundColor: AppColors.accentDarkGreen,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryNavy,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Confirm Booking', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}