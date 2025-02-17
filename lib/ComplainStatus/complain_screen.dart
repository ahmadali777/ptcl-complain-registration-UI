import 'package:flutter/material.dart';
import 'package:ptcl_app/ComplainStatus/complain_process.dart';
import 'package:ptcl_app/ComplainStatus/complain_register.dart';
import 'package:ptcl_app/ComplainStatus/complain_res.dart';
import 'package:ptcl_app/ComplainStatus/complain_resolved.dart';

class ComplainStatusScreen extends StatefulWidget {
  const ComplainStatusScreen({super.key});

  @override
  State<ComplainStatusScreen> createState() => _ComplainStatusScreenState();
}

class _ComplainStatusScreenState extends State<ComplainStatusScreen> {
  final PageController _pageController = PageController(initialPage: 0);

  final List<Widget> _pages = [
    const ComplainRegistered(
      complaintDetails: {
        'description': 'Slow Internet',
        'category': 'Ptcl Broadband',
        'date': '2024-11-25',
        'status': 'Resolved',
      },
    ),
    const ComplainResponse(
      apologyText:
          'We apologize for the inconvenience caused. Our Service agent will arrive soon',
      workerDetails: {
        'profilePic': 'https://via.placeholder.com/150', // Replace with actual image URL
        'name': 'Asim Khan',
        'serviceTime': '2:00 PM',
        'callNumber': '123-456-7890',
      },
    ),
    const ComplainInProcess(
      tasks: [
        {'name': 'Diagnosing the issue', 'status': 'Done'},
        {'name': 'Fixing broadband connection', 'status': 'In Progress'},
        {'name': 'Testing the connection', 'status': 'Pending'},
      ],
    ),
    const ComplainSolved(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complain Status'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: _pages.length,
        itemBuilder: (context, index) {
          return _pages[index];
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
