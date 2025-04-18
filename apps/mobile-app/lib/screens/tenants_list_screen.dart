import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TenantsListScreen extends StatefulWidget {
  const TenantsListScreen({super.key});

  @override
  State<TenantsListScreen> createState() => _TenantsListScreenState();
}

class _TenantsListScreenState extends State<TenantsListScreen> {
  List<Map<String, dynamic>> tenantsList = [];

  @override
  void initState() {
    super.initState();
    _loadTenants();
  }

  Future<void> _loadTenants() async {
    final snapshot = await FirebaseFirestore.instance.collection('tenants').get();

    setState(() {
      tenantsList = snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'name': doc['name'],
          'house': doc['house'],
          'rent': doc['rent'],
          'building': doc['building'],
        };
      }).toList();
    });
  }

  Map<String, List<Map<String, dynamic>>> _groupTenantsByBuilding() {
    final Map<String, List<Map<String, dynamic>>> groupedTenants = {};

    for (int i = 0; i < tenantsList.length; i++) {
      final tenant = Map<String, dynamic>.from(tenantsList[i]);
      tenant['__index'] = i;
      final building = tenant['building'] ?? 'Unknown';
      groupedTenants.putIfAbsent(building, () => []).add(tenant);
    }

    return groupedTenants;
  }

  void _editTenant(Map<String, dynamic> tenant, int index) async {
    final editedTenant = await Navigator.pushNamed(
      context,
      '/add-tenant',
      arguments: tenant,
    );

    if (editedTenant != null && editedTenant is Map<String, dynamic>) {
      final id = tenant['id'];
      await FirebaseFirestore.instance.collection('tenants').doc(id).update(editedTenant);

      setState(() {
        tenantsList[index] = {
          ...editedTenant,
          'id': id,
        };
      });
    }
  }

  void _deleteTenant(int index) {
    final id = tenantsList[index]['id'];
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this tenant?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseFirestore.instance.collection('tenants').doc(id).delete();
              setState(() {
                tenantsList.removeAt(index);
              });
              Navigator.pop(ctx);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _navigateToAddTenant() async {
    final result = await Navigator.pushNamed(context, '/add-tenant');

    if (result != null && result is Map<String, dynamic>) {
      final doc = await FirebaseFirestore.instance.collection('tenants').add(result);
      setState(() {
        tenantsList.add({...result, 'id': doc.id});
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tenant added successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final groupedTenants = _groupTenantsByBuilding();

    return Scaffold(
      appBar: AppBar(title: const Text('Tenants List')),
      body: groupedTenants.isEmpty
          ? const Center(child: Text('No tenants added yet'))
          : ListView(
              children: groupedTenants.entries.map((entry) {
                return ExpansionTile(
                  title: Text(entry.key),
                  children: entry.value.map((tenant) {
                    final index = tenantsList.indexWhere((t) => t['id'] == tenant['id']);
                    return ListTile(
                      title: Text(tenant['name']),
                      subtitle: Text('House: ${tenant['house']} | Rent: ₹${tenant['rent']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _editTenant(tenant, index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteTenant(index),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddTenant,
        child: const Icon(Icons.add),
      ),
    );
  }
}
