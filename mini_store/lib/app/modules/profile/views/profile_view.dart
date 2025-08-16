import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:mini_store/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:mini_store/app/routes/app_pages.dart';
import 'package:mini_store/app/global_widgets/profile_bottom_sheets.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Enhanced Profile Header
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF667EEA).withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Enhanced Profile Picture with gradient design
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      FontAwesome.user,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Profile Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Profile',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Obx(
                          () => Text(
                            controller.userName.value,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Obx(
                          () => Text(
                            controller.userEmail.value,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Personal Information Section
            _buildSectionHeader('Personal Information'),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    spreadRadius: 0,
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Name
                  Obx(
                    () => ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 4,
                      ),
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Color(0xFF10B981),
                          size: 20,
                        ),
                      ),
                      title: const Text(
                        'Full Name',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      subtitle: Text(
                        controller.userName.value,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.keyboard_arrow_right_outlined,
                          color: Colors.grey.shade600,
                          size: 20,
                        ),
                      ),
                      onTap: () {
                        Get.bottomSheet(
                          ChangeNameBottomSheet(
                            currentName: controller.userName.value,
                            onNameChanged: controller.updateName,
                          ),
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                        );
                      },
                    ),
                  ),
                  Divider(
                    color: Colors.grey.shade200,
                    height: 1,
                    indent: 20,
                    endIndent: 20,
                  ),

                  // Email
                  Obx(
                    () => ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 4,
                      ),
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF3B82F6).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.email,
                          color: Color(0xFF3B82F6),
                          size: 20,
                        ),
                      ),
                      title: const Text(
                        'Email Address',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      subtitle: Text(
                        controller.userEmail.value,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.keyboard_arrow_right_outlined,
                          color: Colors.grey.shade600,
                          size: 20,
                        ),
                      ),
                      onTap: () {
                        Get.bottomSheet(
                          ChangeEmailBottomSheet(
                            currentEmail: controller.userEmail.value,
                            onEmailChanged: controller.updateEmail,
                          ),
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Appearance & Language Section
            _buildSectionHeader('Appearance & Language'),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    spreadRadius: 0,
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Language Selection
                  Obx(
                    () => ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 4,
                      ),
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF8B5CF6).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.language,
                          color: Color(0xFF8B5CF6),
                          size: 20,
                        ),
                      ),
                      title: const Text(
                        'Language',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      subtitle: Obx(
                        () => Text(
                          controller.currentLanguage.value,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      trailing: AnimatedRotation(
                        turns: controller.isLanguageExpanded.value ? 0.5 : 0,
                        duration: const Duration(milliseconds: 300),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.expand_more,
                            color: Colors.grey.shade600,
                            size: 20,
                          ),
                        ),
                      ),
                      onTap: () {
                        controller.toggleLanguageExpansion();
                      },
                    ),
                  ),

                  // Animated Language Options
                  Obx(
                    () => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: controller.isLanguageExpanded.value ? 140 : 0,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            RadioListTile<String>(
                              title: Row(
                                children: [
                                  const Text(
                                    "🇪🇹",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(width: 15),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Amharic",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "አማርኛ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              value: "Amharic",
                              groupValue: controller.currentLanguage.value,
                              onChanged: (String? value) {
                                if (value != null) {
                                  controller.changeLanguage(value);
                                }
                              },
                              activeColor: const Color(0xFF8B5CF6),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                            ),
                            RadioListTile<String>(
                              title: Row(
                                children: [
                                  const Text(
                                    "🇺🇸",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(width: 15),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "English",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "English",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              value: "English",
                              groupValue: controller.currentLanguage.value,
                              onChanged: (String? value) {
                                if (value != null) {
                                  controller.changeLanguage(value);
                                }
                              },
                              activeColor: const Color(0xFF8B5CF6),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  if (controller.isLanguageExpanded.value)
                    Divider(
                      color: Colors.grey.shade200,
                      height: 1,
                      indent: 20,
                      endIndent: 20,
                    ),

                  // Theme Switcher
                  Obx(
                    () => ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 4,
                      ),
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF59E0B).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          controller.isDarkMode.value
                              ? Icons.dark_mode
                              : Icons.light_mode,
                          color: const Color(0xFFF59E0B),
                          size: 20,
                        ),
                      ),
                      title: const Text(
                        'Theme',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      subtitle: Text(
                        controller.isDarkMode.value
                            ? 'Dark Mode'
                            : 'Light Mode',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: BeautifulToggleSwitch(
                        value: controller.isDarkMode.value,
                        onChanged: (value) {
                          controller.isDarkMode.value = value;
                          controller.changeTheme(
                            value ? 'Dark Theme' : 'Light Theme',
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Account Settings Section
            _buildSectionHeader('Account Settings'),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    spreadRadius: 0,
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Change Password
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 4,
                    ),
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF4444).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.lock_outline,
                        color: Color(0xFFEF4444),
                        size: 20,
                      ),
                    ),
                    title: const Text(
                      'Change Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    subtitle: Text(
                      'Update your password',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.keyboard_arrow_right_outlined,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                    ),
                    onTap: () {
                      Get.bottomSheet(
                        ChangePasswordBottomSheet(
                          onPasswordChanged: controller.changePassword,
                        ),
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                      );
                    },
                  ),
                  Divider(
                    color: Colors.grey.shade200,
                    height: 1,
                    indent: 20,
                    endIndent: 20,
                  ),

                  // Help & Support
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 4,
                    ),
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B82F6).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.help_outline,
                        color: Color(0xFF3B82F6),
                        size: 20,
                      ),
                    ),
                    title: const Text(
                      'Help & Support',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    subtitle: Text(
                      'Get help and support',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.keyboard_arrow_right_outlined,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                    ),
                    onTap: () {
                      Get.bottomSheet(
                        const HelpSupportBottomSheet(),
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                      );
                    },
                  ),
                  Divider(
                    color: Colors.grey.shade200,
                    height: 1,
                    indent: 20,
                    endIndent: 20,
                  ),

                  // Terms & Conditions
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 4,
                    ),
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.description_outlined,
                        color: Color(0xFF10B981),
                        size: 20,
                      ),
                    ),
                    title: const Text(
                      'Terms & Conditions',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    subtitle: Text(
                      'Terms & policies',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.keyboard_arrow_right_outlined,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                    ),
                    onTap: () {
                      Get.bottomSheet(
                        const TermsConditionsBottomSheet(),
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Account Actions Section
            _buildSectionHeader('Account Actions'),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    spreadRadius: 0,
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Logout
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 4,
                    ),
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.logout,
                        color: Colors.orange.shade700,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange.shade700,
                      ),
                    ),
                    subtitle: Text(
                      'Sign out of your account',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.keyboard_arrow_right_outlined,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                    ),
                    onTap: () => Get.offAllNamed(Routes.LOGIN),
                  ),
                  Divider(
                    color: Colors.grey.shade200,
                    height: 1,
                    indent: 20,
                    endIndent: 20,
                  ),

                  // Delete Account
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 4,
                    ),
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.delete_forever,
                        color: Colors.red.shade700,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      'Delete Account',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.red.shade700,
                      ),
                    ),
                    subtitle: Text(
                      'Delete permanently',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.keyboard_arrow_right_outlined,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                    ),
                    onTap: () {
                      Get.bottomSheet(
                        DeleteAccountBottomSheet(
                          onDeleteConfirmed: () {
                            controller.deleteAccount();
                          },
                        ),
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 25, bottom: 8),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1E293B),
          ),
        ),
      ),
    );
  }
}

class BeautifulToggleSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const BeautifulToggleSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<BeautifulToggleSwitch> createState() => _BeautifulToggleSwitchState();
}

class _BeautifulToggleSwitchState extends State<BeautifulToggleSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    if (widget.value) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(BeautifulToggleSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      if (widget.value) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Container(
            width: 60,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors:
                    widget.value
                        ? [Colors.grey.shade800, Colors.grey.shade900]
                        : [Colors.grey.shade300, Colors.grey.shade400],
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      widget.value
                          ? Colors.grey.shade800.withOpacity(0.3)
                          : Colors.grey.shade300.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Animated background circle
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  left: widget.value ? 32 : 2,
                  top: 2,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        widget.value ? Icons.dark_mode : Icons.light_mode,
                        key: ValueKey(widget.value),
                        size: 16,
                        color:
                            widget.value
                                ? Colors.grey.shade900
                                : const Color(0xFFF59E0B),
                      ),
                    ),
                  ),
                ),
                // Theme indicator text
                Positioned(
                  left: widget.value ? 8 : 32,
                  top: 8,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: widget.value ? 0.0 : 1.0,
                    child: const Text(
                      'L',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: widget.value ? 32 : 8,
                  top: 8,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: widget.value ? 1.0 : 0.0,
                    child: const Text(
                      'D',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
