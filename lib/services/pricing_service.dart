import 'package:geolocator/geolocator.dart' hide Position;
import '../models/city_model.dart';
import '../models/pricing_model.dart';
import '../utils/logger.dart';

/// خدمة التسعير والتمييز بين الرحلات الداخلية والخارجية
class PricingService {
  static final PricingService _instance = PricingService._internal();
  
  // بيانات المدن والمناطق
  final List<City> _cities = [];
  
  // بيانات التسعير
  late PricingModel _currentPricing;
  
  // نطاقات الوقت للتسعير الديناميكي
  final List<int> _peakHours = [7, 8, 9, 17, 18, 19, 20]; // ساعات الذروة
  final List<int> _nightHours = [0, 1, 2, 3, 4, 5]; // ساعات الليل

  factory PricingService() {
    return _instance;
  }

  PricingService._internal() {
    _initializeCities();
  }

  /// تهيئة بيانات المدن والمناطق
  void _initializeCities() {
    _cities.addAll([
      City(
        id: 'city_baghdad',
        name: 'Baghdad',
        nameAr: 'بغداد',
        latitude: 33.3128,
        longitude: 44.3615,
        radius: 15000, // 15 كم من مركز المدينة
        type: 'city',
      ),
      City(
        id: 'city_basra',
        name: 'Basra',
        nameAr: 'البصرة',
        latitude: 30.5433,
        longitude: 47.8068,
        radius: 12000,
        type: 'city',
      ),
      City(
        id: 'city_erbil',
        name: 'Erbil',
        nameAr: 'أربيل',
        latitude: 36.1910,
        longitude: 44.0091,
        radius: 10000,
        type: 'city',
      ),
    ]);
  }

  /// تعيين بيانات التسعير
  void setPricing(PricingModel pricing) {
    _currentPricing = pricing;
  }

  /// تحديد نوع الرحلة (داخلية أو خارجية أو ضاحية)
  String determineTripType(
    double pickupLat,
    double pickupLng,
    double dropoffLat,
    double dropoffLng,
  ) {
    final pickupCity = _getCityForLocation(pickupLat, pickupLng);
    final dropoffCity = _getCityForLocation(dropoffLat, dropoffLng);

    AppLogger.info(
      'Pickup city: ${pickupCity?.nameAr}, Dropoff city: ${dropoffCity?.nameAr}',
    );

    // إذا كانت نقطة الانطلاق والوصول في نفس المدينة → رحلة داخلية
    if (pickupCity != null && dropoffCity != null && pickupCity.id == dropoffCity.id) {
      return 'inside'; // رحلة داخلية
    }

    // إذا كانت إحدى النقطتين خارج المدينة → رحلة خارجية
    if (pickupCity == null || dropoffCity == null) {
      return 'outside'; // رحلة خارجية
    }

    // إذا كانت النقطتان في مدن مختلفة → رحلة خارجية طويلة
    return 'outside';
  }

  /// البحث عن المدينة للموقع المعطى
  City? _getCityForLocation(double latitude, double longitude) {
    for (final city in _cities) {
      final distance = _calculateDistance(
        city.latitude,
        city.longitude,
        latitude,
        longitude,
      );

      // إذا كان الموقع ضمن نطاق المدينة
      if (distance <= city.radius) {
        return city;
      }
    }
    return null; // الموقع خارج جميع المدن المعرّفة
  }

  /// حساب المسافة بين نقطتين (صيغة Haversine)
  double _calculateDistance(
    double lat1,
    double lng1,
    double lat2,
    double lng2,
  ) {
    return Geolocator.distanceBetween(lat1, lng1, lat2, lng2);
  }

  /// حساب التكلفة المقدرة للرحلة
  double calculateEstimatedFare(
    double distanceKm,
    double durationMinutes,
    String tripType, // 'inside', 'outside', 'suburb'
    {bool isPeakHour = false}
  ) {
    double baseFare;
    double perKmRate;
    double perMinRate;
    double minimumFare;
    double surgeMultiplier;

    // اختيار معاملات التسعير بناءً على نوع الرحلة
    switch (tripType) {
      case 'inside':
        baseFare = _currentPricing.insideBaseFare;
        perKmRate = _currentPricing.insidePerKmRate;
        perMinRate = _currentPricing.insidePerMinRate;
        minimumFare = _currentPricing.insideMinimumFare;
        surgeMultiplier = _currentPricing.insideSurgeMultiplier;
        break;
      case 'suburb':
        baseFare = _currentPricing.suburbBaseFare;
        perKmRate = _currentPricing.suburbPerKmRate;
        perMinRate = _currentPricing.suburbPerMinRate;
        minimumFare = _currentPricing.suburbMinimumFare;
        surgeMultiplier = 1.0; // لا توجد رسوم ذروة في الضاحية
        break;
      case 'outside':
      default:
        baseFare = _currentPricing.outsideBaseFare;
        perKmRate = _currentPricing.outsidePerKmRate;
        perMinRate = _currentPricing.outsidePerMinRate;
        minimumFare = _currentPricing.outsideMinimumFare;
        surgeMultiplier = _currentPricing.outsideSurgeMultiplier;
    }

    // حساب التكلفة الأساسية
    double fare = baseFare + (distanceKm * perKmRate) + (durationMinutes * perMinRate);

    // تطبيق الحد الأدنى للتكلفة
    if (fare < minimumFare) {
      fare = minimumFare;
    }

    // تطبيق معامل التسعير الديناميكي (وقت الذروة)
    if (isPeakHour) {
      fare = fare * surgeMultiplier;
    }

    return double.parse(fare.toStringAsFixed(2));
  }

  /// التحقق من كون الوقت الحالي وقت ذروة
  bool isPeakHour() {
    final now = DateTime.now();
    return _peakHours.contains(now.hour);
  }

  /// التحقق من كون الوقت الحالي وقت ليل
  bool isNightTime() {
    final now = DateTime.now();
    return _nightHours.contains(now.hour);
  }

  /// الحصول على وصف نوع الرحلة
  String getTripTypeDescription(String tripType) {
    switch (tripType) {
      case 'inside':
        return 'رحلة داخلية - Inside City';
      case 'suburb':
        return 'رحلة ضاحية - Suburb Trip';
      case 'outside':
        return 'رحلة خارجية - Long Distance';
      default:
        return 'Unknown Trip Type';
    }
  }

  /// الحصول على قائمة المدن
  List<City> getCities() {
    return _cities.where((city) => city.isActive).toList();
  }

  /// إضافة مدينة جديدة
  void addCity(City city) {
    _cities.add(city);
  }

  /// حساب التكلفة مع تفاصيل كاملة
  Map<String, dynamic> calculateDetailedFare(
    double distanceKm,
    double durationMinutes,
    double pickupLat,
    double pickupLng,
    double dropoffLat,
    double dropoffLng,
  ) {
    final tripType = determineTripType(
      pickupLat,
      pickupLng,
      dropoffLat,
      dropoffLng,
    );

    final isPeak = isPeakHour();
    final isNight = isNightTime();
    final baseFare = calculateEstimatedFare(
      distanceKm,
      durationMinutes,
      tripType,
      isPeakHour: false,
    );

    final finalFare = calculateEstimatedFare(
      distanceKm,
      durationMinutes,
      tripType,
      isPeakHour: isPeak,
    );

    return {
      'tripType': tripType,
      'tripTypeDescription': getTripTypeDescription(tripType),
      'distanceKm': double.parse(distanceKm.toStringAsFixed(2)),
      'durationMinutes': double.parse(durationMinutes.toStringAsFixed(2)),
      'baseFare': baseFare,
      'finalFare': finalFare,
      'surgeApplied': isPeak,
      'surgeMultiplier': isPeak ? 1.5 : 1.0,
      'isPeakHour': isPeak,
      'isNightTime': isNight,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }
}
