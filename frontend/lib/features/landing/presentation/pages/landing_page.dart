import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_colors.dart';
import '../../bloc/landing_bloc.dart';
import '../../bloc/landing_event.dart';
import '../../bloc/landing_state.dart';
import '../widgets/pricing_modal.dart';
import '../widgets/service_card.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _servicesKey = GlobalKey();

  void _scrollToServices() {
    final context = _servicesKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return BlocProvider(
      create: (context) => LandingBloc(),
      child: BlocListener<LandingBloc, LandingState>(
        listener: (context, state) {
          if (state is LandingActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppColors.accentDarkGreen),
            );
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.lightBackground,
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: AppColors.lightBackground.withOpacity(0.9),
                elevation: 0,
                title: RichText(
                  text: TextSpan(
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                    ),
                    children: const [
                      TextSpan(
                        text: 'Icebo',
                        style: TextStyle(color: AppColors.primaryNavy),
                      ),
                      TextSpan(
                        text: 'Cleaning',
                        style: TextStyle(color: AppColors.accentDarkGreen),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => context.push('/login'),
                    child: const Text(
                      'Login',
                      style: TextStyle(color: AppColors.primaryNavy, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16, left: 8),
                    child: ElevatedButton(
                      onPressed: () => context.push('/signup'),
                      child: const Text('Get a Service'),
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.lightSurface,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: AppColors.accentDarkGreen.withOpacity(0.3)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.02),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(LucideIcons.shieldCheck, size: 16, color: AppColors.accentDarkGreen),
                            const SizedBox(width: 8),
                            Text(
                              'TRUSTED CORPORATE CLEANING',
                              style: GoogleFonts.dmSans(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                                color: AppColors.accentDarkGreen,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text.rich(
                        TextSpan(
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: isDesktop ? 64 : 42,
                            fontWeight: FontWeight.w700,
                            height: 1.1,
                            letterSpacing: -2.0,
                            color: AppColors.primaryNavy,
                          ),
                          children: const [
                            TextSpan(text: 'Cleaner Spaces.\n'),
                            TextSpan(
                              text: 'Healthier Lives.',
                              style: TextStyle(color: AppColors.accentDarkGreen),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Premium corporate, commercial and residential cleaning services based in eMalahleni.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dmSans(
                          fontSize: 18,
                          color: AppColors.lightTextGrey,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'We deliver professional cleaning solutions tailored to your needs and we ensure your environment is always spotless and welcoming.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dmSans(
                          fontSize: 18,
                          color: AppColors.lightTextGrey,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Wrap(
                        spacing: 15,
                        runSpacing: 15,
                        alignment: WrapAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () => context.push('/signup'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.accentDarkGreen,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text('Get a Service'),
                                SizedBox(width: 8),
                                Icon(LucideIcons.arrowRight, size: 18),
                              ],
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => const PricingModal(),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.primaryNavy,
                              side: BorderSide(color: AppColors.primaryNavy.withOpacity(0.2), width: 1.5),
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            ),
                            child: const Text('See Services', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        alignment: WrapAlignment.center,
                        children: const [
                          _PillTag(label: 'Corporate Offices'),
                          _PillTag(label: 'Retail Spaces'),
                          _PillTag(label: 'Domestic Workers'),
                          _PillTag(label: 'Car Valet'),
                          _PillTag(label: 'Laundry'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                key: _servicesKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        'Our Services',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                          color: AppColors.accentDarkGreen,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        alignment: WrapAlignment.center,
                        children: [
                          SizedBox(
                            width: isDesktop ? (MediaQuery.of(context).size.width - 100) / 3 : double.infinity,
                            child: const ServiceCard(title: 'Residential Cleaning', icon: LucideIcons.home),
                          ),
                          SizedBox(
                            width: isDesktop ? (MediaQuery.of(context).size.width - 100) / 3 : double.infinity,
                            child: const ServiceCard(title: 'Commercial Cleaning', icon: LucideIcons.building),
                          ),
                          SizedBox(
                            width: isDesktop ? (MediaQuery.of(context).size.width - 100) / 3 : double.infinity,
                            child: const ServiceCard(title: 'Window Cleaning', icon: LucideIcons.layout),
                          ),
                          SizedBox(
                            width: isDesktop ? (MediaQuery.of(context).size.width - 100) / 3 : double.infinity,
                            child: const ServiceCard(title: 'Post-Construction', icon: LucideIcons.hammer),
                          ),
                          SizedBox(
                            width: isDesktop ? (MediaQuery.of(context).size.width - 100) / 3 : double.infinity,
                            child: const ServiceCard(title: 'Carpet Cleaning', icon: LucideIcons.layers),
                          ),
                          SizedBox(
                            width: isDesktop ? (MediaQuery.of(context).size.width - 100) / 3 : double.infinity,
                            child: const ServiceCard(title: 'Upholstery Cleaning', icon: LucideIcons.sofa),
                          ),
                          SizedBox(
                            width: isDesktop ? (MediaQuery.of(context).size.width - 100) / 3 : double.infinity,
                            child: const ServiceCard(title: 'Pre/Post Event Cleaning', icon: LucideIcons.calendar),
                          ),
                          SizedBox(
                            width: isDesktop ? (MediaQuery.of(context).size.width - 100) / 3 : double.infinity,
                            child: const ServiceCard(title: 'Car Valet Services', icon: LucideIcons.car),
                          ),
                          SizedBox(
                            width: isDesktop ? (MediaQuery.of(context).size.width - 100) / 3 : double.infinity,
                            child: const ServiceCard(title: 'Billboard Cleaning', icon: LucideIcons.image),
                          ),
                          SizedBox(
                            width: isDesktop ? (MediaQuery.of(context).size.width - 100) / 3 : double.infinity,
                            child: const ServiceCard(title: 'Surface Cleaning', icon: LucideIcons.droplet),
                          ),
                          SizedBox(
                            width: isDesktop ? (MediaQuery.of(context).size.width - 100) / 3 : double.infinity,
                            child: const ServiceCard(title: 'Laundry Services', icon: LucideIcons.washingMachine),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
                  child: Column(
                    children: [
                      Text(
                        'Our Work',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                          color: AppColors.accentDarkGreen,
                        ),
                      ),
                      const SizedBox(height: 30),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isDesktop ? 3 : 1, 
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: isDesktop ? 1.6 : 1.8,
                        ),
                        itemCount: 9, 
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                'assets/images/work_${index + 1}.jpg',
                                fit: BoxFit.cover,
                                alignment: Alignment.bottomCenter,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: AppColors.lightSurface,
                                    child: const Center(
                                      child: Icon(LucideIcons.image, color: AppColors.lightTextGrey, size: 40),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 40),
                      Text(
                        'Our Commitment to Corporate Clients',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: isDesktop ? 42 : 32,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                          color: AppColors.primaryNavy,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'We recognise that business premises have different cleaning needs and operating hours. We are committed to discussing the required tasks, service frequency and site expectations with each client before confirming a service arrangement.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dmSans(
                          fontSize: 18,
                          height: 1.6,
                          color: AppColors.lightTextGrey,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Our objective is to help clients maintain clean, presentable and welcoming workplaces while respecting their day-to-day operations.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dmSans(
                          fontSize: 18,
                          height: 1.6,
                          color: AppColors.lightTextGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        'Laundry Services',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                          color: AppColors.accentDarkGreen,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Wrap(
                        spacing: 15,
                        runSpacing: 15,
                        alignment: WrapAlignment.center,
                        children: [
                          SizedBox(
                            width: isDesktop ? (MediaQuery.of(context).size.width - 100) / 3 : double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset('assets/images/laundry_1.jpg', fit: BoxFit.cover, height: 250,
                                errorBuilder: (context, error, stackTrace) => Container(height: 250, color: AppColors.lightSurface, child: const Center(child: Icon(LucideIcons.image))),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: isDesktop ? (MediaQuery.of(context).size.width - 100) / 3 : double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset('assets/images/laundry_2.jpg', fit: BoxFit.cover, height: 250,
                                errorBuilder: (context, error, stackTrace) => Container(height: 250, color: AppColors.lightSurface, child: const Center(child: Icon(LucideIcons.image))),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: isDesktop ? (MediaQuery.of(context).size.width - 100) / 3 : double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset('assets/images/laundry_3.jpg', fit: BoxFit.cover, height: 250,
                                errorBuilder: (context, error, stackTrace) => Container(height: 250, color: AppColors.lightSurface, child: const Center(child: Icon(LucideIcons.image))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.lightSurface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.primaryNavy.withOpacity(0.1),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: isDesktop
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  'assets/images/team.jpg',
                                  height: 300,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 300,
                                      color: Colors.grey[400],
                                      child: const Center(
                                        child: Text('Team Photo Missing', style: TextStyle(color: Colors.white)),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 40),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Meet the Team',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.accentDarkGreen,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    'Our dedicated team ensures every detail is handled with professionalism and care. We take pride in driving the highest standards of cleaning across eMalahleni.',
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          color: AppColors.lightTextGrey,
                                          height: 1.6,
                                          fontSize: 18,
                                        ),
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    'We are ready to build a professional, long-term relationship with your business.',
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          color: AppColors.accentDarkGreen,
                                          height: 1.6,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Text(
                              'Meet the Team',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppColors.accentDarkGreen,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                'assets/images/team.jpg',
                                height: 250,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 250,
                                    color: Colors.grey[400],
                                    child: const Center(
                                      child: Text('Team Photo Missing', style: TextStyle(color: Colors.white)),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Our dedicated team ensures every detail is handled with professionalism and care.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.lightTextGrey,
                                    height: 1.4,
                                  ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              'We are ready to build a professional, long-term relationship with your business.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.accentDarkGreen,
                                    height: 1.6,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.primaryNavy.withOpacity(0.1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Company Information',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryNavy,
                        ),
                      ),
                      const SizedBox(height: 15),
                      _InfoRow(label: 'Business Name', value: 'Icebo cleaning service sub division of NSELEYAMI CONTRUCTION AND SUPPLY'),
                      const Divider(),
                      _InfoRow(label: 'Registration Number', value: '2024/5149465/07'),
                      const Divider(),
                      _InfoRow(label: 'Industry', value: 'Cleaning and Laundry Services'),
                      const Divider(),
                      _InfoRow(label: 'Address', value: '42 Langa Crescent, Corridor Hill, Emalahleni (Witbank), South Africa'),
                      const Divider(),
                      _InfoRow(label: 'B-BBEE Status', value: 'Confirmed'),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: AppColors.primaryNavy,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryNavy.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        LucideIcons.phoneCall,
                        size: 40,
                        color: AppColors.accentDarkGreen,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Ready to book a cleaning?',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Reach out to us today. We are available for corporate and residential enquiries.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dmSans(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Wrap(
                        spacing: 20,
                        runSpacing: 15,
                        alignment: WrapAlignment.center,
                        children: [
                          _ContactButton(
                            icon: LucideIcons.messageCircle,
                            label: 'WhatsApp: +27 75 488 9793',
                            onTap: () {
                              context.read<LandingBloc>().add(const ContactIcebo(type: 'whatsapp'));
                              launchUrl(Uri.parse('https://wa.me/27754889793'));
                            },
                          ),
                          _ContactButton(
                            icon: LucideIcons.phone,
                            label: 'Call: +27 79 386 1862',
                            onTap: () {
                              context.read<LandingBloc>().add(const ContactIcebo(type: 'phone'));
                              launchUrl(Uri.parse('tel:+27793861862'));
                            },
                          ),
                          _ContactButton(
                            icon: LucideIcons.mail,
                            label: 'icebocleaning93@gmail.com',
                            onTap: () {
                              context.read<LandingBloc>().add(const ContactIcebo(type: 'email'));
                              launchUrl(Uri.parse('mailto:icebocleaning93@gmail.com'));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Text(
                    '© 2026 Icebo Cleaning Services. All rights reserved.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dmSans(color: AppColors.lightTextGrey, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.bold,
                color: AppColors.lightTextGrey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.dmSans(
                color: AppColors.primaryNavy,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PillTag extends StatelessWidget {
  final String label;
  const _PillTag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Text(
        label,
        style: GoogleFonts.dmSans(
          fontSize: 14,
          color: AppColors.lightTextGrey,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _ContactButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ContactButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Text(
              label,
              style: GoogleFonts.dmSans(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}