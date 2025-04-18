import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddTenantScreen extends StatefulWidget {
  const AddTenantScreen({super.key});

  @override
  State<AddTenantScreen> createState() => _AddTenantScreenState();
}

class _AddTenantScreenState extends State<AddTenantScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _houseController = TextEditingController();
  final _rentController = TextEditingController();

  String? _selectedBuilding;
  List<String> buildingList = [];

  @override
  void initState() {
    super.initState();

    // Load any arguments passed when editing
    Future.delayed(Duration.zero, () {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args != null && args is Map<String, dynamic>) {
        _nameController.text = args['name'] ?? '';
        _houseController.text = args['house'] ?? '';
        _rentController.text = args['rent'] ?? '';
        _selectedBuilding = args['building'];
      }
    });

    _loadBuildings();
  }

  // Simulate fetching buildings assigned to the currently logged-in landlord
  void _loadBuildings() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('buildings')
        .where('landlordId', isEqualTo: user.uid)
        .get();

    setState(() {
      buildingList = snapshot.docs.map((doc) => doc['name'] as String).toList();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _houseController.dispose();
    _rentController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newTenant = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(), // unique ID
        'name': _nameController.text,
        'house': _houseController.text,
        'rent': _rentController.text,
        'building': _selectedBuilding!,
      };

      Navigator.of(context).pop(newTenant);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Tenant')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Tenant Name'),
                validator: (value) => value!.isEmpty ? 'Enter name' : null,
              ),
              TextFormField(
                controller: _houseController,
                decoration: const InputDecoration(labelText: 'House Number'),
                validator: (value) => value!.isEmpty ? 'Enter house number' : null,
              ),
              TextFormField(
                controller: _rentController,
                decoration: const InputDecoration(labelText: 'Monthly Rent'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter rent' : null,
              ),
              DropdownButtonFormField<String>(
                value: _selectedBuilding,
                items: buildingList
                    .map((building) => DropdownMenuItem(
                          value: building,
                          child: Text(building),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedBuilding = value;
                  });
                },
                decoration: const InputDecoration(labelText: 'Select Building'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Select a building' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.add),
                label: const Text('Add Tenant'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
