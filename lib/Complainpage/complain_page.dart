import 'package:flutter/material.dart';
import 'package:ptcl_app/Complainpage/complain_input.dart';
import 'package:ptcl_app/Complainpage/complain_list.dart';


class ComplainScreen extends StatefulWidget {
  const ComplainScreen({super.key});

  @override
  State<ComplainScreen> createState() => _ComplainScreenState();
}

class _ComplainScreenState extends State<ComplainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complaints Dashboard'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // Display the Complain List
          Expanded(
            child: ComplainList(),  // Display the list of complaints
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the complaint input form
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ComplainInputForm(),
            ),
          );
        },
        backgroundColor: Colors.green,
        tooltip: "Add a Complain",
        child: const Icon(Icons.add),
      ),
    );
  }
}
