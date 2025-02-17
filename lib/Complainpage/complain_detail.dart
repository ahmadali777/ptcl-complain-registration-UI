import 'package:flutter/material.dart';

class ComplainDetail extends StatelessWidget {
  final Map<String, dynamic> complaint;

  const ComplainDetail({super.key, required this.complaint});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complaint Details'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Complaint description
            Text(
              'Description: ${complaint['description']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),

            // Category
            Text(
              'Category: ${complaint['category']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16.0),

            // Date
            Text(
              'Date: ${complaint['date']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16.0),

            // Status
            Text(
              'Status: ${complaint['status']}',
              style: TextStyle(
                fontSize: 16,
                color: _getStatusColor(complaint['status']),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Get color based on status
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Resolved':
        return Colors.green;
      case 'In Progress':
        return Colors.orange;
      case 'Pending':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
