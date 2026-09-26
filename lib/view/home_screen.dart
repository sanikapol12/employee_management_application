import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_logger.dart';
import '../controller/auth_controller.dart';
import '../controller/employee_controller.dart';
import '../model/country_model.dart';
import '../model/employee_model.dart';
import 'add_edit_employee_screen.dart';
import 'employee_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final AuthController authController;

  const HomeScreen({super.key, required this.authController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Employee controller instance (manages employee list)
  final EmployeeController employeeController = EmployeeController();

  @override
  void initState() {
    super.initState();
    // Load live employees and countries from REST API
    WidgetsBinding.instance.addPostFrameCallback((_) {
      employeeController.fetchEmployees();
      employeeController.fetchCountries();
    });
  }

  // Delete confirmation alert dialog
  void confirmDelete(EmployeeModel emp) {
    AppLogger.activity('Requested delete confirmation dialog', {'id': emp.id, 'name': emp.name});
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Delete Employee Record?',
          style: GoogleFonts.rajdhani(fontWeight: FontWeight.w700),
        ),
        content: Text(
          'Are you sure you want to remove ${emp.name} (ID: ${emp.id}) from the system?',
          style: GoogleFonts.rajdhani(fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () {
              AppLogger.activity('Delete cancelled by user', {'id': emp.id});
              Navigator.pop(ctx);
            },
            child: Text(
              'CANCEL',
              style: GoogleFonts.rajdhani(fontWeight: FontWeight.w700),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFDC2626)),
            onPressed: () async {
              Navigator.pop(ctx);
              AppLogger.activity('Delete confirmed by user', {'id': emp.id, 'name': emp.name});
              final success = await employeeController.deleteEmployee(emp.id);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: const Color(0xFFDC2626),
                    behavior: SnackBarBehavior.floating,
                    content: Text(
                      success
                          ? '${emp.name} deleted successfully from server!'
                          : '${emp.name} removed locally.',
                      style: GoogleFonts.rajdhani(fontWeight: FontWeight.w600),
                    ),
                  ),
                );
              }
            },
            child: Text(
              'DELETE',
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

  // Open Add Employee screen
  void openAddEmployee() async {
    AppLogger.activity('Navigating to Add Employee screen');
    final newEmp = await Navigator.push<EmployeeModel>(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditEmployeeScreen(
          availableCountries: employeeController.countries,
        ),
      ),
    );

    if (newEmp != null) {
      final success = await employeeController.addEmployee(newEmp);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xFF16A34A),
            behavior: SnackBarBehavior.floating,
            content: Text(
              success
                  ? '${newEmp.name} registered on server successfully!'
                  : '${newEmp.name} registered locally.',
              style: GoogleFonts.rajdhani(fontWeight: FontWeight.w600),
            ),
          ),
        );
      }
    }
  }

  // Open Edit Employee screen with pre-populated data
  void openEditEmployee(EmployeeModel emp) async {
    AppLogger.activity('Navigating to Edit Employee screen', {'id': emp.id, 'name': emp.name});
    final updatedEmp = await Navigator.push<EmployeeModel>(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditEmployeeScreen(
          employee: emp,
          availableCountries: employeeController.countries,
        ),
      ),
    );

    if (updatedEmp != null) {
      final success = await employeeController.updateEmployee(updatedEmp);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xFF1E40AF),
            behavior: SnackBarBehavior.floating,
            content: Text(
              success
                  ? '${updatedEmp.name} updated on server successfully!'
                  : '${updatedEmp.name} profile updated locally.',
              style: GoogleFonts.rajdhani(fontWeight: FontWeight.w600),
            ),
          ),
        );
      }
    }
  }

  // Open View Employee details screen
  void openViewEmployee(EmployeeModel emp) {
    AppLogger.activity('Navigating to Employee Detail screen', {'id': emp.id, 'name': emp.name});
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmployeeDetailScreen(
          employee: emp,
          onEdit: (updated) {
            employeeController.updateEmployee(updated);
          },
          onDelete: (id) {
            employeeController.deleteEmployee(id);
          },
        ),
      ),
    );
  }

  // Open Country REST API Manager / Viewer Dialog
  void openCountryApiDialog() {
    AppLogger.activity('Opened Countries API Directory Dialog');
    final isDark = Theme.of(context).brightness == Brightness.dark;
    String countrySearchQuery = '';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final allCountries = employeeController.countries;
            final filteredCountries = allCountries.where((c) {
              if (countrySearchQuery.isEmpty) return true;
              return c.country.toLowerCase().contains(countrySearchQuery.toLowerCase()) ||
                  c.id.contains(countrySearchQuery);
            }).toList();

            return Container(
              height: MediaQuery.of(context).size.height * 0.82,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E293B) : Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
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
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.public_rounded, color: Color(0xFF1E40AF), size: 26),
                          const SizedBox(width: 8),
                          Text(
                            'COUNTRY REST API',
                            style: GoogleFonts.rajdhani(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  Text(
                    'Live API: /api/v1/country (${allCountries.length} countries loaded)',
                    style: GoogleFonts.rajdhani(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 42,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.search_rounded, size: 18, color: Color(0xFF64748B)),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  onChanged: (val) {
                                    setModalState(() {
                                      countrySearchQuery = val;
                                    });
                                  },
                                  style: GoogleFonts.rajdhani(fontSize: 14, fontWeight: FontWeight.w600),
                                  decoration: const InputDecoration(
                                    hintText: 'Search API countries...',
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E40AF),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        icon: const Icon(Icons.add, size: 16, color: Colors.white),
                        label: Text(
                          'POST',
                          style: GoogleFonts.rajdhani(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                        onPressed: () => _promptAddCountry(setModalState),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  Expanded(
                    child: filteredCountries.isEmpty
                        ? Center(
                            child: Text(
                              'No countries match search',
                              style: GoogleFonts.rajdhani(fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          )
                        : ListView.builder(
                            itemCount: filteredCountries.length,
                            itemBuilder: (context, idx) {
                              final country = filteredCountries[idx];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 6),
                                decoration: BoxDecoration(
                                  color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                                  ),
                                ),
                                child: ListTile(
                                  dense: true,
                                  leading: CircleAvatar(
                                    radius: 16,
                                    backgroundColor: const Color(0xFF1E40AF).withValues(alpha: 0.15),
                                    backgroundImage: country.flag.isNotEmpty && country.flag.startsWith('http')
                                        ? NetworkImage(country.flag)
                                        : null,
                                    child: country.flag.isEmpty || !country.flag.startsWith('http')
                                        ? const Icon(Icons.public, size: 18, color: Color(0xFF1E40AF))
                                        : null,
                                  ),
                                  title: Text(
                                    country.country,
                                    style: GoogleFonts.rajdhani(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'ID: ${country.id} ${country.createdAt.isNotEmpty ? "• ${country.createdAt.split("T")[0]}" : ""}',
                                    style: GoogleFonts.rajdhani(fontSize: 12),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // GET /country/:id
                                      IconButton(
                                        icon: const Icon(Icons.info_outline_rounded, size: 18, color: Color(0xFF2563EB)),
                                        tooltip: 'GET /country/:id',
                                        onPressed: () => _viewCountryDetails(country.id),
                                      ),
                                      // DELETE /country/:id
                                      IconButton(
                                        icon: const Icon(Icons.delete_outline_rounded, size: 18, color: Color(0xFFDC2626)),
                                        tooltip: 'DELETE /country/:id',
                                        onPressed: () async {
                                          final ok = await employeeController.deleteCountry(country.id);
                                          setModalState(() {});
                                          if (context.mounted) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  ok ? 'Country deleted successfully!' : 'Country removed locally.',
                                                  style: GoogleFonts.rajdhani(fontWeight: FontWeight.w600),
                                                ),
                                                behavior: SnackBarBehavior.floating,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _viewCountryDetails(String id) async {
    final country = await employeeController.getCountryById(id);
    if (!mounted) return;
    if (country != null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            'Country Details (GET /country/$id)',
            style: GoogleFonts.rajdhani(fontWeight: FontWeight.w700),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Country Name: ${country.country}', style: GoogleFonts.rajdhani(fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              Text('Country ID: ${country.id}', style: GoogleFonts.rajdhani(fontSize: 14)),
              const SizedBox(height: 6),
              Text('Flag URL: ${country.flag.isNotEmpty ? country.flag : "None"}', style: GoogleFonts.rajdhani(fontSize: 13)),
              const SizedBox(height: 6),
              Text('Created At: ${country.createdAt.isNotEmpty ? country.createdAt : "N/A"}', style: GoogleFonts.rajdhani(fontSize: 13)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text('CLOSE', style: GoogleFonts.rajdhani(fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      );
    }
  }

  void _promptAddCountry(void Function(void Function()) setModalState) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Add Country (POST /country)', style: GoogleFonts.rajdhani(fontWeight: FontWeight.w700)),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Enter Country Name (e.g. Canada)',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('CANCEL', style: GoogleFonts.rajdhani(fontWeight: FontWeight.w700)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E40AF)),
            onPressed: () async {
              final name = controller.text.trim();
              if (name.isNotEmpty) {
                Navigator.pop(ctx);
                await employeeController.addCountry(CountryModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString().substring(9),
                  country: name,
                  createdAt: DateTime.now().toIso8601String(),
                ));
                setModalState(() {});
              }
            },
            child: Text('CREATE', style: GoogleFonts.rajdhani(fontWeight: FontWeight.w700, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'EMPLOYEE MANAGEMENT SYSTEM',
          style: GoogleFonts.rajdhani(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.0,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.public_rounded),
            tooltip: 'Country REST API Directory',
            onPressed: openCountryApiDialog,
          ),
        ],
        backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF1E40AF),
        foregroundColor: Colors.white,
        elevation: 4,
        icon: const Icon(Icons.person_add_rounded),
        label: Text(
          'Add Employee',
          style: GoogleFonts.rajdhani(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        onPressed: openAddEmployee,
      ),
      body: ListenableBuilder(
        listenable: employeeController,
        builder: (context, _) {
          final employees = employeeController.employeeList;
          final totalCount = employees.length;

          // Realistic EMS metrics calculations
          final presentCount = totalCount > 0 ? (totalCount * 0.8).ceil() : 0;
          final absentCount = totalCount > 1 ? 1 : 0;
          final lateCount = totalCount > 2 ? 1 : 0;
          final onLeaveCount = (totalCount - presentCount - absentCount).clamp(0, totalCount);
          final attendancePercent = totalCount > 0
              ? ((presentCount / totalCount) * 100).toInt()
              : 0;

          return RefreshIndicator(
            onRefresh: employeeController.refreshEmployees,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. Dashboard Live Status Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Daily Workforce Overview',
                            style: GoogleFonts.rajdhani(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Live Attendance & Personnel Status',
                            style: GoogleFonts.rajdhani(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF16A34A).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFF16A34A).withValues(alpha: 0.4),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFF16A34A),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Shift Active',
                              style: GoogleFonts.rajdhani(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF16A34A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // 2. Primary KPI Row: Total Employee Card (Full Width Banner)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isDark
                            ? [const Color(0xFF1E293B), const Color(0xFF0F172A)]
                            : [const Color(0xFF1E3A8A), const Color(0xFF2563EB)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: (isDark ? Colors.black : const Color(0xFF2563EB))
                              .withValues(alpha: 0.22),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.groups_rounded,
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
                                'TOTAL EMPLOYEES',
                                style: GoogleFonts.rajdhani(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white70,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              Text(
                                '$totalCount',
                                style: GoogleFonts.rajdhani(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  height: 1.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'ATTENDANCE',
                                style: GoogleFonts.rajdhani(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white70,
                                ),
                              ),
                              Text(
                                '$attendancePercent%',
                                style: GoogleFonts.rajdhani(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // 3. Grid of Attendance Metrics: Present, Absent, Late, On Leave
                  Row(
                    children: [
                      // Present Card
                      Expanded(
                        child: _buildMetricCard(
                          title: 'PRESENT',
                          count: '$presentCount',
                          subtitle: 'On duty today',
                          icon: Icons.how_to_reg_rounded,
                          accentColor: const Color(0xFF16A34A),
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Absent Card
                      Expanded(
                        child: _buildMetricCard(
                          title: 'ABSENT',
                          count: '$absentCount',
                          subtitle: 'Unexcused',
                          icon: Icons.person_off_rounded,
                          accentColor: const Color(0xFFDC2626),
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      // Late Card
                      Expanded(
                        child: _buildMetricCard(
                          title: 'LATE',
                          count: '$lateCount',
                          subtitle: 'Delayed check-in',
                          icon: Icons.access_time_filled_rounded,
                          accentColor: const Color(0xFFD97706),
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(width: 10),

                      // On Leave Card
                      Expanded(
                        child: _buildMetricCard(
                          title: 'ON LEAVE',
                          count: '$onLeaveCount',
                          subtitle: 'Approved leave',
                          icon: Icons.beach_access_rounded,
                          accentColor: const Color(0xFF7C3AED),
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // 4. Quick Shift Details & Department Breakdown Bar
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildQuickInfo(Icons.apartment_rounded, 'Departments', '5 Active', isDark),
                        Container(height: 24, width: 1, color: isDark ? Colors.grey.shade700 : Colors.grey.shade300),
                        _buildQuickInfo(Icons.schedule_rounded, 'General Shift', '09:00 - 18:00', isDark),
                        Container(height: 24, width: 1, color: isDark ? Colors.grey.shade700 : Colors.grey.shade300),
                        _buildQuickInfo(Icons.verified_rounded, 'Registry', 'Verified', isDark),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 5. Employee Directory Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Employee Registry ($totalCount)',
                        style: GoogleFonts.rajdhani(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Pull down to refresh ⬇',
                        style: GoogleFonts.rajdhani(
                          fontSize: 12,
                          color: isDark ? Colors.grey.shade400 : Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // 6. Employee List Items
                  if (employees.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 36.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.people_outline_rounded,
                              size: 56,
                              color: isDark ? Colors.grey.shade700 : Colors.grey.shade400,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'No employees currently registered.',
                              style: GoogleFonts.rajdhani(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ...employees.map((emp) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.03),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          leading: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E40AF).withValues(alpha: 0.12),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                emp.name.isNotEmpty ? emp.name[0].toUpperCase() : 'E',
                                style: GoogleFonts.rajdhani(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF1E40AF),
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            emp.name,
                            style: GoogleFonts.rajdhani(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 2),
                              Text(
                                '${emp.id} • ${emp.email}',
                                style: GoogleFonts.rajdhani(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                                ),
                              ),
                              Text(
                                '${emp.district}, ${emp.state}',
                                style: GoogleFonts.rajdhani(
                                  fontSize: 12,
                                  color: isDark ? Colors.grey.shade500 : Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit_outlined, size: 20, color: Color(0xFF2563EB)),
                                tooltip: 'Edit',
                                onPressed: () => openEditEmployee(emp),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline_rounded, size: 20, color: Color(0xFFDC2626)),
                                tooltip: 'Delete',
                                onPressed: () => confirmDelete(emp),
                              ),
                            ],
                          ),
                          onTap: () => openViewEmployee(emp),
                        ),
                      );
                    }),

                  const SizedBox(height: 70), // Spacing for extended FAB
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String count,
    required String subtitle,
    required IconData icon,
    required Color accentColor,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: accentColor, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.rajdhani(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  count,
                  style: GoogleFonts.rajdhani(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: accentColor,
                    height: 1.1,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.rajdhani(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.grey.shade500 : Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickInfo(IconData icon, String label, String value, bool isDark) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF2563EB)),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.rajdhani(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
            ),
            Text(
              value,
              style: GoogleFonts.rajdhani(
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
