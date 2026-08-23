import 'package:flutter/material.dart';
import '../../config/app_theme.dart';

class AdminReportsScreen extends StatefulWidget {
  const AdminReportsScreen({Key? key}) : super(key: key);

  @override
  State<AdminReportsScreen> createState() => _AdminReportsScreenState();
}

class _AdminReportsScreenState extends State<AdminReportsScreen> {
  String _selectedPeriod = 'today'; // today, week, month

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports & Analytics'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Period Filter
            Row(
              children: [
                _buildPeriodButton('Today', 'today'),
                const SizedBox(width: 8),
                _buildPeriodButton('This Week', 'week'),
                const SizedBox(width: 8),
                _buildPeriodButton('This Month', 'month'),
              ],
            ),
            const SizedBox(height: 24),
            // Summary Cards
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Revenue Summary',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    _buildSummaryRow('Total Revenue', '\$12,500'),
                    const Divider(height: 16),
                    _buildSummaryRow('Total Trips', '1,245'),
                    const Divider(height: 16),
                    _buildSummaryRow('Average Trip Fare', '\$10.05'),
                    const Divider(height: 16),
                    _buildSummaryRow('Active Users', '1,850'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Driver Stats
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Driver Statistics',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    _buildSummaryRow('Active Drivers', '248'),
                    const Divider(height: 16),
                    _buildSummaryRow('Total Driver Earnings', '\$8,500'),
                    const Divider(height: 16),
                    _buildSummaryRow('Avg Driver Rating', '4.7 / 5.0'),
                    const Divider(height: 16),
                    _buildSummaryRow('New Drivers', '15'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // User Stats
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Passenger Statistics',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    _buildSummaryRow('Total Passengers', '1,524'),
                    const Divider(height: 16),
                    _buildSummaryRow('Total Spent', '\$12,500'),
                    const Divider(height: 16),
                    _buildSummaryRow('Avg Passenger Rating', '4.5 / 5.0'),
                    const Divider(height: 16),
                    _buildSummaryRow('Repeat Users', '678'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodButton(String label, String value) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() => _selectedPeriod = value);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _selectedPeriod == value
              ? AppTheme.primaryColor
              : Colors.grey[200],
          foregroundColor: _selectedPeriod == value ? Colors.white : Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 10),
        ),
        child: Text(label),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: AppTheme.subTextColor),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
