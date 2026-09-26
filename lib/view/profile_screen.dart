import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../controller/auth_controller.dart';
import '../controller/theme_controller.dart';
import 'login_screen.dart';
import 'theme_screen.dart';
import 'widgets/avatar_image.dart';

class ProfileScreen extends StatefulWidget {
  final AuthController authController;

  const ProfileScreen({super.key, required this.authController});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ImagePicker _imagePicker = ImagePicker();

  // Preset corporate avatars
  final List<String> presetAvatars = [
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=150',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=150',
  ];

  // Logout with confirmation dialog
  void confirmAndLogout() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Confirm Logout',
          style: GoogleFonts.rajdhani(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Are you sure you want to log out of your employee account?',
          style: GoogleFonts.rajdhani(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'CANCEL',
              style: GoogleFonts.rajdhani(
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              doLogout();
            },
            child: Text(
              'LOGOUT',
              style: GoogleFonts.rajdhani(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void doLogout() {
    widget.authController.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  // Pick image using image_picker (Gallery / Camera)
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? file = await _imagePicker.pickImage(source: source);
      if (file != null && widget.authController.currentUser != null) {
        setState(() {
          widget.authController.currentUser!.imageUrl = file.path;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: const Color(0xFF16A34A),
              behavior: SnackBarBehavior.floating,
              content: Text(
                'Profile picture updated successfully!',
                style: GoogleFonts.rajdhani(fontWeight: FontWeight.w600),
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xFFDC2626),
            behavior: SnackBarBehavior.floating,
            content: Text(
              'Failed to select image: $e',
              style: GoogleFonts.rajdhani(fontWeight: FontWeight.w600),
            ),
          ),
        );
      }
    }
  }

  // Delete profile picture
  void _deleteProfilePhoto() {
    if (widget.authController.currentUser != null) {
      setState(() {
        widget.authController.currentUser!.imageUrl = '';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFFDC2626),
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Profile picture removed.',
            style: GoogleFonts.rajdhani(fontWeight: FontWeight.w600),
          ),
        ),
      );
    }
  }

  // Options bottom sheet for profile photo (Edit / Delete)
  void _showProfilePhotoOptions() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasPhoto = widget.authController.currentUser?.imageUrl.isNotEmpty == true;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B) : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF475569) : const Color(0xFFCBD5E1),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Profile Photo Options',
                style: GoogleFonts.rajdhani(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),

              // Option 1: Choose from Gallery (Image Picker)
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2563EB).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.photo_library_rounded, color: Color(0xFF2563EB)),
                ),
                title: Text(
                  'Choose from Gallery',
                  style: GoogleFonts.rajdhani(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickImage(ImageSource.gallery);
                },
              ),

              // Option 2: Take Photo (Camera)
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D9488).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.camera_alt_rounded, color: Color(0xFF0D9488)),
                ),
                title: Text(
                  'Take Photo with Camera',
                  style: GoogleFonts.rajdhani(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickImage(ImageSource.camera);
                },
              ),

              // Option 3: Choose Preset Avatar
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8B5CF6).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.face_rounded, color: Color(0xFF8B5CF6)),
                ),
                title: Text(
                  'Select Corporate Preset',
                  style: GoogleFonts.rajdhani(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                onTap: () {
                  Navigator.pop(ctx);
                  _showPresetPicker();
                },
              ),

              // Option 4: Delete Photo (If photo exists)
              if (hasPhoto) ...[
                const Divider(),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDC2626).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.delete_outline_rounded, color: Color(0xFFDC2626)),
                  ),
                  title: Text(
                    'Delete Profile Photo',
                    style: GoogleFonts.rajdhani(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFDC2626),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(ctx);
                    _deleteProfilePhoto();
                  },
                ),
              ],

              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  // Preset avatar selector dialog
  void _showPresetPicker() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B) : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Select Corporate Avatar',
                style: GoogleFonts.rajdhani(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: presetAvatars.map((url) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      if (widget.authController.currentUser != null) {
                        setState(() {
                          widget.authController.currentUser!.imageUrl = url;
                        });
                      }
                      Navigator.pop(ctx);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF2563EB), width: 2),
                      ),
                      child: ClipOval(
                        child: Image.network(
                          url,
                          width: 54,
                          height: 54,
                          fit: BoxFit.cover,
                          errorBuilder: (c, e, s) => Container(
                            width: 54,
                            height: 54,
                            color: const Color(0xFF1E40AF),
                            child: const Icon(Icons.person, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final emp = widget.authController.currentUser;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeController = ThemeController.instance;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'MY PROFILE',
          style: GoogleFonts.rajdhani(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.0,
            color: Colors.white,
          ),
        ),
        backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            tooltip: 'Settings',
            icon: const Icon(Icons.settings_rounded),
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ],
      ),

      // End Drawer containing: Profile, Theme, and Logout
      endDrawer: Drawer(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 24,
                bottom: 24,
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [const Color(0xFF1E293B), const Color(0xFF0F172A)]
                      : [const Color(0xFF1E3A8A), const Color(0xFF2563EB)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: AvatarImage(
                      imageUrl: emp?.imageUrl,
                      size: 64,
                      iconSize: 38,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    emp != null && emp.name.isNotEmpty ? emp.name : 'Employee User',
                    style: GoogleFonts.rajdhani(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    emp?.email.isNotEmpty == true ? emp!.email : 'user@company.com',
                    style: GoogleFonts.rajdhani(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      emp?.designation.isNotEmpty == true ? emp!.designation : 'Staff',
                      style: GoogleFonts.rajdhani(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Profile
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.person_outline_rounded, color: Color(0xFF2563EB)),
              ),
              title: Text('Profile', style: GoogleFonts.rajdhani(fontSize: 16, fontWeight: FontWeight.w700)),
              subtitle: Text('View & verify employee info', style: GoogleFonts.rajdhani(fontSize: 13)),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
              onTap: () => Navigator.pop(context),
            ),

            // Theme
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF8B5CF6).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.palette_outlined, color: Color(0xFF8B5CF6)),
              ),
              title: Text('Theme', style: GoogleFonts.rajdhani(fontSize: 16, fontWeight: FontWeight.w700)),
              subtitle: Text('Dark to Light & Light to Dark', style: GoogleFonts.rajdhani(fontSize: 13)),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF8B5CF6).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  themeController.isDarkMode ? 'Dark' : 'Light',
                  style: GoogleFonts.rajdhani(fontSize: 12, fontWeight: FontWeight.w700, color: const Color(0xFF8B5CF6)),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ThemeScreen()));
              },
            ),

            const Spacer(),
            const Divider(),

            // Logout in Drawer (with confirmation)
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFDC2626).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.logout_rounded, color: Color(0xFFDC2626)),
              ),
              title: Text(
                'Logout',
                style: GoogleFonts.rajdhani(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFDC2626),
                ),
              ),
              subtitle: Text('Sign out of corporate session', style: GoogleFonts.rajdhani(fontSize: 13)),
              onTap: () {
                Navigator.pop(context);
                confirmAndLogout();
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              // 1. Employee Profile Avatar with Edit and Delete options
              Center(
                child: GestureDetector(
                  onTap: _showProfilePhotoOptions,
                  child: Stack(
                    children: [
                      Container(
                        width: 104,
                        height: 104,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF2563EB).withValues(alpha: 0.25),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: AvatarImage(
                          imageUrl: emp?.imageUrl,
                          size: 104,
                          iconSize: 60,
                        ),
                      ),
                      // Camera edit button badge
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2563EB),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDark ? const Color(0xFF0F172A) : Colors.white,
                              width: 2.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.edit_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 6),

              TextButton(
                onPressed: _showProfilePhotoOptions,
                child: Text(
                  'Edit / Delete Photo',
                  style: GoogleFonts.rajdhani(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2563EB),
                  ),
                ),
              ),

              const SizedBox(height: 4),

              // 2. Employee Name
              Center(
                child: Text(
                  emp != null && emp.name.isNotEmpty ? emp.name : 'Unknown Employee',
                  style: GoogleFonts.rajdhani(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(height: 2),

              // Designation
              Center(
                child: Text(
                  emp != null && emp.designation.isNotEmpty ? emp.designation : 'Staff',
                  style: GoogleFonts.rajdhani(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                ),
              ),

              const SizedBox(height: 16),
              const Divider(thickness: 1),
              const SizedBox(height: 12),

              // 3. Employee Basic Details
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Employee Information',
                  style: GoogleFonts.rajdhani(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              _buildInfoTile('Employee ID', emp?.empId.isNotEmpty == true ? emp!.empId : 'N/A', Icons.badge_outlined),
              _buildInfoTile('Email Address', emp?.email.isNotEmpty == true ? emp!.email : 'N/A', Icons.mail_outline_rounded),
              _buildInfoTile('Phone Number', emp?.phone.isNotEmpty == true ? emp!.phone : 'N/A', Icons.phone_outlined),
              _buildInfoTile('Department', emp?.department.isNotEmpty == true ? emp!.department : 'N/A', Icons.domain_rounded),
              _buildInfoTile('Designation / Role', emp?.designation.isNotEmpty == true ? emp!.designation : 'N/A', Icons.work_outline_rounded),
              _buildInfoTile('Salary / Package', emp?.salary.isNotEmpty == true ? emp!.salary : 'N/A', Icons.attach_money_rounded),
              _buildInfoTile('Date of Joining', emp?.joiningDate.isNotEmpty == true ? emp!.joiningDate : 'N/A', Icons.calendar_today_outlined),
              _buildInfoTile('Address / City', emp?.address.isNotEmpty == true ? emp!.address : 'N/A', Icons.location_on_outlined),

              const SizedBox(height: 24),

              // 4. Red Logout Button with Confirmation
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDC2626),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  icon: const Icon(Icons.logout_rounded, size: 20),
                  label: Text(
                    'LOGOUT',
                    style: GoogleFonts.rajdhani(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: confirmAndLogout,
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String value, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF2563EB).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF2563EB), size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.rajdhani(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.rajdhani(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
