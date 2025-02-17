import 'package:flutter/material.dart';
import 'package:ptcl_app/HomeScreen/cus_data_card.dart';
import 'package:ptcl_app/HomeScreen/live_chart.dart';
import 'package:ptcl_app/HomeScreen/notifications_list.dart';
import 'package:ptcl_app/HomeScreen/pr_carousal.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Image.asset(
          'assets/ptcl_logo.png',
          width: 120,
        ),
        centerTitle: true,
        elevation: 2,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationList()),
              );
            },
            icon: const Icon(Icons.notifications)),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.logout))],
      ),
      body: const SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              PrCarousal(),
              SizedBox(
                height: 5,
              ),
              CustomerCard(
                  customerName: "ptcl user",
                  customerNumber: "123456789",
                  broadbandRouterId: "021:123:21",
                  billPaymentStatus: true),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatScreen()),
          );
        },
        tooltip: 'Live Chat',
        child: const Icon(Icons.chat),
      ),
    );
  }
}
