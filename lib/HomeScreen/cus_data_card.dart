import 'package:flutter/material.dart';

class CustomerCard extends StatelessWidget {
  final String customerName;
  final String customerNumber;
  final String broadbandRouterId;
  final bool billPaymentStatus;

  const CustomerCard({
    super.key,
    required this.customerName,
    required this.customerNumber,
    required this.broadbandRouterId,
    required this.billPaymentStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.green.shade100.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon or Avatar
          Container(
            width: 80,
            height: 80,
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green.shade100,
            ),
            child: const Icon(
              Icons.person,
              size: 40,
              color: Colors.green,
            ),
          ),

          // Customer Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Name: $customerName",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    "Number: $customerNumber",
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  Text(
                    "Router ID: $broadbandRouterId",
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  Row(
                    children: [
                      const Text(
                        "Bill Paid: ",
                        style:
                            TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      Text(
                        billPaymentStatus ? "Yes" : "No",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: billPaymentStatus
                              ? Colors.green.shade700
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Icon for Status
          Container(
            margin: const EdgeInsets.all(10),
            child: Icon(
              billPaymentStatus ? Icons.check_circle : Icons.warning_rounded,
              color: billPaymentStatus ? Colors.green : Colors.red,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
