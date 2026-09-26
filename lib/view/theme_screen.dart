import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/theme_controller.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.instance;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'THEME & APPEARANCE',
          style: GoogleFonts.rajdhani(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.0,
            color: Colors.white,
          ),
        ),
        backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: ListenableBuilder(
        listenable: themeController,
        builder: (context, _) {
          final currentMode = themeController.themeMode;
          final isCurrentlyDark = currentMode == ThemeMode.dark;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header Card with Interactive Switch
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isCurrentlyDark
                              ? [const Color(0xFF1E293B), const Color(0xFF0F172A)]
                              : [const Color(0xFF1E3A8A), const Color(0xFF2563EB)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: (isCurrentlyDark
                                    ? Colors.black
                                    : const Color(0xFF2563EB))
                                .withValues(alpha: 0.25),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isCurrentlyDark
                                  ? Icons.dark_mode_rounded
                                  : Icons.light_mode_rounded,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isCurrentlyDark ? 'Dark Mode Active' : 'Light Mode Active',
                                  style: GoogleFonts.rajdhani(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  isCurrentlyDark
                                      ? 'Tap switch to change to Light Mode'
                                      : 'Tap switch to change to Dark Mode',
                                  style: GoogleFonts.rajdhani(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: isCurrentlyDark,
                            activeThumbColor: const Color(0xFF60A5FA),
                            activeTrackColor: const Color(0xFF3B82F6).withValues(alpha: 0.5),
                            inactiveThumbColor: Colors.white,
                            inactiveTrackColor: Colors.white24,
                            onChanged: (val) {
                              themeController.setThemeMode(
                                val ? ThemeMode.dark : ThemeMode.light,
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    Text(
                      'Choose Theme Mode',
                      style: GoogleFonts.rajdhani(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // 1. Light Mode Card
                    _buildThemeOptionCard(
                      context: context,
                      title: 'Light Mode (Dark to Light)',
                      description: 'Clean enterprise interface with white backgrounds and navy accents',
                      icon: Icons.light_mode_rounded,
                      iconColor: const Color(0xFFF59E0B),
                      isSelected: currentMode == ThemeMode.light,
                      onTap: () => themeController.setThemeMode(ThemeMode.light),
                    ),

                    const SizedBox(height: 12),

                    // 2. Dark Mode Card
                    _buildThemeOptionCard(
                      context: context,
                      title: 'Dark Mode (Light to Dark)',
                      description: 'Modern dark slate palette reducing eye fatigue in low-light environments',
                      icon: Icons.dark_mode_rounded,
                      iconColor: const Color(0xFF818CF8),
                      isSelected: currentMode == ThemeMode.dark,
                      onTap: () => themeController.setThemeMode(ThemeMode.dark),
                    ),

                    const SizedBox(height: 12),

                    // 3. System Default Card
                    _buildThemeOptionCard(
                      context: context,
                      title: 'System Default',
                      description: 'Automatically synchronizes with your device system appearance',
                      icon: Icons.settings_system_daydream_rounded,
                      iconColor: const Color(0xFF10B981),
                      isSelected: currentMode == ThemeMode.system,
                      onTap: () => themeController.setThemeMode(ThemeMode.system),
                    ),

                    const SizedBox(height: 28),

                    // Live Preview Section
                    Text(
                      'Live UI Preview',
                      style: GoogleFonts.rajdhani(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isDark
                              ? const Color(0xFF334155)
                              : const Color(0xFFE2E8F0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1E40AF).withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'PREVIEW',
                                  style: GoogleFonts.rajdhani(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF2563EB),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                isCurrentlyDark
                                    ? Icons.nights_stay_rounded
                                    : Icons.wb_sunny_rounded,
                                color: isCurrentlyDark
                                    ? const Color(0xFF60A5FA)
                                    : const Color(0xFFF59E0B),
                                size: 20,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Employee Portal Dashboard',
                            style: GoogleFonts.rajdhani(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'This preview demonstrates real-time color adapting for text, cards, and buttons.',
                            style: GoogleFonts.rajdhani(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 14),
                          SizedBox(
                            width: double.infinity,
                            height: 42,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isDark
                                    ? const Color(0xFF2563EB)
                                    : const Color(0xFF1E40AF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                'SAMPLE INTERACTIVE BUTTON',
                                style: GoogleFonts.rajdhani(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildThemeOptionCard({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    required Color iconColor,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF2563EB)
                : (isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
            width: isSelected ? 2.0 : 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF2563EB).withValues(alpha: 0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.rajdhani(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isSelected
                          ? const Color(0xFF2563EB)
                          : (isDark ? Colors.white : const Color(0xFF0F172A)),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: GoogleFonts.rajdhani(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected
                  ? Icons.check_circle_rounded
                  : Icons.radio_button_unchecked_rounded,
              color: isSelected
                  ? const Color(0xFF2563EB)
                  : (isDark ? Colors.grey.shade600 : Colors.grey.shade400),
            ),
          ],
        ),
      ),
    );
  }
}
