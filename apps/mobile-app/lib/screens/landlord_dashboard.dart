import 'package:flutter/material.dart';
import 'tenants_list_screen.dart';

class LandlordDashboard extends StatelessWidget {
  const LandlordDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Landlord Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Overview',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.people),
                title: const Text('Total Tenants'),
                trailing: const Text('14'),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.monetization_on),
                title: const Text('Monthly Rent Collected'),
                trailing: const Text('₹1,40,000'),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.water_drop),
                title: const Text('Pending Water Bills'),
                trailing: const Text('₹2,300'),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Actions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TenantsListScreen()),
                );
              },
              child: const Text('View Tenants'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                // Add building or send notice (future)
              },
              child: const Text('Send Vacate Notice'),
            ),
          ],
        ),
      ),
    );
  }
}