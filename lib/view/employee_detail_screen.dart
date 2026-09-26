import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/employee_model.dart';
import '../repository/employee_repository.dart';
import 'add_edit_employee_screen.dart';

class EmployeeDetailScreen extends StatefulWidget {
  final EmployeeModel employee;
  final Function(EmployeeModel updated)? onEdit;
  final Function(String id)? onDelete;

  const EmployeeDetailScreen({
    super.key,
    required this.employee,
    this.onEdit,
    this.onDelete,
  });

  @override
  State<EmployeeDetailScreen> createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
  late EmployeeModel currentEmployee;
  final EmployeeRepository _repository = EmployeeRepositoryImpl();
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    currentEmployee = widget.employee;
  }

  // Fetch fresh employee from REST API GET /employee/:id
  Future<void> _refreshFromApi() async {
    setState(() {
      _isRefreshing = true;
    });

    try {
      final fresh = await _repository.getEmployeeById(currentEmployee.id);
      if (mounted) {
        setState(() {
          currentEmployee = fresh;
          _isRefreshing = false;
        });
        widget.onEdit?.call(fresh);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xFF16A34A),
            behavior: SnackBarBehavior.floating,
            content: Text(
              'Fetched fresh record for ${fresh.name} from server!',
              style: GoogleFonts.rajdhani(fontWeight: FontWeight.w600),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isRefreshing = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xFFD97706),
            behavior: SnackBarBehavior.floating,
            content: Text(
              'Could not refresh from server: $e',
              style: GoogleFonts.rajdhani(fontWeight: FontWeight.w600),
            ),
          ),
        );
      }
    }
  }

  // Delete employee confirmation dialog
  void showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Confirm Delete',
          style: GoogleFonts.rajdhani(fontWeight: FontWeight.w700),
        ),
        content: Text(
          'Are you sure you want to delete ${currentEmployee.name} (ID: ${currentEmployee.id})?',
          style: GoogleFonts.rajdhani(fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'CANCEL',
              style: GoogleFonts.rajdhani(fontWeight: FontWeight.w700),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
            ),
            onPressed: () {
              Navigator.pop(ctx); // Close dialog
              widget.onDelete?.call(currentEmployee.id);
              Navigator.pop(context); // Go back to employee list
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

  // Open Edit Screen
  void openEditScreen() async {
    final updated = await Navigator.push<EmployeeModel>(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditEmployeeScreen(employee: currentEmployee),
      ),
    );

    if (updated != null) {
      setState(() {
        currentEmployee = updated;
      });
      widget.onEdit?.call(updated);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const primaryColor = Color(0xFF1E40AF);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          'EMPLOYEE DETAILS',
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
        actions: [
          if (_isRefreshing)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.sync_rounded),
              tooltip: 'Sync with API (GET /employee/:id)',
              onPressed: _refreshFromApi,
            ),
          IconButton(
            icon: const Icon(Icons.edit_rounded),
            tooltip: 'Edit Employee',
            onPressed: openEditScreen,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded),
            tooltip: 'Delete Employee',
            onPressed: showDeleteConfirmation,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 550),
            child: Column(
              children: [
                const SizedBox(height: 10),

                // Profile Avatar with initial or image
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2563EB).withValues(alpha: 0.25),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      currentEmployee.name.isNotEmpty
                          ? currentEmployee.name[0].toUpperCase()
                          : 'E',
                      style: GoogleFonts.rajdhani(
                        fontSize: 38,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Employee Name
                Text(
                  currentEmployee.name,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rajdhani(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),

                // Employee ID badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  decoration: BoxDecoration(
                    color: primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: primaryColor.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    'ID: ${currentEmployee.id}',
                    style: GoogleFonts.rajdhani(
                      fontWeight: FontWeight.w700,
                      color: primaryColor,
                      fontSize: 14,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // All required details cards: Name, Email, Mobile, Country, State, District
                _buildDetailCard(
                  Icons.email_outlined,
                  'Work Email',
                  currentEmployee.email,
                  isDark,
                ),
                _buildDetailCard(
                  Icons.phone_outlined,
                  'Mobile Number',
                  currentEmployee.mobile,
                  isDark,
                ),
                _buildDetailCard(
                  Icons.public_rounded,
                  'Country',
                  currentEmployee.country,
                  isDark,
                ),
                _buildDetailCard(
                  Icons.map_outlined,
                  'State / Region',
                  currentEmployee.state,
                  isDark,
                ),
                _buildDetailCard(
                  Icons.location_city_outlined,
                  'District / City',
                  currentEmployee.district,
                  isDark,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailCard(
      IconData icon, String title, String value, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
        ),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF1E40AF).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF1E40AF), size: 22),
        ),
        title: Text(
          title,
          style: GoogleFonts.rajdhani(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.grey.shade400 : const Color(0xFF64748B),
          ),
        ),
        subtitle: Text(
          value.isNotEmpty ? value : 'Not provided',
          style: GoogleFonts.rajdhani(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : const Color(0xFF0F172A),
          ),
        ),
      ),
    );
  }
}
