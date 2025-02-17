import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ptcl_app/HomeScreen/notifications.dart';

class ComplainSolved extends StatefulWidget {
  const ComplainSolved({super.key});

  @override
  State<ComplainSolved> createState() => _ComplainSolvedState();
}

class _ComplainSolvedState extends State<ComplainSolved> {
  double rating = 0.0;
  final TextEditingController feedbackController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Trigger notification when the widget is shown
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showNotification(
        id: 4,
        title: 'Complaint Solved',
        body: 'Your complaint has been resolved. Please provide feedback.',
      );
    });
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
                'Complain Solved',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              const Text('Please provide your feedback:'),
              const SizedBox(height: 8.0),
              TextField(
                controller: feedbackController,
                decoration: const InputDecoration(
                  labelText: 'Enter feedback',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16.0),
              const Text('Rate the service:'),
              const SizedBox(height: 8.0),
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (value) {
                  setState(() {
                    rating = value;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Process feedback and rating
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Feedback Submitted!\nRating: $rating\nFeedback: ${feedbackController.text}',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('Submit Feedback'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
