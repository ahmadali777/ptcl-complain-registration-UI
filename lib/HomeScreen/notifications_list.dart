import 'package:flutter/material.dart';

// Simulated global list of notifications
final List<Map<String, String>> notifications = [
  {'title': 'Complaint Update', 'body': 'Your complaint has been registered.'},
  {'title': 'Resolved', 'body': 'Your complaint has been resolved.'},
  {'title': 'Follow-up', 'body': 'A service agent is on the way.'},
];

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Text('No notifications yet.'),
            )
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Dismissible(
                  key: UniqueKey(), // Unique key for each item
                  direction: DismissDirection.endToStart, // Swipe from right to left
                  onDismissed: (direction) {
                    setState(() {
                      notifications.removeAt(index); // Remove the notification
                    });

                    // Optionally show a snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${notification['title']} dismissed'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20.0),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  child: Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(notification['title'] ?? 'No Title'),
                      subtitle: Text(notification['body'] ?? 'No Body'),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
