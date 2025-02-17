import 'package:flutter/material.dart';
import 'package:ptcl_app/HomeScreen/notifications.dart';

class ComplainRegistered extends StatefulWidget {
  final Map<String, String> complaintDetails;

  const ComplainRegistered({
    super.key,
    required this.complaintDetails,
  });

  @override
  _ComplainRegisteredState createState() => _ComplainRegisteredState();
}

class _ComplainRegisteredState extends State<ComplainRegistered> {


  @override
  void initState() {
    super.initState();
    showNotification(id: 1, title: 'Complain Status', body: 'Your Complain have been registered', ); // Trigger notification when widget is initialized.
  }

  @override
  Widget build(BuildContext context) {
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
                'Complaint Registered',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text('Description: ${widget.complaintDetails['description'] ?? 'N/A'}'),
              Text('Category: ${widget.complaintDetails['category'] ?? 'N/A'}'),
              Text('Date: ${widget.complaintDetails['date'] ?? 'N/A'}'),
              Text('Status: ${widget.complaintDetails['status'] ?? 'N/A'}'),
            ],
          ),
        ),
      ),
    );
  }
}
