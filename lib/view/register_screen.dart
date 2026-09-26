import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../controller/auth_controller.dart';
import '../model/user_model.dart';
import 'bottom_nav_bar.dart';
import 'widgets/avatar_image.dart';

class RegisterScreen extends StatefulWidget {
  final AuthController authController;

  const RegisterScreen({super.key, required this.authController});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  // Selected profile picture URL / identifier
  String selectedImageUrl = '';
  bool profilePicError = false;

  // Controllers for all mandatory employee details
  final TextEditingController empIdController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController joiningDateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool hidePassword = true;
  bool isRegistering = false;

  // Preset corporate avatars
  final List<Map<String, String>> presetAvatars = [
    {
      'label': 'Executive 1',
      'url': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150',
    },
    {
      'label': 'Executive 2',
      'url': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
    },
    {
      'label': 'Director 1',
      'url': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150',
    },
    {
      'label': 'Director 2',
      'url': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150',
    },
    {
      'label': 'Lead 1',
      'url': 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=150',
    },
    {
      'label': 'Manager',
      'url': 'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=150',
    },
  ];

  @override
  void dispose() {
    empIdController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    departmentController.dispose();
    designationController.dispose();
    salaryController.dispose();
    joiningDateController.dispose();
    addressController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Pick image via image_picker from Gallery or Camera
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? file = await _imagePicker.pickImage(source: source);
      if (file != null) {
        setState(() {
          selectedImageUrl = file.path;
          profilePicError = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xFFDC2626),
            behavior: SnackBarBehavior.floating,
            content: Text(
              'Failed to pick image: $e',
              style: GoogleFonts.rajdhani(fontWeight: FontWeight.w600),
            ),
          ),
        );
      }
    }
  }

  // Open modal bottom sheet to select profile picture
  void _openProfilePicSelector() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final customUrlController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(22.0),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 20,
                  offset: const Offset(0, -4),
                ),
              ],
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Choose Profile Picture *',
                      style: GoogleFonts.rajdhani(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Select from gallery, camera, corporate presets, or web URL',
                  style: GoogleFonts.rajdhani(
                    fontSize: 13,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 16),

                // 1. Choose from Gallery (Image Picker)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2563EB).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.photo_library_rounded, color: Color(0xFF2563EB)),
                  ),
                  title: Text(
                    'Choose from Device Gallery',
                    style: GoogleFonts.rajdhani(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text('Pick photo from your photos / files', style: GoogleFonts.rajdhani(fontSize: 12)),
                  onTap: () {
                    Navigator.pop(ctx);
                    _pickImage(ImageSource.gallery);
                  },
                ),

                // 2. Take with Camera (Image Picker)
                ListTile(
                  contentPadding: EdgeInsets.zero,
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
                    style: GoogleFonts.rajdhani(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text('Capture fresh headshot with camera', style: GoogleFonts.rajdhani(fontSize: 12)),
                  onTap: () {
                    Navigator.pop(ctx);
                    _pickImage(ImageSource.camera);
                  },
                ),

                const Divider(),
                const SizedBox(height: 8),

                Text(
                  'Corporate Preset Avatars',
                  style: GoogleFonts.rajdhani(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),

                // Preset avatars grid
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: presetAvatars.map((preset) {
                    final isSelected = selectedImageUrl == preset['url'];
                    return InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
                        setState(() {
                          selectedImageUrl = preset['url']!;
                          profilePicError = false;
                        });
                        Navigator.pop(ctx);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF2563EB)
                                : Colors.transparent,
                            width: 3,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            preset['url']!,
                            width: 54,
                            height: 54,
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) => Container(
                              width: 54,
                              height: 54,
                              color: const Color(0xFF1E40AF),
                              child: Center(
                                child: Text(
                                  preset['label']![0],
                                  style: GoogleFonts.rajdhani(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 8),

                // Custom Image URL
                Text(
                  'Or Custom Image URL',
                  style: GoogleFonts.rajdhani(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: customUrlController,
                        style: GoogleFonts.rajdhani(fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'https://example.com/photo.jpg',
                          hintStyle: GoogleFonts.rajdhani(fontSize: 13),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E40AF),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                      onPressed: () {
                        final url = customUrlController.text.trim();
                        if (url.isNotEmpty) {
                          setState(() {
                            selectedImageUrl = url;
                            profilePicError = false;
                          });
                          Navigator.pop(ctx);
                        }
                      },
                      child: Text(
                        'USE URL',
                        style: GoogleFonts.rajdhani(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  // Date picker for joining date
  void _pickJoiningDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2035),
    );

    if (picked != null) {
      final formatted = '${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}';
      setState(() {
        joiningDateController.text = formatted;
      });
    }
  }

  // Register function with full mandatory validation
  void doRegister() async {
    // Check Profile Picture selection
    if (selectedImageUrl.trim().isEmpty) {
      setState(() {
        profilePicError = true;
      });
    } else {
      setState(() {
        profilePicError = false;
      });
    }

    // Trigger Form field validators
    final isFormValid = _formKey.currentState?.validate() ?? false;

    if (!isFormValid || selectedImageUrl.trim().isEmpty) {
      setState(() {
        _autoValidateMode = AutovalidateMode.always;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'All fields including Profile Picture are mandatory!',
            style: GoogleFonts.rajdhani(fontWeight: FontWeight.w700),
          ),
          backgroundColor: const Color(0xFFDC2626),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    setState(() {
      isRegistering = true;
    });

    // Creating UserModel object with validated user input values
    UserModel emp = UserModel(
      empId: empIdController.text.trim(),
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      department: departmentController.text.trim(),
      designation: designationController.text.trim(),
      salary: salaryController.text.trim(),
      joiningDate: joiningDateController.text.trim(),
      address: addressController.text.trim(),
      imageUrl: selectedImageUrl.trim(),
    );

    // Call controller
    bool result = await widget.authController.registerEmployee(
      emp,
      passwordController.text.trim(),
    );

    if (!mounted) return;

    setState(() {
      isRegistering = false;
    });

    if (result) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Employee account registered successfully!',
            style: GoogleFonts.rajdhani(fontWeight: FontWeight.w700),
          ),
          backgroundColor: const Color(0xFF16A34A),
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              BottomNavBarScreen(authController: widget.authController),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.authController.errorMessage,
            style: GoogleFonts.rajdhani(fontWeight: FontWeight.w600),
          ),
          backgroundColor: const Color(0xFFDC2626),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  InputDecoration _buildInputDecoration({
    required String label,
    required String hint,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InputDecoration(
      labelText: '$label *',
      labelStyle: GoogleFonts.rajdhani(
        color: isDark ? Colors.grey.shade300 : const Color(0xFF475569),
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      hintText: hint,
      hintStyle: GoogleFonts.rajdhani(
        color: const Color(0xFF94A3B8),
        fontSize: 14,
      ),
      prefixIcon: Icon(icon, color: const Color(0xFF2563EB), size: 20),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF1E40AF), width: 1.8),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFDC2626), width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFDC2626), width: 2.0),
      ),
      errorStyle: GoogleFonts.rajdhani(
        color: const Color(0xFFDC2626),
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF1E40AF);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          'EMPLOYEE REGISTRATION',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Form(
                key: _formKey,
                autovalidateMode: _autoValidateMode,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Profile Picture Selector (Mandatory with image_picker)
                    Center(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: _openProfilePicSelector,
                            child: Stack(
                              children: [
                                Container(
                                  width: 96,
                                  height: 96,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: profilePicError
                                          ? const Color(0xFFDC2626)
                                          : const Color(0xFF2563EB),
                                      width: 3,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: (profilePicError
                                                ? const Color(0xFFDC2626)
                                                : const Color(0xFF2563EB))
                                            .withValues(alpha: 0.25),
                                        blurRadius: 14,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: AvatarImage(
                                    imageUrl: selectedImageUrl,
                                    size: 96,
                                    iconSize: 46,
                                  ),
                                ),
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
                                        width: 2,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt_rounded,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: _openProfilePicSelector,
                            style: TextButton.styleFrom(padding: EdgeInsets.zero),
                            child: Text(
                              selectedImageUrl.isNotEmpty
                                  ? 'Change Profile Photo *'
                                  : 'Select Profile Photo *',
                              style: GoogleFonts.rajdhani(
                                color: profilePicError
                                    ? const Color(0xFFDC2626)
                                    : const Color(0xFF2563EB),
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          if (profilePicError)
                            Text(
                              '* Profile picture is mandatory',
                              style: GoogleFonts.rajdhani(
                                color: const Color(0xFFDC2626),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    Center(
                      child: Text(
                        'Create Employee Profile',
                        style: GoogleFonts.rajdhani(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Center(
                      child: Text(
                        'All fields below are mandatory and verified',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.rajdhani(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Form Fields Container
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // 1. Employee ID (Mandatory)
                          TextFormField(
                            controller: empIdController,
                            style: GoogleFonts.rajdhani(fontSize: 15, fontWeight: FontWeight.w600),
                            decoration: _buildInputDecoration(
                              label: 'Employee ID',
                              hint: 'e.g. EMP-101',
                              icon: Icons.badge_outlined,
                            ),
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return 'Employee ID is mandatory';
                              }
                              if (val.trim().length < 3) {
                                return 'Employee ID must be at least 3 characters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 14),

                          // 2. Full Name (Mandatory)
                          TextFormField(
                            controller: nameController,
                            style: GoogleFonts.rajdhani(fontSize: 15, fontWeight: FontWeight.w600),
                            decoration: _buildInputDecoration(
                              label: 'Full Name',
                              hint: 'e.g. Mark Zuckerberg',
                              icon: Icons.person_outline_rounded,
                            ),
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return 'Full Name is mandatory';
                              }
                              if (val.trim().length < 2) {
                                return 'Full Name must be at least 2 characters';
                              }
                              if (!RegExp(r"^[a-zA-Z\s\.]+$").hasMatch(val.trim())) {
                                return 'Name must contain only alphabets';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 14),

                          // 3. Email (Mandatory)
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: GoogleFonts.rajdhani(fontSize: 15, fontWeight: FontWeight.w600),
                            decoration: _buildInputDecoration(
                              label: 'Work Email',
                              hint: 'e.g. mark@company.com',
                              icon: Icons.mail_outline_rounded,
                            ),
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return 'Email Address is mandatory';
                              }
                              final emailRegex = RegExp(r"^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$");
                              if (!emailRegex.hasMatch(val.trim())) {
                                return 'Enter a valid corporate email address';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 14),

                          // 4. Phone (Mandatory)
                          TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            style: GoogleFonts.rajdhani(fontSize: 15, fontWeight: FontWeight.w600),
                            decoration: _buildInputDecoration(
                              label: 'Phone Number',
                              hint: 'e.g. 9876543210',
                              icon: Icons.phone_outlined,
                            ),
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return 'Phone Number is mandatory';
                              }
                              final digits = val.replaceAll(RegExp(r'[^0-9]'), '');
                              if (digits.length < 10) {
                                return 'Phone number must have at least 10 digits';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 14),

                          // 5. Department (Mandatory)
                          TextFormField(
                            controller: departmentController,
                            style: GoogleFonts.rajdhani(fontSize: 15, fontWeight: FontWeight.w600),
                            decoration: _buildInputDecoration(
                              label: 'Department',
                              hint: 'e.g. Engineering, HR, Product, Sales',
                              icon: Icons.domain_rounded,
                            ),
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return 'Department is mandatory';
                              }
                              if (val.trim().length < 2) {
                                return 'Enter a valid department name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 14),

                          // 6. Designation (Mandatory)
                          TextFormField(
                            controller: designationController,
                            style: GoogleFonts.rajdhani(fontSize: 15, fontWeight: FontWeight.w600),
                            decoration: _buildInputDecoration(
                              label: 'Designation / Role',
                              hint: 'e.g. Senior Software Engineer',
                              icon: Icons.work_outline_rounded,
                            ),
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return 'Designation is mandatory';
                              }
                              if (val.trim().length < 2) {
                                return 'Enter a valid designation';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 14),

                          // 7. Salary (Mandatory)
                          TextFormField(
                            controller: salaryController,
                            style: GoogleFonts.rajdhani(fontSize: 15, fontWeight: FontWeight.w600),
                            decoration: _buildInputDecoration(
                              label: 'Salary / Package',
                              hint: 'e.g. \$85,000 / year or 60,000 / month',
                              icon: Icons.attach_money_rounded,
                            ),
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return 'Salary / Package is mandatory';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 14),

                          // 8. Joining Date (Mandatory)
                          TextFormField(
                            controller: joiningDateController,
                            readOnly: true,
                            onTap: _pickJoiningDate,
                            style: GoogleFonts.rajdhani(fontSize: 15, fontWeight: FontWeight.w600),
                            decoration: _buildInputDecoration(
                              label: 'Joining Date',
                              hint: 'Tap to select date (e.g. 15-01-2026)',
                              icon: Icons.calendar_today_outlined,
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.calendar_month_rounded, color: Color(0xFF2563EB)),
                                onPressed: _pickJoiningDate,
                              ),
                            ),
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return 'Joining Date is mandatory';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 14),

                          // 9. Address (Mandatory)
                          TextFormField(
                            controller: addressController,
                            style: GoogleFonts.rajdhani(fontSize: 15, fontWeight: FontWeight.w600),
                            decoration: _buildInputDecoration(
                              label: 'Office / City Address',
                              hint: 'e.g. Pune, Maharashtra',
                              icon: Icons.location_on_outlined,
                            ),
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return 'Address is mandatory';
                              }
                              if (val.trim().length < 3) {
                                return 'Please enter a valid address';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 14),

                          // 10. Password (Mandatory)
                          TextFormField(
                            controller: passwordController,
                            obscureText: hidePassword,
                            style: GoogleFonts.rajdhani(fontSize: 15, fontWeight: FontWeight.w600),
                            decoration: _buildInputDecoration(
                              label: 'Account Password',
                              hint: 'Minimum 6 characters',
                              icon: Icons.lock_outline_rounded,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  hidePassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: const Color(0xFF64748B),
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                              ),
                            ),
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return 'Password is mandatory';
                              }
                              if (val.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),

                          // Submit button
                          SizedBox(
                            height: 48,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 1.5,
                              ),
                              onPressed: isRegistering ? null : doRegister,
                              child: isRegistering
                                  ? const SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.2,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    )
                                  : Text(
                                      'SUBMIT REGISTRATION',
                                      style: GoogleFonts.rajdhani(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
