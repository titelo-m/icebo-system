import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../bloc/booking_bloc.dart';
import '../../bloc/booking_event.dart';
import '../../bloc/booking_state.dart';

class BookServiceModal extends StatefulWidget {
  const BookServiceModal({super.key});

  @override
  State<BookServiceModal> createState() => _BookServiceModalState();
}

class _BookServiceModalState extends State<BookServiceModal> {
  String? _selectedService;
  String? _selectedSpecificItem;
  double _calculatedPrice = 0.0;
  String _selectedPaymentMethod = 'card';
  
  final _addressController = TextEditingController();
  final _notesController = TextEditingController();
  DateTime? _selectedDate;

  final Map<String, Map<String, double>> _serviceCatalog = {
    'Laundry - Wash, Dry & Fold': {
      'Small basket': 90,
      'Medium basket': 120,
      'Large basket': 190,
    },
    'Laundry - Wash, Dry & Iron': {
      'Small basket': 120,
      'Medium basket': 160,
      'Large basket': 250,
    },
    'Laundry - Iron Only': {
      'Small basket': 60,
      'Medium basket': 90,
      'Large basket': 130,
    },
    'Couch Deep Clean': {
      '1 seater': 300,
      '2 seater': 380,
      '3 seater': 480,
      '4 seater': 600,
      '5 seater': 720,
      '6 seater': 850,
    },
    'Rug Cleaning': {
      'Small rug (1x1.5m)': 120,
      'Normal rug (1.5x2m)': 200,
      '2x3m rug': 250,
      'Large 3x4m rug': 320,
      'Extra large 4x5m': 380,
      'Fitted carpets (per m²)': 40,
    },
    'Mattress Deep Cleaning': {
      'Single bed': 220,
      '3/4 bed': 300,
      'Double bed': 350,
      'Queen bed': 420,
      'King bed': 500,
    },
    'Headboard Cleaning': {
      'Single headboard': 150,
      '3/4 headboard': 170,
      'Double headboard': 200,
      'Queen headboard': 230,
      'King headboard': 250,
    },
    'Blanket Wash Services': {
      '1 ply blanket': 60,
      '2 ply blanket': 80,
      '3 ply blanket': 120,
    },
  };

  @override
  void dispose() {
    _addressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1E1F22) : Colors.white;
    final textColor = isDark ? Colors.white : AppColors.primaryNavy;
    final greyColor = isDark ? Colors.white70 : AppColors.lightTextGrey;
    final inputFillColor = isDark ? Colors.white.withOpacity(0.05) : Colors.white;
    final borderColor = isDark ? Colors.white24 : Colors.grey[300]!;

    return BlocProvider(
      create: (context) => BookingBloc(),
      child: BlocConsumer<BookingBloc, BookingState>(
        listener: (context, state) {
          if (state is BookingSuccess) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppColors.accentDarkGreen),
            );
          }
          if (state is BookingFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.9,
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
                Text(
                  'Book a Service',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Select a service and we will handle the rest.',
                  style: GoogleFonts.dmSans(color: greyColor),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownButtonFormField<String>(
                          dropdownColor: bgColor,
                          style: TextStyle(color: textColor),
                          decoration: InputDecoration(
                            labelText: 'Select Main Service',
                            labelStyle: TextStyle(color: greyColor),
                            prefixIcon: Icon(LucideIcons.building, color: greyColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: borderColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: borderColor),
                            ),
                            filled: true,
                            fillColor: inputFillColor,
                          ),
                          items: _serviceCatalog.keys.map((service) {
                            return DropdownMenuItem(value: service, child: Text(service, style: TextStyle(color: textColor)));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedService = value;
                              _selectedSpecificItem = null;
                              _calculatedPrice = 0.0;
                            });
                          },
                        ),
                        
                        if (_selectedService != null) ...[
                          const SizedBox(height: 20),
                          DropdownButtonFormField<String>(
                            dropdownColor: bgColor,
                            style: TextStyle(color: textColor),
                            decoration: InputDecoration(
                              labelText: 'Select Specific Item',
                              labelStyle: TextStyle(color: greyColor),
                              prefixIcon: Icon(LucideIcons.layers, color: greyColor),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: borderColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: borderColor),
                              ),
                              filled: true,
                              fillColor: inputFillColor,
                            ),
                            items: _serviceCatalog[_selectedService]!.keys.map((item) {
                              return DropdownMenuItem(value: item, child: Text(item, style: TextStyle(color: textColor)));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedSpecificItem = value;
                                _calculatedPrice = _serviceCatalog[_selectedService]![value]!;
                              });
                            },
                          ),
                        ],

                        const SizedBox(height: 20),
                        TextField(
                          readOnly: true,
                          style: TextStyle(color: textColor),
                          controller: TextEditingController(
                            text: _selectedDate == null ? '' : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                          ),
                          decoration: InputDecoration(
                            labelText: 'Preferred Date',
                            labelStyle: TextStyle(color: greyColor),
                            prefixIcon: Icon(LucideIcons.calendar, color: greyColor),
                            suffixIcon: Icon(LucideIcons.chevronDown, color: greyColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: borderColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: borderColor),
                            ),
                            filled: true,
                            fillColor: inputFillColor,
                          ),
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(const Duration(days: 365)),
                            );
                            if (date != null) {
                              setState(() => _selectedDate = date);
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _addressController,
                          style: TextStyle(color: textColor),
                          decoration: InputDecoration(
                            labelText: 'Service Address',
                            labelStyle: TextStyle(color: greyColor),
                            prefixIcon: Icon(LucideIcons.mapPin, color: greyColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: borderColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: borderColor),
                            ),
                            filled: true,
                            fillColor: inputFillColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _notesController,
                          maxLines: 2,
                          style: TextStyle(color: textColor),
                          decoration: InputDecoration(
                            labelText: 'Special Instructions (Optional)',
                            labelStyle: TextStyle(color: greyColor),
                            alignLabelWithHint: true,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: Icon(LucideIcons.messageSquare, color: greyColor),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: borderColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: borderColor),
                            ),
                            filled: true,
                            fillColor: inputFillColor,
                          ),
                        ),
                        const SizedBox(height: 20),

                        Text(
                          'Payment Method',
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Material(
                                color: Colors.transparent,
                                child: RadioListTile<String>(
                                  title: Text('Card', style: TextStyle(color: textColor)),
                                  value: 'card',
                                  groupValue: _selectedPaymentMethod,
                                  onChanged: (value) => setState(() => _selectedPaymentMethod = value!),
                                  activeColor: AppColors.accentDarkGreen,
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Material(
                                color: Colors.transparent,
                                child: RadioListTile<String>(
                                  title: Text('EFT / Cash', style: TextStyle(color: textColor)),
                                  value: 'eft',
                                  groupValue: _selectedPaymentMethod,
                                  onChanged: (value) => setState(() => _selectedPaymentMethod = value!),
                                  activeColor: AppColors.accentDarkGreen,
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: borderColor)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Amount:',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: greyColor,
                        ),
                      ),
                      Text(
                        'R ${_calculatedPrice.toStringAsFixed(2)}',
                        style: GoogleFonts.spaceGrotesk(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state is BookingLoading
                        ? null
                        : () {
                            if (_selectedService == null || _selectedDate == null || _addressController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please fill in all required fields')),
                              );
                              return;
                            }
                            
                            if (_selectedSpecificItem == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please select a specific item for this service')),
                              );
                              return;
                            }
                            
                            context.read<BookingBloc>().add(
                              SubmitBooking(
                                serviceType: _selectedService!,
                                specificItem: _selectedSpecificItem!,
                                amount: _calculatedPrice,
                                date: '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                                address: _addressController.text,
                                notes: _notesController.text,
                                paymentMethod: _selectedPaymentMethod,
                              ),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark ? AppColors.accentDarkGreen : AppColors.primaryNavy,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    child: state is BookingLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : const Text('Confirm Booking', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}