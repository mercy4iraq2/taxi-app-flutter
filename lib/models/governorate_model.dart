/// نموذج المحافظة/الإقليم مع دعم أنماط التسعيرية المختلفة
class Governorate {
  final String id;
  final String name;
  final String nameAr;
  final double latitude;
  final double longitude;
  final double radius; // نطاق المحافظة بالمتر
  final bool isActive;
  
  // بيانات التسعير
  final String? selectedPricingPattern; // رقم النمط المختار (1-6)
  final GovernorateEconomyTiers economyTiers; // الفئات الاقتصادية

  Governorate({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.latitude,
    required this.longitude,
    required this.radius,
    this.isActive = true,
    this.selectedPricingPattern,
    required this.economyTiers,
  });

  factory Governorate.fromJson(Map<String, dynamic> json) {
    return Governorate(
      id: json['id'] as String,
      name: json['name'] as String,
      nameAr: json['nameAr'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      radius: (json['radius'] as num).toDouble(),
      isActive: json['isActive'] as bool? ?? true,
      selectedPricingPattern: json['selectedPricingPattern'] as String?,
      economyTiers: GovernorateEconomyTiers.fromJson(
        json['economyTiers'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nameAr': nameAr,
      'latitude': latitude,
      'longitude': longitude,
      'radius': radius,
      'isActive': isActive,
      'selectedPricingPattern': selectedPricingPattern,
      'economyTiers': economyTiers.toJson(),
    };
  }
}

/// فئات اقتصادية (اقتصادية وسوبر)
class GovernorateEconomyTiers {
  final EconomyTier economy; // الفئة الاقتصادية
  final EconomyTier super_; // الفئة سوبر

  GovernorateEconomyTiers({
    required this.economy,
    required this.super_,
  });

  factory GovernorateEconomyTiers.fromJson(Map<String, dynamic> json) {
    return GovernorateEconomyTiers(
      economy: EconomyTier.fromJson(
        json['economy'] as Map<String, dynamic>,
      ),
      super_: EconomyTier.fromJson(
        json['super'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'economy': economy.toJson(),
      'super': super_.toJson(),
    };
  }
}

/// فئة اقتصادية واحدة
class EconomyTier {
  final String name; // "اقتصادية" أو "سوبر"
  final String nameAr;
  final double baseFare; // اجرة الانطلاق (الاجرة الأساسية)
  final double perMinuteRate; // سعر الدقيقة
  final double perKmRate; // سعر الكيلومتر (للأنماط التي تتطلبها)
  final double peakHourMultiplier; // معامل أوقات الذروة

  EconomyTier({
    required this.name,
    required this.nameAr,
    required this.baseFare,
    required this.perMinuteRate,
    required this.perKmRate,
    this.peakHourMultiplier = 1.0,
  });

  factory EconomyTier.fromJson(Map<String, dynamic> json) {
    return EconomyTier(
      name: json['name'] as String,
      nameAr: json['nameAr'] as String,
      baseFare: (json['baseFare'] as num).toDouble(),
      perMinuteRate: (json['perMinuteRate'] as num).toDouble(),
      perKmRate: (json['perKmRate'] as num).toDouble(),
      peakHourMultiplier: (json['peakHourMultiplier'] as num?)?.toDouble() ?? 1.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'nameAr': nameAr,
      'baseFare': baseFare,
      'perMinuteRate': perMinuteRate,
      'perKmRate': perKmRate,
      'peakHourMultiplier': peakHourMultiplier,
    };
  }
}
