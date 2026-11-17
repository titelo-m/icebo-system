import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';

class PricingModal extends StatelessWidget {
  const PricingModal({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF121417) : AppColors.lightBackground;
    final cardColor = isDark ? const Color(0xFF1E1F22) : Colors.white;
    final textColor = isDark ? Colors.white : AppColors.primaryNavy;
    final greyColor = isDark ? Colors.white70 : AppColors.lightTextGrey;

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 15),
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[500],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Service Pricing',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Transparent pricing for all your cleaning needs.',
            style: GoogleFonts.dmSans(color: greyColor),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _PriceCategory(title: 'Rug Price List', icon: LucideIcons.layers, items: const [
                  _PriceItem('Small rug (1x1.5m)', 'R120'), _PriceItem('Normal rug (1.5x2m)', 'R200'), _PriceItem('2x3m rug', 'R250'), _PriceItem('Large 3x4m rug', 'R320'), _PriceItem('Extra large 4x5m', 'R380'), _PriceItem('Fitted carpets', 'R40 per m²'),
                ], cardColor: cardColor, textColor: textColor, greyColor: greyColor),
                _PriceCategory(title: 'Couch Deep Clean', icon: LucideIcons.sofa, items: const [
                  _PriceItem('1 seater', 'R300'), _PriceItem('2 seater', 'R380'), _PriceItem('3 seater', 'R480'), _PriceItem('4 seater', 'R600'), _PriceItem('5 seater', 'R720'), _PriceItem('6 seater', 'R850'),
                ], cardColor: cardColor, textColor: textColor, greyColor: greyColor),
                _PriceCategory(title: 'Wash, Dry & Fold', icon: LucideIcons.washingMachine, items: const [
                  _PriceItem('Small basket', 'R90'), _PriceItem('Medium basket', 'R120'), _PriceItem('Large basket', 'R190'),
                ], cardColor: cardColor, textColor: textColor, greyColor: greyColor),
                _PriceCategory(title: 'Wash, Dry & Iron', icon: LucideIcons.shirt, items: const [
                  _PriceItem('Small basket', 'R120'), _PriceItem('Medium basket', 'R160'), _PriceItem('Large basket', 'R250'),
                ], cardColor: cardColor, textColor: textColor, greyColor: greyColor),
                _PriceCategory(title: 'Iron Only', icon: LucideIcons.zap, items: const [
                  _PriceItem('Small basket', 'R60'), _PriceItem('Medium basket', 'R90'), _PriceItem('Large basket', 'R130'),
                ], cardColor: cardColor, textColor: textColor, greyColor: greyColor),
                _PriceCategory(title: 'Mattress Deep Cleaning', icon: LucideIcons.bed, items: const [
                  _PriceItem('Single bed', 'R220'), _PriceItem('3/4 bed', 'R300'), _PriceItem('Double bed', 'R350'), _PriceItem('Queen bed', 'R420'), _PriceItem('King bed', 'R500'),
                ], cardColor: cardColor, textColor: textColor, greyColor: greyColor),
                _PriceCategory(title: 'Headboard Prices', icon: LucideIcons.layout, items: const [
                  _PriceItem('Single headboard', 'R150'), _PriceItem('3/4 headboard', 'R170'), _PriceItem('Double headboard', 'R200'), _PriceItem('Queen headboard', 'R230'), _PriceItem('King headboard', 'R250'),
                ], cardColor: cardColor, textColor: textColor, greyColor: greyColor),
                _PriceCategory(title: 'Blanket Wash Services', icon: LucideIcons.sun, items: const [
                  _PriceItem('1 ply blanket', 'R60'), _PriceItem('2 ply blanket', 'R80'), _PriceItem('3 ply blanket', 'R120'),
                ], cardColor: cardColor, textColor: textColor, greyColor: greyColor),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark ? AppColors.accentDarkGreen : AppColors.primaryNavy,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Close'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PriceCategory extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<_PriceItem> items;
  final Color cardColor;
  final Color textColor;
  final Color greyColor;

  const _PriceCategory({
    required this.title,
    required this.icon,
    required this.items,
    required this.cardColor,
    required this.textColor,
    required this.greyColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: cardColor,
      borderRadius: BorderRadius.circular(15),
      clipBehavior: Clip.antiAlias,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        child: ExpansionTile(
          iconColor: textColor,
          collapsedIconColor: textColor,
          leading: Icon(icon, color: AppColors.accentDarkGreen),
          title: Text(
            title,
            style: GoogleFonts.spaceGrotesk(
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          children: items.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item.name, style: GoogleFonts.dmSans(color: greyColor)),
                  Text(item.price, style: GoogleFonts.dmSans(fontWeight: FontWeight.bold, color: textColor)),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _PriceItem {
  final String name;
  final String price;
  const _PriceItem(this.name, this.price);
}