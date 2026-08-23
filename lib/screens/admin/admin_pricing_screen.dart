import 'package:flutter/material.dart';
import '../../config/app_theme.dart';

class AdminPricingScreen extends StatefulWidget {
  const AdminPricingScreen({Key? key}) : super(key: key);

  @override
  State<AdminPricingScreen> createState() => _AdminPricingScreenState();
}

class _AdminPricingScreenState extends State<AdminPricingScreen> {
  late TextEditingController _baseFareController;
  late TextEditingController _perKmController;
  late TextEditingController _perMinController;
  bool _isEditing = false;
  bool _enableSurgePrice = false;

  @override
  void initState() {
    super.initState();
    _baseFareController = TextEditingController(text: '2.00');
    _perKmController = TextEditingController(text: '1.50');
    _perMinController = TextEditingController(text: '0.30');
  }

  @override
  void dispose() {
    _baseFareController.dispose();
    _perKmController.dispose();
    _perMinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pricing Management'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.close : Icons.edit),
            onPressed: () {
              setState(() => _isEditing = !_isEditing);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Base Fare
            const Text(
              'Base Fare (Opening Charge)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _baseFareController,
              enabled: _isEditing,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixText: '\$ ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
            const SizedBox(height: 24),
            // Per Kilometer
            const Text(
              'Per Kilometer Rate',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _perKmController,
              enabled: _isEditing,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixText: '\$ ',
                suffixText: 'per km',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
            const SizedBox(height: 24),
            // Per Minute
            const Text(
              'Per Minute Rate (Waiting Time)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _perMinController,
              enabled: _isEditing,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixText: '\$ ',
                suffixText: 'per min',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
            const SizedBox(height: 24),
            // Surge Pricing
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Enable Surge Pricing',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Switch(
                          value: _enableSurgePrice,
                          onChanged: _isEditing
                              ? (value) {
                                  setState(() => _enableSurgePrice = value);
                                }
                              : null,
                        ),
                      ],
                    ),
                    if (_enableSurgePrice) ...[const SizedBox(height: 16), const Text('Peak Hours Multiplier: 1.5x')],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Save Button
            if (_isEditing)
              ElevatedButton(
                onPressed: () {
                  setState(() => _isEditing = false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Pricing updated successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('Save Changes'),
              ),
          ],
        ),
      ),
    );
  }
}
