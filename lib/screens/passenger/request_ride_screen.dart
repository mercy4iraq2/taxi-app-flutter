import 'package:flutter/material.dart';
import '../../services/pricing_service.dart';
import '../../services/location_service.dart';
import '../../models/trip_model.dart';
import '../../utils/currency_formatter.dart';
import '../../utils/formatters.dart';
import '../../config/app_theme.dart';

class RequestRideScreen extends StatefulWidget {
  const RequestRideScreen({Key? key}) : super(key: key);

  @override
  State<RequestRideScreen> createState() => _RequestRideScreenState();
}

class _RequestRideScreenState extends State<RequestRideScreen> {
  late TextEditingController _pickupController;
  late TextEditingController _dropoffController;
  final pricingService = PricingService();
  final locationService = LocationService();

  double? _pickupLat, _pickupLng;
  double? _dropoffLat, _dropoffLng;
  String? _estimatedTripType;
  Map<String, dynamic>? _fareDetails;
  bool _isCalculating = false;

  @override
  void initState() {
    super.initState();
    _pickupController = TextEditingController();
    _dropoffController = TextEditingController();
  }

  @override
  void dispose() {
    _pickupController.dispose();
    _dropoffController.dispose();
    super.dispose();
  }

  /// حساب تكاليف الرحلة
  Future<void> _calculateFare() async {
    if (_pickupLat == null || _pickupLng == null || _dropoffLat == null || _dropoffLng == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both locations')),
      );
      return;
    }

    setState(() => _isCalculating = true);

    try {
      // في التطبيق الحقيقي، ستحصل على المسافة والمدة من Google Maps API
      // هنا نستخدم قيم وهمية
      final distance = 8.5; // كم
      final duration = 22.0; // دقيقة

      // حساب التفاصيل الكاملة للتكلفة
      final fareDetails = pricingService.calculateDetailedFare(
        distance,
        duration,
        _pickupLat!,
        _pickupLng!,
        _dropoffLat!,
        _dropoffLng!,
      );

      setState(() {
        _fareDetails = fareDetails;
        _estimatedTripType = fareDetails['tripType'];
        _isCalculating = false;
      });
    } catch (e) {
      setState(() => _isCalculating = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error calculating fare: $e')),
        );
      }
    }
  }

  /// اختيار موقع من الخريطة
  Future<void> _selectLocation(bool isPickup) async {
    // في التطبيق الحقيقي، سيتم فتح خريطة Google Maps
    // هنا نستخدم بيانات وهمية
    if (isPickup) {
      setState(() {
        _pickupController.text = 'مركز بغداد / Baghdad Center';
        _pickupLat = 33.3128;
        _pickupLng = 44.3615;
      });
    } else {
      setState(() {
        _dropoffController.text = 'المنطقة الخضراء / Green Zone';
        _dropoffLat = 33.3156;
        _dropoffLng = 44.3648;
      });
    }

    // حساب التكاليف تلقائياً عند اختيار الموقعين
    if (_pickupLat != null && _dropoffLat != null) {
      await _calculateFare();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request a Ride'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 📍 نقطة الانطلاق
            const Text(
              'Pickup Location',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => _selectLocation(true),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.dividerColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: AppTheme.primaryColor,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _pickupController.text.isEmpty
                            ? 'Select pickup location'
                            : _pickupController.text,
                        style: TextStyle(
                          color: _pickupController.text.isEmpty
                              ? AppTheme.subTextColor
                              : AppTheme.textColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // 📍 نقطة الوصول
            const Text(
              'Dropoff Location',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => _selectLocation(false),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.dividerColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: AppTheme.secondaryColor,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _dropoffController.text.isEmpty
                            ? 'Select dropoff location'
                            : _dropoffController.text,
                        style: TextStyle(
                          color: _dropoffController.text.isEmpty
                              ? AppTheme.subTextColor
                              : AppTheme.textColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // 💰 تفاصيل التسعير
            if (_fareDetails != null) ...[_buildFareDetailsCard()] else const SizedBox.shrink(),
            const SizedBox(height: 24),
            // 🚗 زر طلب الرحلة
            ElevatedButton(
              onPressed: _isCalculating
                  ? null
                  : _fareDetails == null
                      ? null
                      : () => _requestRide(),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: AppTheme.secondaryColor,
              ),
              child: _isCalculating
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    )
                  : Text(
                      'Request Ride - ${CurrencyFormatter.formatCurrency(_fareDetails?['finalFare'] ?? 0)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  /// بناء بطاقة تفاصيل التسعير
  Widget _buildFareDetailsCard() {
    final details = _fareDetails!;
    final tripType = details['tripType'] as String;
    final description = details['tripTypeDescription'] as String;
    final baseFare = details['baseFare'] as double;
    final finalFare = details['finalFare'] as double;
    final surgeApplied = details['surgeApplied'] as bool;
    final isPeak = details['isPeakHour'] as bool;

    Color tripTypeColor = AppTheme.primaryColor;
    IconData tripTypeIcon = Icons.location_on;

    if (tripType == 'inside') {
      tripTypeColor = Colors.green;
      tripTypeIcon = Icons.apartment;
    } else if (tripType == 'suburb') {
      tripTypeColor = Colors.orange;
      tripTypeIcon = Icons.suburban_mileage;
    } else {
      tripTypeColor = Colors.red;
      tripTypeIcon = Icons.directions_car;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // نوع الرحلة
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: tripTypeColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(tripTypeIcon, color: tripTypeColor, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    description,
                    style: TextStyle(
                      color: tripTypeColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // تفاصيل الرحلة
            _buildFareRow(
              'Distance',
              '${details['distanceKm']} km',
            ),
            const Divider(height: 16),
            _buildFareRow(
              'Duration',
              '${details['durationMinutes'].toStringAsFixed(0)} min',
            ),
            const Divider(height: 16),
            _buildFareRow(
              'Base Fare',
              CurrencyFormatter.formatCurrency(baseFare),
            ),
            if (surgeApplied) ...[const Divider(height: 16), _buildFareRow('Surge Multiplier', '${details['surgeMultiplier']}x')],
            const Divider(height: 16),
            // الأجرة النهائية
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Estimated Fare',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  CurrencyFormatter.formatCurrency(finalFare),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
            // تحذيرات
            if (isPeak)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info, color: Colors.orange, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: const Text(
                          'Peak hour pricing applied',
                          style: TextStyle(color: Colors.orange, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// بناء صف في تفاصيل السعر
  Widget _buildFareRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: AppTheme.subTextColor),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  /// طلب الرحلة
  void _requestRide() {
    if (_fareDetails == null) return;

    final trip = Trip(
      id: 'trip_${DateTime.now().millisecondsSinceEpoch}',
      passengerId: 'passenger_123', // يتم الحصول عليه من حساب المستخدم
      pickupAddress: _pickupController.text,
      dropoffAddress: _dropoffController.text,
      pickupLatitude: _pickupLat!,
      pickupLongitude: _pickupLng!,
      dropoffLatitude: _dropoffLat!,
      dropoffLongitude: _dropoffLng!,
      estimatedDistance: _fareDetails!['distanceKm'],
      estimatedDuration: _fareDetails!['durationMinutes'],
      estimatedFare: _fareDetails!['finalFare'],
      status: 'requested',
      requestedAt: DateTime.now(),
    );

    // حفظ نوع الرحلة في البيانات الإضافية
    final tripType = _fareDetails!['tripType'];

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Ride requested! Type: ${pricingService.getTripTypeDescription(tripType)}',
        ),
        backgroundColor: Colors.green,
      ),
    );

    // إرسال الطلب إلى الخادم
    // await apiService.post('/trips', data: trip.toJson());

    // الانتقال إلى شاشة البحث عن سائق
    Navigator.pop(context, trip);
  }
}
