import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'My Profile',
          style: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryNavy,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.edit, color: AppColors.primaryNavy),
            onPressed: () {
              _showEditProfileDialog(context);
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.primaryNavy,
              child: Text(
                'T',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Titelo Mokoena',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryNavy,
              ),
            ),
            Text(
              'titelo@example.com',
              style: GoogleFonts.dmSans(
                fontSize: 16,
                color: AppColors.lightTextGrey,
              ),
            ),
            const SizedBox(height: 30),
            _ProfileSection(
              title: 'Account Settings',
              children: [
                _ProfileItem(
                  icon: LucideIcons.user,
                  title: 'Personal Information',
                  onTap: () => _showPersonalInfoDialog(context),
                ),
                _ProfileItem(
                  icon: LucideIcons.mapPin,
                  title: 'Saved Addresses',
                  onTap: () => _showAddressesDialog(context),
                ),
                _ProfileItem(
                  icon: LucideIcons.creditCard,
                  title: 'Payment Methods',
                  onTap: () => _showPaymentDialog(context),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _ProfileSection(
              title: 'Preferences',
              children: [
                _ProfileItem(
                  icon: LucideIcons.bell,
                  title: 'Push Notifications',
                  trailing: Switch(
                    value: _notificationsEnabled,
                    onChanged: (val) => setState(() => _notificationsEnabled = val),
                    activeColor: AppColors.accentDarkGreen,
                  ),
                  onTap: () => setState(() => _notificationsEnabled = !_notificationsEnabled),
                ),
                _ProfileItem(
                  icon: LucideIcons.moon,
                  title: 'Dark Mode',
                  trailing: Switch(
                    value: _darkModeEnabled,
                    onChanged: (val) => setState(() => _darkModeEnabled = val),
                    activeColor: AppColors.accentDarkGreen,
                  ),
                  onTap: () => setState(() => _darkModeEnabled = !_darkModeEnabled),
                ),
                _ProfileItem(
                  icon: LucideIcons.lock,
                  title: 'Change Password',
                  onTap: () => _showChangePasswordDialog(context),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _ProfileSection(
              title: 'Communication',
              children: [
                _ProfileItem(
                  icon: LucideIcons.messageCircle,
                  title: 'Chat with Icebo',
                  onTap: () => _showChatDialog(context),
                ),
                _ProfileItem(
                  icon: LucideIcons.helpCircle,
                  title: 'Help Center',
                  onTap: () => _showHelpDialog(context),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _ProfileSection(
              title: 'About',
              children: [
                _ProfileItem(
                  icon: LucideIcons.info,
                  title: 'About Icebo Cleaning',
                  onTap: () => _showAboutDialog(context),
                ),
                _ProfileItem(
                  icon: LucideIcons.shield,
                  title: 'Privacy Policy',
                  onTap: () {},
                ),
                _ProfileItem(
                  icon: LucideIcons.fileText,
                  title: 'Terms of Service',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              'Icebo Cleaning App v1.0.0',
              style: GoogleFonts.dmSans(
                color: AppColors.lightTextGrey,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: const Text('A form to change your name, email, and phone number will appear here.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Save')),
        ],
      ),
    );
  }

  void _showPersonalInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Personal Information'),
        content: const Text('Name: Titelo Mokoena\nEmail: titelo@example.com\nPhone: 071 234 5678'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        ],
      ),
    );
  }

  void _showAddressesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Saved Addresses'),
        content: const Text('1. 42 Langa Crescent, Emalahleni\n2. 12 Main Street, Witbank'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        ],
      ),
    );
  }

  void _showPaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Payment Methods'),
        content: const Text('Visa ending in 4242\nMastercard ending in 1234'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Password'),
        content: const Text('A form to enter your current password and a new password will appear here.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Update')),
        ],
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help Center'),
        content: const Text('How can we assist you today? Call us at 079 386 1862 or email icebocleaning93@gmail.com.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About Icebo Cleaning'),
        content: const Text('Icebo Cleaning Services is a sub-division of NSELEYAMI Construction and Supply, based in Emalahleni. We provide premium cleaning and laundry solutions.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        ],
      ),
    );
  }

  void _showChatDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 15),
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Chat with Icebo',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryNavy,
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _ChatBubble(
                    message: 'Hello! How can we assist you today?',
                    isMe: false,
                  ),
                  _ChatBubble(
                    message: 'Hi, I would like to reschedule my cleaning for tomorrow.',
                    isMe: true,
                  ),
                  _ChatBubble(
                    message: 'Sure! Let me check the availability and get back to you in a moment.',
                    isMe: false,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                top: 10,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  CircleAvatar(
                    backgroundColor: AppColors.accentDarkGreen,
                    child: IconButton(
                      icon: const Icon(LucideIcons.send, color: Colors.white, size: 20),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _ProfileSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 10),
          child: Text(
            title,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.lightTextGrey,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.lightSurface,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColors.primaryNavy.withOpacity(0.1)),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}

class _ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback onTap;

  const _ProfileItem({
    required this.icon,
    required this.title,
    this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryNavy, size: 22),
      title: Text(
        title,
        style: GoogleFonts.dmSans(
          fontSize: 16,
          color: AppColors.lightTextDark,
        ),
      ),
      trailing: trailing ?? const Icon(LucideIcons.chevronRight, size: 20, color: AppColors.lightTextGrey),
      onTap: onTap,
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  const _ChatBubble({required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? AppColors.primaryNavy : Colors.grey[200],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft: isMe ? const Radius.circular(15) : Radius.zero,
            bottomRight: isMe ? Radius.zero : const Radius.circular(15),
          ),
        ),
        child: Text(
          message,
          style: GoogleFonts.dmSans(
            color: isMe ? Colors.white : AppColors.lightTextDark,
          ),
        ),
      ),
    );
  }
}