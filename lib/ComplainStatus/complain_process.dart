import 'package:flutter/material.dart';
import 'package:ptcl_app/HomeScreen/notifications.dart';

class ComplainInProcess extends StatelessWidget {
  final List<Map<String, String>> tasks;

  const ComplainInProcess({super.key, required this.tasks});

  Color _getTaskColor(String status) {
    switch (status) {
      case 'Done':
        return Colors.green;
      case 'In Progress':
        return Colors.orange;
      case 'Pending':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Trigger notification after widget build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showNotification(
        id: 3,
        title: 'Complaint In Process',
        body: 'Your complaint is being processed. Stay tuned for updates.',
      );
    });

    return SizedBox(
      width: double.infinity,
      height: 250,
      child: Card(
        margin: const EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Complain In Process',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _getTaskColor(task['status']!),
                      radius: 10,
                    ),
                    title: Text(task['name']!),
                    subtitle: Text('Status: ${task['status']}'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
