import 'package:flutter/material.dart';

class NearbyOfficeLocatorScreen extends StatelessWidget {
  const NearbyOfficeLocatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Office Locator'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 200,
            color: Colors.green.shade200,
            child: const Center(
              child: Text(
                'Map Placeholder',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Office Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.location_on, color: Colors.green),
            title: const Text('PTCL Office 1'),
            subtitle: const Text('123 Main Street, City A'),
            trailing: const Text('5.2 km'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening Office 1 Details')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.location_on, color: Colors.green),
            title: const Text('PTCL Office 2'),
            subtitle: const Text('456 Another St, City B'),
            trailing: const Text('8.7 km'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening Office 2 Details')),
              );
            },
          ),
        ],
      ),
    );
  }
}
