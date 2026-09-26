import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_logger.dart';
import '../model/country_model.dart';
import '../model/employee_model.dart';
import '../repository/employee_repository.dart';

class AddEditEmployeeScreen extends StatefulWidget {
  final EmployeeModel? employee; // null if adding, non-null if editing
  final List<CountryModel>? availableCountries;

  const AddEditEmployeeScreen({
    super.key,
    this.employee,
    this.availableCountries,
  });

  @override
  State<AddEditEmployeeScreen> createState() => _AddEditEmployeeScreenState();
}

class _AddEditEmployeeScreenState extends State<AddEditEmployeeScreen> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Text controllers for required fields: Name, Email, Mobile, Country, State, District
  late TextEditingController idController;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController mobileController;
  late TextEditingController countryController;
  late TextEditingController stateController;
  late TextEditingController districtController;

  List<CountryModel> _countries = [];
  bool _isLoadingCountries = false;

  @override
  void initState() {
    super.initState();

    // Check if we are in Edit mode or Add mode
    // Pre-populate data if editing!
    final emp = widget.employee;
    idController = TextEditingController(
      text: emp != null
          ? emp.id
          : DateTime.now().millisecondsSinceEpoch.toString().substring(9),
    );
    nameController = TextEditingController(text: emp != null ? emp.name : '');
    emailController = TextEditingController(text: emp != null ? emp.email : '');
    mobileController =
        TextEditingController(text: emp != null ? emp.mobile : '');
    countryController =
        TextEditingController(text: emp != null ? emp.country : '');
    stateController = TextEditingController(text: emp != null ? emp.state : '');
    districtController =
        TextEditingController(text: emp != null ? emp.district : '');

    _initCountries();
  }

  void _initCountries() async {
    if (widget.availableCountries != null &&
        widget.availableCountries!.isNotEmpty) {
      setState(() {
        _countries = widget.availableCountries!;
      });
    } else {
      setState(() {
        _isLoadingCountries = true;
      });
      try {
        final list = await EmployeeRepositoryImpl().getCountries();
        if (mounted) {
          setState(() {
            _countries = list;
            _isLoadingCountries = false;
          });
        }
      } catch (_) {
        if (mounted) {
          setState(() {
            _isLoadingCountries = false;
          });
        }
      }
    }
  }

  @override
  void dispose() {
    idController.dispose();
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    countryController.dispose();
    stateController.dispose();
    districtController.dispose();
    super.dispose();
  }

  // Save employee method
  void saveEmployee() {
    if (!_formKey.currentState!.validate()) {
      AppLogger.activity('Employee form validation failed');
      return;
    }

    final isEditing = widget.employee != null;
    AppLogger.activity(
      isEditing ? 'Submitting Employee update' : 'Submitting new Employee',
      {
        'id': idController.text.trim(),
        'name': nameController.text.trim(),
        'country': countryController.text.trim(),
      },
    );

    final newOrUpdatedEmployee = EmployeeModel(
      id: idController.text.trim(),
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      mobile: mobileController.text.trim(),
      country: countryController.text.trim(),
      state: stateController.text.trim(),
      district: districtController.text.trim(),
      photoUrl: widget.employee?.photoUrl ?? '',
    );

    // Return the employee object back to caller
    Navigator.pop(context, newOrUpdatedEmployee);
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
      prefixIcon: Icon(icon, color: const Color(0xFF1E40AF), size: 20),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.employee != null;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const primaryColor = Color(0xFF1E40AF);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          isEditing ? 'EDIT EMPLOYEE' : 'ADD NEW EMPLOYEE',
          style: GoogleFonts.rajdhani(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.0,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 550),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Form header card
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: primaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            isEditing ? Icons.edit_note_rounded : Icons.person_add_alt_1_rounded,
                            color: primaryColor,
                            size: 26,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isEditing ? 'Update Employee Record' : 'Create Employee Record',
                                style: GoogleFonts.rajdhani(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'Synchronized with REST API & mockapi.io database',
                                style: GoogleFonts.rajdhani(
                                  fontSize: 13,
                                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

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
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // 1. Employee ID
                        TextFormField(
                          controller: idController,
                          enabled: !isEditing, // don't change ID when editing
                          style: GoogleFonts.rajdhani(fontSize: 15, fontWeight: FontWeight.w600),
                          decoration: _buildInputDecoration(
                            label: 'Employee ID',
                            hint: 'e.g. 101',
                            icon: Icons.badge_outlined,
                          ),
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'Please enter Employee ID';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),

                        // 2. Name
                        TextFormField(
                          controller: nameController,
                          style: GoogleFonts.rajdhani(fontSize: 15, fontWeight: FontWeight.w600),
                          decoration: _buildInputDecoration(
                            label: 'Full Name',
                            hint: 'e.g. Rahul Sharma',
                            icon: Icons.person_outline_rounded,
                          ),
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'Please enter employee name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),

                        // 3. Email
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: GoogleFonts.rajdhani(fontSize: 15, fontWeight: FontWeight.w600),
                          decoration: _buildInputDecoration(
                            label: 'Email Address',
                            hint: 'Enter your email',
                            icon: Icons.mail_outline_rounded,
                          ),
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'Please enter email';
                            }
                            if (!val.contains('@')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),

                        // 4. Mobile
                        TextFormField(
                          controller: mobileController,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          style: GoogleFonts.rajdhani(fontSize: 15, fontWeight: FontWeight.w600),
                          decoration: _buildInputDecoration(
                            label: 'Mobile Number',
                            hint: 'Enter your no.',
                            icon: Icons.phone_outlined,
                          ),
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'Please enter mobile number';
                            }
                            final digits = val.replaceAll(RegExp(r'[^0-9]'), '');
                            if (digits.length != 10) {
                              return 'Mobile number must be exactly 10 digits';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),

                        // 5. Country with Autocomplete / API list
                        Autocomplete<String>(
                          initialValue: TextEditingValue(text: countryController.text),
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            if (textEditingValue.text.isEmpty) {
                              return _countries.map((c) => c.country).take(8);
                            }
                            return _countries
                                .map((c) => c.country)
                                .where((c) => c
                                    .toLowerCase()
                                    .contains(textEditingValue.text.toLowerCase()));
                          },
                          onSelected: (String selection) {
                            countryController.text = selection;
                          },
                          fieldViewBuilder:
                              (context, textEditingController, focusNode, onFieldSubmitted) {
                            // Keep countryController in sync
                            textEditingController.addListener(() {
                              countryController.text = textEditingController.text;
                            });
                            return TextFormField(
                              controller: textEditingController,
                              focusNode: focusNode,
                              style: GoogleFonts.rajdhani(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                              decoration: _buildInputDecoration(
                                label: 'Country',
                                hint: 'Enter country',
                                icon: Icons.public_rounded,
                                suffixIcon: _isLoadingCountries
                                    ? const SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: Center(
                                          child: CircularProgressIndicator(strokeWidth: 2),
                                        ),
                                      )
                                    : null,
                              ),
                              validator: (val) {
                                if (val == null || val.trim().isEmpty) {
                                  return 'Please enter country';
                                }
                                return null;
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 14),

                        // 6. State
                        TextFormField(
                          controller: stateController,
                          style: GoogleFonts.rajdhani(fontSize: 15, fontWeight: FontWeight.w600),
                          decoration: _buildInputDecoration(
                            label: 'State',
                            hint: 'e.g. Maharashtra',
                            icon: Icons.map_outlined,
                          ),
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'Please enter state';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),

                        // 7. District
                        TextFormField(
                          controller: districtController,
                          style: GoogleFonts.rajdhani(fontSize: 15, fontWeight: FontWeight.w600),
                          decoration: _buildInputDecoration(
                            label: 'District',
                            hint: 'e.g. Pune',
                            icon: Icons.location_city_outlined,
                          ),
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'Please enter district';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),

                        // Submit Button
                        SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 1.5,
                            ),
                            onPressed: saveEmployee,
                            child: Text(
                              isEditing ? 'UPDATE EMPLOYEE ON SERVER' : 'SAVE EMPLOYEE TO SERVER',
                              style: GoogleFonts.rajdhani(
                                fontSize: 16,
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
        ),
      ),
    );
  }
}
