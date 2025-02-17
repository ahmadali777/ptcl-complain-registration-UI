import 'package:flutter/material.dart';
import 'package:ptcl_app/HomeScreen/notifications.dart';

class ComplainResponse extends StatelessWidget {
  final String apologyText;
  final Map<String, dynamic> workerDetails;

  const ComplainResponse({
    super.key,
    required this.apologyText,
    required this.workerDetails,
  });

  @override
  Widget build(BuildContext context) {
    // Trigger notification after widget build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showNotification(
        id: 2,
        title: 'Complaint Response',
        body: 'Your complaint has been acknowledged. Please check details.',
      );
    });

    return SizedBox(
      width: double.infinity,
      height: 300,
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
                'Complain Response',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(apologyText),
              const Divider(height: 16.0),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(workerDetails['profilePic']),
                    radius: 30,
                  ),
                  const SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: ${workerDetails['name']}'),
                      Text('Service Time: ${workerDetails['serviceTime']}'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              ElevatedButton.icon(
                onPressed: () {
                  // Navigate to the calling UI
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CallingScreen(workerDetails: workerDetails),
                    ),
                  );
                },
                icon: const Icon(Icons.phone),
                label: const Text('Call PTCL Service Person'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CallingScreen extends StatelessWidget {
  final Map<String, dynamic> workerDetails;

  const CallingScreen({super.key, required this.workerDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('In-Call Interface'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(workerDetails['profilePic']),
              radius: 50,
            ),
            const SizedBox(height: 16.0),
            Text(
              workerDetails['name'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Calling...',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    // End the call and go back
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.call_end, color: Colors.red),
                  iconSize: 50,
                ),
                const SizedBox(width: 32.0),
                IconButton(
                  onPressed: () {
                    // Optional: Add features like mute
                  },
                  icon: const Icon(Icons.mic_off, color: Colors.grey),
                  iconSize: 50,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
