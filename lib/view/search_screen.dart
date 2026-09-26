import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_logger.dart';
import '../controller/auth_controller.dart';
import '../controller/employee_controller.dart';
import 'employee_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  final AuthController authController;
  final EmployeeController? employeeController;

  const SearchScreen({
    super.key,
    required this.authController,
    this.employeeController,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final EmployeeController employeeController;
  final TextEditingController searchController = TextEditingController();
  final TextEditingController idSearchController = TextEditingController();

  String selectedFilter = 'All'; // 'All', 'Name', 'Email', 'Mobile', 'Country'
  bool isSearchingById = false;

  @override
  void initState() {
    super.initState();
    employeeController = widget.employeeController ?? EmployeeController();
    employeeController.fetchEmployees();
    employeeController.fetchCountries();
  }

  @override
  void dispose() {
    searchController.dispose();
    idSearchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String val) {
    employeeController.setFilter(val, selectedFilter);
  }

  void _searchDirectById() async {
    final id = idSearchController.text.trim();
    AppLogger.activity('Executing direct ID search', {'searchId': id});
    if (id.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter an Employee ID to search',
            style: GoogleFonts.rajdhani(fontWeight: FontWeight.w600),
          ),
          backgroundColor: const Color(0xFFDC2626),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Fetching Employee ID $id via REST API...',
          style: GoogleFonts.rajdhani(fontWeight: FontWeight.w600),
        ),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );

    final emp = await employeeController.getEmployeeById(id);
    if (!mounted) return;

    if (emp != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmployeeDetailScreen(employee: emp),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'No employee found on server with ID: $id',
            style: GoogleFonts.rajdhani(fontWeight: FontWeight.w600),
          ),
          backgroundColor: const Color(0xFFDC2626),
          behavior: SnackBarBehavior.floating,
        ),
      );
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
          'SEARCH & FILTER DIRECTORY',
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
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              isSearchingById ? Icons.filter_alt_rounded : Icons.badge_rounded,
              color: Colors.white,
            ),
            tooltip: isSearchingById ? 'Filter Search' : 'Search by exact ID',
            onPressed: () {
              setState(() {
                isSearchingById = !isSearchingById;
              });
            },
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: employeeController,
        builder: (context, _) {
          final employees = employeeController.employeeList;

          return Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Search Input Field
                if (isSearchingById) ...[
                  // Direct ID Search bar (GET /employee/:id)
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1),
                      ),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 12),
                        const Icon(Icons.badge_rounded, color: primaryColor),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: idSearchController,
                            keyboardType: TextInputType.text,
                            style: GoogleFonts.rajdhani(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Enter exact ID to query API (e.g. 1)...',
                              hintStyle: GoogleFonts.rajdhani(
                                color: const Color(0xFF94A3B8),
                                fontSize: 14,
                              ),
                              border: InputBorder.none,
                            ),
                            onSubmitted: (_) => _searchDirectById(),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward_rounded, color: primaryColor),
                          onPressed: _searchDirectById,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ] else ...[
                  // Filter Search Input Field
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1),
                      ),
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: _onSearchChanged,
                      style: GoogleFonts.rajdhani(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search employees by $selectedFilter...',
                        hintStyle: GoogleFonts.rajdhani(
                          color: const Color(0xFF94A3B8),
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(Icons.search_rounded, color: primaryColor),
                        suffixIcon: searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear_rounded),
                                onPressed: () {
                                  searchController.clear();
                                  _onSearchChanged('');
                                },
                              )
                            : null,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Filter Chips: Name, Email, Mobile, Country, All
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: ['All', 'Name', 'Email', 'Mobile', 'Country']
                          .map((type) {
                        final isSelected = selectedFilter == type;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: FilterChip(
                            label: Text(
                              type,
                              style: GoogleFonts.rajdhani(
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                                color: isSelected
                                    ? Colors.white
                                    : (isDark ? Colors.grey.shade300 : const Color(0xFF475569)),
                              ),
                            ),
                            selected: isSelected,
                            selectedColor: primaryColor,
                            backgroundColor:
                                isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                            checkmarkColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: isSelected
                                    ? primaryColor
                                    : (isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
                              ),
                            ),
                            onSelected: (val) {
                              setState(() {
                                selectedFilter = type;
                              });
                              employeeController.setFilter(
                                searchController.text,
                                type,
                              );
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  if (selectedFilter == 'Country' && employeeController.countries.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 6.0),
                            child: ActionChip(
                              avatar: const Icon(Icons.public_rounded, size: 14, color: primaryColor),
                              label: Text(
                                'Clear',
                                style: GoogleFonts.rajdhani(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: primaryColor,
                                ),
                              ),
                              onPressed: () {
                                searchController.clear();
                                _onSearchChanged('');
                              },
                            ),
                          ),
                          ...employeeController.countries
                              .map((c) => c.country)
                              .where((c) => c.isNotEmpty)
                              .toSet()
                              .take(15)
                              .map((countryName) {
                            final isCurr = searchController.text.toLowerCase() == countryName.toLowerCase();
                            return Padding(
                              padding: const EdgeInsets.only(right: 6.0),
                              child: ChoiceChip(
                                label: Text(
                                  countryName,
                                  style: GoogleFonts.rajdhani(
                                    fontSize: 12,
                                    fontWeight: isCurr ? FontWeight.w700 : FontWeight.w600,
                                  ),
                                ),
                                selected: isCurr,
                                selectedColor: primaryColor,
                                onSelected: (selected) {
                                  if (selected) {
                                    searchController.text = countryName;
                                    _onSearchChanged(countryName);
                                  } else {
                                    searchController.clear();
                                    _onSearchChanged('');
                                  }
                                },
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 12),
                ],

                // Results count bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'MATCHING RECORDS (${employees.length})',
                        style: GoogleFonts.rajdhani(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.grey.shade400 : const Color(0xFF64748B),
                          letterSpacing: 0.8,
                        ),
                      ),
                      if (employeeController.isLoading)
                        const SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),

                // Search Results List
                Expanded(
                  child: employees.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person_search_rounded,
                                size: 54,
                                color: isDark ? Colors.grey.shade700 : Colors.grey.shade400,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'No employees match "$selectedFilter" filter',
                                style: GoogleFonts.rajdhani(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: employees.length,
                          itemBuilder: (context, index) {
                            final emp = employees[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                                ),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 4,
                                ),
                                leading: Container(
                                  width: 42,
                                  height: 42,
                                  decoration: BoxDecoration(
                                    color: primaryColor.withValues(alpha: 0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      emp.name.isNotEmpty ? emp.name[0].toUpperCase() : 'E',
                                      style: GoogleFonts.rajdhani(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: primaryColor,
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
                                subtitle: Text(
                                  'ID: ${emp.id} • ${emp.email}\n${emp.country} | ${emp.mobile}',
                                  style: GoogleFonts.rajdhani(
                                    fontSize: 13,
                                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                                  ),
                                ),
                                isThreeLine: true,
                                trailing: const Icon(
                                  Icons.chevron_right_rounded,
                                  color: Color(0xFF94A3B8),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EmployeeDetailScreen(employee: emp),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
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
