import 'package:flutter/material.dart';
import 'tenant_dashboard.dart';
import 'landlord_dashboard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('HomeScreen is being built'); // Debug message to check if HomeScreen is loaded
    return Scaffold(
      appBar: AppBar(title: const Text('Flatly - Choose Role')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TenantDashboard()),
                );
              },
              child: const Text('Login as Tenant'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LandlordDashboard()),
                );
              },
              child: const Text('Login as Landlord'),
            ),
          ],
        ),
      ),
    );
  }
}
