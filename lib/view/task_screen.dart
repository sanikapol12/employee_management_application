

import 'package:flutter/material.dart';
import '../controller/auth_controller.dart';

class TaskScreen extends StatefulWidget {
  final AuthController authController;

  const TaskScreen({super.key, required this.authController});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TextEditingController newTaskController = TextEditingController();

  // Simple task list with completion status
  List<Map<String, dynamic>> myTasks = [
    {'title': 'Complete employee onboarding documentation', 'done': true},
    {'title': 'Review project requirements document', 'done': false},
    {'title': 'Attend weekly department sync call', 'done': false},
    {'title': 'Submit weekly timesheet and status report', 'done': false},
  ];

  // Function to add new task
  void addTask() {
    if (newTaskController.text.trim().isNotEmpty) {
      setState(() {
        myTasks.add({
          'title': newTaskController.text.trim(),
          'done': false,
        });
        newTaskController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New task added!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Add task input row
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: newTaskController,
                    decoration: InputDecoration(
                      hintText: 'Enter new task...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                  onPressed: () {
                    addTask();
                  },
                  child: const Text('ADD'),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Tasks List
            Expanded(
              child: myTasks.isEmpty
                  ? const Center(child: Text('No tasks available!'))
                  : ListView.builder(
                      itemCount: myTasks.length,
                      itemBuilder: (context, index) {
                        final task = myTasks[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: CheckboxListTile(
                            title: Text(
                              task['title'],
                              style: TextStyle(
                                decoration: task['done']
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: task['done'] ? Colors.grey : Colors.black87,
                              ),
                            ),
                            value: task['done'],
                            activeColor: Colors.blue,
                            onChanged: (bool? val) {
                              setState(() {
                                task['done'] = val ?? false;
                              });
                            },
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
