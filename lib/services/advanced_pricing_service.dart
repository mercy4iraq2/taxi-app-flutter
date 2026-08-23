import 'package:geolocator/geolocator.dart' hide Position;
import '../models/governorate_model.dart';
import '../models/pricing_pattern_model.dart';
import '../utils/logger.dart';

/// خدمة التسعير المتقدمة بـ 6 أنماط
class AdvancedPricingService {
  static final AdvancedPricingService _instance = AdvancedPricingService._internal();
  
  final List<Governorate> _governorates = [];
  final List<int> _peakHours = [7, 8, 9, 17, 18, 19, 20];

  factory AdvancedPricingService() {
    return _instance;
  }

  AdvancedPricingService._internal() {
    _initializeGovernorates();
  }

  /// تهيئة بيانات المحافظات
  void _initializeGovernorates() {
    _governorates.addAll([
      Governorate(
        id: 'gov_baghdad',
        name: 'Baghdad',
        nameAr: 'بغداد',
        latitude: 33.3128,
        longitude: 44.3615,
        radius: 15000,
        selectedPricingPattern: '4', // Base + Distance + Time
        economyTiers: GovernorateEconomyTiers(
          economy: EconomyTier(
            name: 'Economy',
            nameAr: 'اقتصادية',
            baseFare: 2500.0, // 2500 دينار
            perMinuteRate: 300.0, // 300 دينار/دقيقة
            perKmRate: 1500.0, // 1500 دينار/كم
            peakHourMultiplier: 1.5,
          ),
          super_: EconomyTier(
            name: 'Super',
            nameAr: 'سوبر',
            baseFare: 4000.0,
            perMinuteRate: 400.0,
            perKmRate: 2000.0,
            peakHourMultiplier: 1.5,
          ),
        ),
      ),
      Governorate(
        id: 'gov_basra',
        name: 'Basra',
        nameAr: 'البصرة',
        latitude: 30.5433,
        longitude: 47.8068,
        radius: 12000,
        selectedPricingPattern: '2', // Base + By Minute
        economyTiers: GovernorateEconomyTiers(
          economy: EconomyTier(
            name: 'Economy',
            nameAr: 'اقتصادية',
            baseFare: 2000.0,
            perMinuteRate: 250.0,
            perKmRate: 1200.0,
          ),
          super_: EconomyTier(
            name: 'Super',
            nameAr: 'سوبر',
            baseFare: 3500.0,
            perMinuteRate: 350.0,
            perKmRate: 1700.0,
          ),
        ),
      ),
      Governorate(
        id: 'gov_erbil',
        name: 'Erbil',
        nameAr: 'أربيل',
        latitude: 36.1910,
        longitude: 44.0091,
        radius: 10000,
        selectedPricingPattern: '1', // By Minute Only
        economyTiers: GovernorateEconomyTiers(
          economy: EconomyTier(
            name: 'Economy',
            nameAr: 'اقتصادية',
            baseFare: 0.0, // بدون اجرة انطلاق
            perMinuteRate: 280.0,
            perKmRate: 1300.0,
          ),
          super_: EconomyTier(
            name: 'Super',
            nameAr: 'سوبر',
            baseFare: 0.0,
            perMinuteRate: 380.0,
            perKmRate: 1800.0,
          ),
        ),
      ),
    ]);
  }

  /// الحصول على المحافظة للموقع المعطى
  Governorate? _getGovernorateForLocation(double latitude, double longitude) {
    for (final gov in _governorates) {
      final distance = Geolocator.distanceBetween(
        gov.latitude,
        gov.longitude,
        latitude,
        longitude,
      );
      if (distance <= gov.radius) {
        return gov;
      }
    }
    return null;
  }

  /// حساب الأجرة النهائية بناءً على النمط المختار
  double calculateFareByPattern(
    String patternId,
    EconomyTier tier,
    double distanceKm,
    double durationMinutes,
    {bool isPeakHour = false}
  ) {
    double fare = 0.0;

    // تطبيق الصيغة حسب النمط
    switch (patternId) {
      case '1':
        // السعر = الدقيقة × سعر الدقيقة
        fare = durationMinutes * tier.perMinuteRate;
        break;

      case '2':
        // السعر = اجرة الانطلاق + (الدقيقة × سعر الدقيقة)
        fare = tier.baseFare + (durationMinutes * tier.perMinuteRate);
        break;

      case '3':
        // السعر = اجرة الانطلاق + (الدقيقة × سعر الدقيقة × معامل الذروة)
        double minuteFare = durationMinutes * tier.perMinuteRate;
        if (isPeakHour) {
          minuteFare *= tier.peakHourMultiplier;
        }
        fare = tier.baseFare + minuteFare;
        break;

      case '4':
        // السعر = اجرة الانطلاق + (المسافة × سعر الكم) + (الدقيقة × سعر الدقيقة)
        fare = tier.baseFare +
            (distanceKm * tier.perKmRate) +
            (durationMinutes * tier.perMinuteRate);
        break;

      case '5':
        // السعر = الدقيقة × سعر الدقيقة (بدون اجرة انطلاق)
        fare = durationMinutes * tier.perMinuteRate;
        break;

      case '6':
        // السعر = (الدقيقة × سعر الدقيقة) + اجرة الانطلاق
        fare = (durationMinutes * tier.perMinuteRate) + tier.baseFare;
        break;

      default:
        fare = 0.0;
    }

    // تقريب الأجرة لأقرب 250
    fare = _roundToNearest250(fare);

    return fare;
  }

  /// تقريب الأجرة لأقرب 250
  double _roundToNearest250(double value) {
    return ((value / 250).ceil() * 250).toDouble();
  }

  /// حساب الأجرة مع تفاصيل كاملة
  Map<String, dynamic> calculateDetailedFare(
    double pickupLat,
    double pickupLng,
    double dropoffLat,
    double dropoffLng,
    double distanceKm,
    double durationMinutes,
    String carType, // 'economy' أو 'super'
  ) {
    // تحديد المحافظة
    final governorate = _getGovernorateForLocation(pickupLat, pickupLng);

    if (governorate == null) {
      return {
        'success': false,
        'message': 'Location not covered by service',
        'messageAr': 'الموقع غير مغطى بالخدمة',
      };
    }

    // الحصول على فئة الاقتصاد المطلوبة
    final tier = carType == 'super'
        ? governorate.economyTiers.super_
        : governorate.economyTiers.economy;

    // التحقق من وقت الذروة
    final isPeak = isPeakHour();

    // حساب الأجرة
    final finalFare = calculateFareByPattern(
      governorate.selectedPricingPattern ?? '4',
      tier,
      distanceKm,
      durationMinutes,
      isPeakHour: isPeak,
    );

    // الحصول على نمط التسعير
    final pattern = PricingPattern.getPatternById(
      governorate.selectedPricingPattern ?? '4',
    );

    return {
      'success': true,
      'governorate': governorate.nameAr,
      'carType': carType == 'super' ? 'سوبر' : 'اقتصادية',
      'pricingPattern': pattern.patternId,
      'pricingPatternName': pattern.descriptionAr,
      'distanceKm': double.parse(distanceKm.toStringAsFixed(2)),
      'durationMinutes': double.parse(durationMinutes.toStringAsFixed(0)),
      'baseFare': tier.baseFare,
      'perMinuteRate': tier.perMinuteRate,
      'perKmRate': tier.perKmRate,
      'isPeakHour': isPeak,
      'peakHourMultiplier': isPeak ? tier.peakHourMultiplier : 1.0,
      'finalFare': finalFare,
      'roundedTo': 250,
    };
  }

  /// التحقق من وقت الذروة
  bool isPeakHour() {
    final now = DateTime.now();
    return _peakHours.contains(now.hour);
  }

  /// الحصول على قائمة المحافظات
  List<Governorate> getGovernorates() {
    return _governorates.where((gov) => gov.isActive).toList();
  }

  /// تحديث نمط التسعير لمحافظة
  void updatePricingPattern(String governorateId, String patternId) {
    final index = _governorates.indexWhere((gov) => gov.id == governorateId);
    if (index != -1) {
      final gov = _governorates[index];
      _governorates[index] = Governorate(
        id: gov.id,
        name: gov.name,
        nameAr: gov.nameAr,
        latitude: gov.latitude,
        longitude: gov.longitude,
        radius: gov.radius,
        isActive: gov.isActive,
        selectedPricingPattern: patternId,
        economyTiers: gov.economyTiers,
      );
      AppLogger.info('Updated pattern for ${gov.nameAr} to $patternId');
    }
  }

  /// تحديث أسعار الفئة الاقتصادية
  void updateEconomyTierPrices(
    String governorateId,
    double baseFare,
    double perMinuteRate,
    double perKmRate,
  ) {
    final index = _governorates.indexWhere((gov) => gov.id == governorateId);
    if (index != -1) {
      final gov = _governorates[index];
      final newEconomy = EconomyTier(
        name: gov.economyTiers.economy.name,
        nameAr: gov.economyTiers.economy.nameAr,
        baseFare: baseFare,
        perMinuteRate: perMinuteRate,
        perKmRate: perKmRate,
        peakHourMultiplier: gov.economyTiers.economy.peakHourMultiplier,
      );
      _governorates[index] = Governorate(
        id: gov.id,
        name: gov.name,
        nameAr: gov.nameAr,
        latitude: gov.latitude,
        longitude: gov.longitude,
        radius: gov.radius,
        isActive: gov.isActive,
        selectedPricingPattern: gov.selectedPricingPattern,
        economyTiers: GovernorateEconomyTiers(
          economy: newEconomy,
          super_: gov.economyTiers.super_,
        ),
      );
    }
  }

  /// تحديث أسعار الفئة سوبر
  void updateSuperTierPrices(
    String governorateId,
    double baseFare,
    double perMinuteRate,
    double perKmRate,
  ) {
    final index = _governorates.indexWhere((gov) => gov.id == governorateId);
    if (index != -1) {
      final gov = _governorates[index];
      final newSuper = EconomyTier(
        name: gov.economyTiers.super_.name,
        nameAr: gov.economyTiers.super_.nameAr,
        baseFare: baseFare,
        perMinuteRate: perMinuteRate,
        perKmRate: perKmRate,
        peakHourMultiplier: gov.economyTiers.super_.peakHourMultiplier,
      );
      _governorates[index] = Governorate(
        id: gov.id,
        name: gov.name,
        nameAr: gov.nameAr,
        latitude: gov.latitude,
        longitude: gov.longitude,
        radius: gov.radius,
        isActive: gov.isActive,
        selectedPricingPattern: gov.selectedPricingPattern,
        economyTiers: GovernorateEconomyTiers(
          economy: gov.economyTiers.economy,
          super_: newSuper,
        ),
      );
    }
  }
}
