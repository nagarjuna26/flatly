import 'package:flutter/material.dart';

class TenantDashboard extends StatelessWidget {
  const TenantDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tenant Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome, John!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Card(
              child: ListTile(
                leading: const Icon(Icons.home),
                title: const Text('House No: 203'),
                subtitle: const Text('Rent Due: ₹10,000'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: const Icon(Icons.receipt_long),
                title: const Text('Water Bill'),
                subtitle: const Text('Pending: ₹500'),
                trailing: TextButton(onPressed: () {}, child: const Text("Pay")),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: const Icon(Icons.support_agent),
                title: const Text('Need Help?'),
                subtitle: const Text('Call: +91-9876543210'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}