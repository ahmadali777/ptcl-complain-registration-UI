import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _userInput = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  static const apiKey = "AIzaSyD-nTNXulcU6nORnRMMFZODZkhrW87qJVw";
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

  final List<Message> _messages = [
    Message(
      isUser: false,
      message: message1,
      date: DateTime.now(),
    ),
  ];

 Future<void> sendMessage() async {
  final message = _userInput.text;

  // If the message is empty, just return
  if (message.isEmpty && _messages.isEmpty) {
    setState(() {
      _messages.add(Message(isUser: false, message: initialPrompt, date: DateTime.now()));
    });

    try {
      final content = [Content.text(initialPrompt)];
      await model.generateContent(content); // Don't use the response here
    } catch (e) {
      setState(() {
        _messages.add(Message(
            isUser: false, message: "Failed to connect. Try again.", date: DateTime.now()));
      });
    }
    return;
  }

  if (message.isNotEmpty) {
    setState(() {
      _messages.add(Message(isUser: true, message: message, date: DateTime.now()));
      _userInput.clear();
    });
    try {
      final content = [Content.text(message)];
      final response = await model.generateContent(content);
      setState(() {
        _messages.add(Message(
            isUser: false, message: response.text ?? "No response", date: DateTime.now()));
      });
      // Scroll to the latest message
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration:const Duration(milliseconds: 30),
        curve: Curves.easeOut,
      );
      // Process the response to extract complaint data (description and category)
      _processComplainData(response.text ?? "");

    } catch (e) {
      setState(() {
        _messages.add(Message(
            isUser: false, message: "Failed to connect. Try again.", date: DateTime.now()));
      });
    }
  }
}

void _processComplainData(String responseText) {
  final RegExp regExp =
      RegExp(r'Complain description: (.+)\nCategory: (.+)', multiLine: true);

  final match = regExp.firstMatch(responseText);
  if (match != null) {
    final complainDescription = match.group(1)?.trim();
    final category = match.group(2)?.trim();

    // Ensure the context is valid before showing the dialog
    if (context != null) {
      // Show dialog box with complain description and category
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Complaint Details'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Complaint Description: $complainDescription'),
                  SizedBox(height: 10),
                  Text('Category: $category'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    } else {
      // Debugging log in case context is null
      print("Context is not available. Cannot show dialog.");
    }
  }
}

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Chat'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return Messages(
                    isUser: message.isUser,
                    message: message.message,
                    date: DateFormat('HH:mm').format(message.date),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 15,
                    child: TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: _userInput,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        label: const Text('Enter Your Message'),
                      ),
                    ),
                  ),
                  IconButton(
                    padding: const EdgeInsets.all(12),
                    iconSize: 30,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(const CircleBorder()),
                    ),
                    onPressed: sendMessage,
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Message {
  final bool isUser;
  final String message;
  final DateTime date;

  Message({required this.isUser, required this.message, required this.date});
}

class Messages extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;

  const Messages({
    super.key,
    required this.isUser,
    required this.message,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 15)
          .copyWith(left: isUser ? 100 : 10, right: isUser ? 10 : 100),
      decoration: BoxDecoration(
        color: isUser ? Colors.blueAccent : Colors.grey.shade400,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(10),
          bottomLeft: isUser ? const Radius.circular(10) : Radius.zero,
          topRight: const Radius.circular(10),
          bottomRight: isUser ? Radius.zero : const Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: isUser ? Colors.white : Colors.black,
            ),
          ),
          Text(
            date,
            style: TextStyle(
              fontSize: 10,
              color: isUser ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

const String message1 = """Hello, welcome to PTCL customer support! How can I assist you today?

Please provide me with a brief description of your issue, and I’ll help you register your complaint. If you’re not sure about the problem, don’t worry—I can help guide you through it!

Here are some categories to help me understand your issue better:
1. Landline issues (e.g., no dial tone, static on the line)
2. Internet problems (e.g., slow speeds, disconnection)
3. PTCL Smart TV issues (e.g., no signal, buffering)
4. Evo 4G or PTCL Fiber service (e.g., network issues)
5. Others (Please describe your issue)

Once I have your complaint details, I’ll process it for you. If there’s anything I can do to assist further, I’ll be happy to help!
""";

const String initialPrompt = """You are a customer service representative for PTCL (Pakistan Telecommunication Company Limited), providing assistance for common complaints related to PTCL services. You are responsible for assisting customers in a friendly and professional manner by gathering information about their issues, categorizing the complaint, and ensuring that proper resolution steps are followed.

Your job is to:
1. Greet customers warmly and gather details about their complaint.
2. Ask relevant questions to clarify the nature of the problem.
3. Provide helpful information and guidance for troubleshooting common PTCL issues.
4. Offer apologies for any inconvenience caused and reassure customers that their issue will be resolved promptly.
5. Ensure customers feel heard and their complaints are registered in the PTCL complaint system.

Some common issues you can handle:
- Landline issues (e.g., no dial tone, static on the line).
- Internet-related problems (e.g., slow speeds, disconnections).
- PTCL Smart TV issues (e.g., no signal, buffering).
- Evo 4G or PTCL Fiber-related issues.
""";
