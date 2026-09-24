

import 'package:flutter/material.dart';
import '../controller/auth_controller.dart';

class SearchScreen extends StatefulWidget {
  final AuthController authController;

  const SearchScreen({super.key, required this.authController});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  // Simple static list of directory employees to search
  final List<Map<String, String>> sampleEmployees = [
    {'name': 'Amit Kumar', 'role': 'Flutter Developer', 'dept': 'IT Department'},
    {'name': 'Sneha Rao', 'role': 'UI/UX Designer', 'dept': 'Design Department'},
    {'name': 'Rohan Mehta', 'role': 'HR Executive', 'dept': 'Human Resources'},
    {'name': 'Pooja Sharma', 'role': 'Quality Analyst', 'dept': 'QA Department'},
    {'name': 'Vikas Verma', 'role': 'Backend Engineer', 'dept': 'IT Department'},
  ];

  String filterText = '';

  @override
  Widget build(BuildContext context) {
    // Filter list based on what student types
    final filteredList = sampleEmployees.where((e) {
      final query = filterText.toLowerCase();
      return e['name']!.toLowerCase().contains(query) ||
          e['role']!.toLowerCase().contains(query) ||
          e['dept']!.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Directory'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Input Field
            TextField(
              controller: searchController,
              onChanged: (val) {
                setState(() {
                  filterText = val;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search by name, role or department...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: filterText.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            searchController.clear();
                            filterText = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Search Results
            Expanded(
              child: filteredList.isEmpty
                  ? const Center(
                      child: Text('No employees found matching search.'),
                    )
                  : ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final item = filteredList[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue.shade100,
                              child: Text(
                                item['name']![0],
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            title: Text(item['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text('${item['role']} • ${item['dept']}'),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
