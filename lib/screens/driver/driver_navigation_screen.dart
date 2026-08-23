import 'package:flutter/material.dart';
import '../../config/app_theme.dart';

class DriverNavigationScreen extends StatefulWidget {
  final double pickupLat;
  final double pickupLng;
  final double destinationLat;
  final double destinationLng;

  const DriverNavigationScreen({
    Key? key,
    required this.pickupLat,
    required this.pickupLng,
    required this.destinationLat,
    required this.destinationLng,
  }) : super(key: key);

  @override
  State<DriverNavigationScreen> createState() => _DriverNavigationScreenState();
}

class _DriverNavigationScreenState extends State<DriverNavigationScreen> {
  bool _tripStarted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Map Placeholder
          Expanded(
            child: Container(
              color: Colors.grey[300],
              child: const Center(
                child: Icon(
                  Icons.location_on,
                  size: 48,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          // Navigation Info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Distance and Time
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text('Distance', style: TextStyle(fontSize: 12, color: AppTheme.subTextColor)),
                            const SizedBox(height: 4),
                            const Text('5.2 km', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: AppTheme.dividerColor,
                        ),
                        Column(
                          children: [
                            const Text('Time', style: TextStyle(fontSize: 12, color: AppTheme.subTextColor)),
                            const SizedBox(height: 4),
                            const Text('12 min', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Action Button
                ElevatedButton(
                  onPressed: () {
                    setState(() => _tripStarted = !_tripStarted);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: _tripStarted ? Colors.red : Colors.green,
                  ),
                  child: Text(
                    _tripStarted ? 'End Trip' : 'Start Trip',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
