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
            decoration: const BoxDecoration(
              color: Colors.white,
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
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryNavy,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Select a service and we will handle the rest.',
                  style: GoogleFonts.dmSans(color: AppColors.lightTextGrey),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Select Main Service',
                            prefixIcon: const Icon(LucideIcons.building),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: AppColors.accentDarkGreen, width: 2),
                            ),
                          ),
                          items: _serviceCatalog.keys.map((service) {
                            return DropdownMenuItem(value: service, child: Text(service));
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
                            decoration: InputDecoration(
                              labelText: 'Select Specific Item',
                              prefixIcon: const Icon(LucideIcons.layers),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(color: AppColors.accentDarkGreen, width: 2),
                              ),
                            ),
                            items: _serviceCatalog[_selectedService]!.keys.map((item) {
                              return DropdownMenuItem(value: item, child: Text(item));
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
                          controller: TextEditingController(
                            text: _selectedDate == null ? '' : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                          ),
                          decoration: InputDecoration(
                            labelText: 'Preferred Date',
                            prefixIcon: const Icon(LucideIcons.calendar),
                            suffixIcon: const Icon(LucideIcons.chevronDown),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: AppColors.accentDarkGreen, width: 2),
                            ),
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
                          decoration: InputDecoration(
                            labelText: 'Service Address',
                            prefixIcon: const Icon(LucideIcons.mapPin),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: AppColors.accentDarkGreen, width: 2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _notesController,
                          maxLines: 2,
                          decoration: InputDecoration(
                            labelText: 'Special Instructions (Optional)',
                            alignLabelWithHint: true,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(bottom: 30),
                              child: Icon(LucideIcons.messageSquare),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: AppColors.accentDarkGreen, width: 2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        Text(
                          'Payment Method',
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.primaryNavy,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile<String>(
                                title: const Text('Card'),
                                value: 'card',
                                groupValue: _selectedPaymentMethod,
                                onChanged: (value) => setState(() => _selectedPaymentMethod = value!),
                                activeColor: AppColors.accentDarkGreen,
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<String>(
                                title: const Text('EFT / Cash'),
                                value: 'eft',
                                groupValue: _selectedPaymentMethod,
                                onChanged: (value) => setState(() => _selectedPaymentMethod = value!),
                                activeColor: AppColors.accentDarkGreen,
                                contentPadding: EdgeInsets.zero,
                                dense: true,
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
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.black12)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Amount:',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.lightTextGrey,
                        ),
                      ),
                      Text(
                        'R ${_calculatedPrice.toStringAsFixed(2)}',
                        style: GoogleFonts.spaceGrotesk(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: AppColors.primaryNavy,
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
                      backgroundColor: AppColors.primaryNavy,
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