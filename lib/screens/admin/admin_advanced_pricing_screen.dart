import 'package:flutter/material.dart';
import '../../services/advanced_pricing_service.dart';
import '../../models/pricing_pattern_model.dart';
import '../../utils/currency_formatter.dart';
import '../../config/app_theme.dart';
import '../../utils/logger.dart';

class AdminAdvancedPricingScreen extends StatefulWidget {
  const AdminAdvancedPricingScreen({Key? key}) : super(key: key);

  @override
  State<AdminAdvancedPricingScreen> createState() =>
      _AdminAdvancedPricingScreenState();
}

class _AdminAdvancedPricingScreenState extends State<AdminAdvancedPricingScreen> {
  final pricingService = AdvancedPricingService();
  final patterns = PricingPattern.getAllPatterns();
  late String _selectedGovernorate;

  @override
  void initState() {
    super.initState();
    final governorates = pricingService.getGovernorates();
    _selectedGovernorate = governorates.isNotEmpty ? governorates[0].id : '';
  }

  @override
  Widget build(BuildContext context) {
    final governorates = pricingService.getGovernorates();
    final selectedGov = governorates.firstWhere(
      (g) => g.id == _selectedGovernorate,
      orElse: () => governorates[0],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('نظام التسعير المتقدم - Advanced Pricing'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // اختيار المحافظة
            const Text(
              'اختر المحافظة - Select Governorate',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            DropdownButton<String>(
              value: _selectedGovernorate,
              isExpanded: true,
              items: governorates.map((gov) {
                return DropdownMenuItem(
                  value: gov.id,
                  child: Text('${gov.nameAr} (${gov.name})'),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedGovernorate = value);
                }
              },
            ),
            const SizedBox(height: 24),
            // اختيار نمط التسعير
            _buildPricingPatternSelector(selectedGov),
            const SizedBox(height: 24),
            // أسعار الفئة الاقتصادية
            _buildTierPricingCard(selectedGov, 'economy'),
            const SizedBox(height: 16),
            // أسعار الفئة سوبر
            _buildTierPricingCard(selectedGov, 'super'),
            const SizedBox(height: 24),
            // معاينة
            _buildPreview(selectedGov),
          ],
        ),
      ),
    );
  }

  /// بناء عنصر اختيار نمط التسعير
  Widget _buildPricingPatternSelector(selectedGov) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'نمط التسعير - Pricing Pattern',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'النمط الحالي: ${selectedGov.selectedPricingPattern}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                ...patterns.map((pattern) {
                  final isSelected =
                      selectedGov.selectedPricingPattern == pattern.patternId;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                      onTap: () {
                        pricingService.updatePricingPattern(
                          selectedGov.id,
                          pattern.patternId,
                        );
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected
                                ? AppTheme.primaryColor
                                : AppTheme.dividerColor,
                            width: isSelected ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          backgroundColor: isSelected
                              ? AppTheme.primaryColor.withOpacity(0.1)
                              : Colors.transparent,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected
                                          ? AppTheme.primaryColor
                                          : AppTheme.dividerColor,
                                    ),
                                    color: isSelected
                                        ? AppTheme.primaryColor
                                        : Colors.transparent,
                                  ),
                                  child: isSelected
                                      ? const Icon(
                                          Icons.check,
                                          size: 16,
                                          color: Colors.white,
                                        )
                                      : null,
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'النمط ${pattern.patternId}: ${pattern.descriptionAr}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      pattern.formulaAr,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: AppTheme.subTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// بناء بطاقة أسعار الفئة
  Widget _buildTierPricingCard(selectedGov, String tierType) {
    final tier = tierType == 'economy'
        ? selectedGov.economyTiers.economy
        : selectedGov.economyTiers.super_;
    final tierNameAr = tierType == 'economy' ? 'اقتصادية' : 'سوبر';

    final baseFareController = TextEditingController(
      text: tier.baseFare.toStringAsFixed(0),
    );
    final perMinController = TextEditingController(
      text: tier.perMinuteRate.toStringAsFixed(0),
    );
    final perKmController = TextEditingController(
      text: tier.perKmRate.toStringAsFixed(0),
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'أسعار الفئة $tierNameAr - $tierType Prices',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // اجرة الانطلاق
            Text(
              'اجرة الانطلاق - Base Fare (د.ع)',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: baseFareController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
            const SizedBox(height: 16),
            // سعر الدقيقة
            Text(
              'سعر الدقيقة - Per Minute (د.ع/دقيقة)',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: perMinController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
            const SizedBox(height: 16),
            // سعر الكيلومتر
            Text(
              'سعر الكيلومتر - Per KM (د.ع/كم)',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: perKmController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
            const SizedBox(height: 16),
            // زر الحفظ
            ElevatedButton(
              onPressed: () {
                final baseFare = double.tryParse(baseFareController.text) ?? 0;
                final perMin = double.tryParse(perMinController.text) ?? 0;
                final perKm = double.tryParse(perKmController.text) ?? 0;

                if (tierType == 'economy') {
                  pricingService.updateEconomyTierPrices(
                    selectedGov.id,
                    baseFare,
                    perMin,
                    perKm,
                  );
                } else {
                  pricingService.updateSuperTierPrices(
                    selectedGov.id,
                    baseFare,
                    perMin,
                    perKm,
                  );
                }

                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('تم حفظ أسعار $tierNameAr بنجاح'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text('حفظ أسعار $tierNameAr - Save $tierType'),
            ),
          ],
        ),
      ),
    );
  }

  /// بناء معاينة الحساب
  Widget _buildPreview(selectedGov) {
    // قيم تجريبية
    const double testDistance = 8.5;
    const double testDuration = 22.0;
    const double testPickupLat = 33.3128;
    const double testPickupLng = 44.3615;
    const double testDropoffLat = 33.3456;
    const double testDropoffLng = 44.3890;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'معاينة الحساب - Fare Preview',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        // معاينة الفئة الاقتصادية
        _buildFarePreviewCard(
          'اقتصادية - Economy',
          selectedGov,
          'economy',
          testDistance,
          testDuration,
          testPickupLat,
          testPickupLng,
          testDropoffLat,
          testDropoffLng,
        ),
        const SizedBox(height: 12),
        // معاينة الفئة سوبر
        _buildFarePreviewCard(
          'سوبر - Super',
          selectedGov,
          'super',
          testDistance,
          testDuration,
          testPickupLat,
          testPickupLng,
          testDropoffLat,
          testDropoffLng,
        ),
      ],
    );
  }

  /// بناء بطاقة معاينة الأجرة
  Widget _buildFarePreviewCard(
    String tierName,
    selectedGov,
    String carType,
    double distance,
    double duration,
    double pickupLat,
    double pickupLng,
    double dropoffLat,
    double dropoffLng,
  ) {
    final result = pricingService.calculateDetailedFare(
      pickupLat,
      pickupLng,
      dropoffLat,
      dropoffLng,
      distance,
      duration,
      carType,
    );

    if (!result['success']) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('خطأ في الحساب'),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tierName,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _previewRow('المحافظة:', result['governorate']),
            _previewRow('نمط التسعير:', result['pricingPatternName']),
            _previewRow('المسافة:', '${result['distanceKm']} كم'),
            _previewRow('المدة:', '${result['durationMinutes'].toStringAsFixed(0)} دقيقة'),
            const Divider(height: 16),
            _previewRow('اجرة الانطلاق:', '${result['baseFare'].toStringAsFixed(0)} د.ع'),
            _previewRow('سعر/دقيقة:', '${result['perMinuteRate'].toStringAsFixed(0)} د.ع'),
            _previewRow('سعر/كم:', '${result['perKmRate'].toStringAsFixed(0)} د.ع'),
            if (result['isPeakHour'])
              _previewRow('معامل الذروة:', '×${result['peakHourMultiplier']}'),
            const Divider(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'الأجرة النهائية:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '${result['finalFare'].toStringAsFixed(0)} د.ع',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'مقربة لأقرب 250 دينار',
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.subTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// بناء صف المعاينة
  Widget _previewRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.subTextColor,
            ),
          ),
          Text(
            '$value',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
