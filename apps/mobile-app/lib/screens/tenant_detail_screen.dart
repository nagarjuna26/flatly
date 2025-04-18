import 'package:flutter/material.dart';

class TenantDetailScreen extends StatefulWidget {
  final Map<String, String> tenant;

  const TenantDetailScreen({super.key, required this.tenant});

  @override
  State<TenantDetailScreen> createState() => _TenantDetailScreenState();
}

class _TenantDetailScreenState extends State<TenantDetailScreen> {
  late TextEditingController _rentController;

  @override
  void initState() {
    super.initState();
    _rentController = TextEditingController(text: widget.tenant['rent']);
  }

  @override
  void dispose() {
    _rentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.tenant['name']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'House Number: ${widget.tenant['house']}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),

            Text(
              'Monthly Rent:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextFormField(
              controller: _rentController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter new rent',
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                // Save rent logic (currently placeholder)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Updated rent for ${widget.tenant['name']} to ₹${_rentController.text}',
                    ),
                  ),
                );

                // You can also update the map locally:
                setState(() {
                  widget.tenant['rent'] = _rentController.text;
                });

                // Later: persist to backend
              },
              icon: const Icon(Icons.save),
              label: const Text('Save Changes'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () {
                // Vacate notice logic (placeholder)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Vacate notice sent to ${widget.tenant['name']}',
                    ),
                  ),
                );

                // Later: add remove or update status in backend
              },
              icon: const Icon(Icons.warning),
              label: const Text('Send Vacate Notice'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}