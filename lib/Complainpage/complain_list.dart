import 'package:flutter/material.dart';
import 'package:ptcl_app/Complainpage/complain_detail.dart';

class ComplainList extends StatelessWidget {
  final List<Map<String, dynamic>> complaints = [
    {
      'description': 'Internet not Accesible',
      'category': 'Ptcl fiber',
      'date': '2024-12-10',
      'status': 'Pending',
    },
    {
      'description': 'Slow Internet.',
      'category': 'Ptcl Broadband',
      'date': '2024-11-25',
      'status': 'In Progress',
    },
    {
      'description': 'Disconnected line',
      'category': 'Line Repair',
      'date': '2024-06-20',
      'status': 'Resolved',
    },
    {
      'description': 'Noise in Phonecall',
      'category': 'Phone/landline',
      'date': '2024-01-18',
      'status': 'Pending',
    },
  ];

   ComplainList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: complaints.isEmpty
          ? const SizedBox(
              height: 300,
              child: Center(
                child: Text(
                  'No complaints found.',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            )
          : ListView.builder(
              itemCount: complaints.length,
              itemBuilder: (context, index) {
                final complaint = complaints[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: const BorderSide(color: Color.fromRGBO(76, 175, 80, 1), width: 1.5),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _getStatusColor(complaint['status']),
                      child: const Icon(
                        Icons.report_problem,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      complaint['description'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Category: ${complaint['category']}'),
                        Text('Date: ${complaint['date']}'),
                        Text(
                          'Status: ${complaint['status']}',
                          style: TextStyle(color: _getStatusColor(complaint['status'])),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.arrow_forward, color: Colors.green),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ComplainDetail(complaint: complaint,)),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }

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
