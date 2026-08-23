/// نموذج التسعير يحتوي على أسعار الرحلات الداخلية والخارجية
class PricingModel {
  final String id;
  final String name; // مثل: "تسعير مدينة بغداد"
  final String nameAr;
  
  // التسعير الداخلي (Inside City)
  final double insideBaseFare; // الفتحة الأساسية
  final double insidePerKmRate; // السعر لكل كيلومتر
  final double insidePerMinRate; // السعر لكل دقيقة انتظار
  final double insideMinimumFare; // الحد الأدنى للرحلة
  final double insideSurgeMultiplier; // معامل التسعير الديناميكي (وقت الذروة)
  
  // التسعير الخارجي (Outside City / Long Distance)
  final double outsideBaseFare; // الفتحة الأساسية
  final double outsidePerKmRate; // السعر لكل كيلومتر (عادة أقل من الداخل)
  final double outsidePerMinRate; // السعر لكل دقيقة انتظار
  final double outsideMinimumFare; // الحد الأدنى للرحلة
  final double outsideSurgeMultiplier; // معامل التسعير الديناميكي
  
  // تسعير المناطق الضاحية (Suburb)
  final double suburbBaseFare;
  final double suburbPerKmRate;
  final double suburbPerMinRate;
  final double suburbMinimumFare;
  
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  PricingModel({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.insideBaseFare,
    required this.insidePerKmRate,
    required this.insidePerMinRate,
    required this.insideMinimumFare,
    this.insideSurgeMultiplier = 1.5,
    required this.outsideBaseFare,
    required this.outsidePerKmRate,
    required this.outsidePerMinRate,
    required this.outsideMinimumFare,
    this.outsideSurgeMultiplier = 1.2,
    required this.suburbBaseFare,
    required this.suburbPerKmRate,
    required this.suburbPerMinRate,
    required this.suburbMinimumFare,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PricingModel.fromJson(Map<String, dynamic> json) {
    return PricingModel(
      id: json['id'] as String,
      name: json['name'] as String,
      nameAr: json['nameAr'] as String,
      insideBaseFare: (json['insideBaseFare'] as num).toDouble(),
      insidePerKmRate: (json['insidePerKmRate'] as num).toDouble(),
      insidePerMinRate: (json['insidePerMinRate'] as num).toDouble(),
      insideMinimumFare: (json['insideMinimumFare'] as num).toDouble(),
      insideSurgeMultiplier: (json['insideSurgeMultiplier'] as num?)?.toDouble() ?? 1.5,
      outsideBaseFare: (json['outsideBaseFare'] as num).toDouble(),
      outsidePerKmRate: (json['outsidePerKmRate'] as num).toDouble(),
      outsidePerMinRate: (json['outsidePerMinRate'] as num).toDouble(),
      outsideMinimumFare: (json['outsideMinimumFare'] as num).toDouble(),
      outsideSurgeMultiplier: (json['outsideSurgeMultiplier'] as num?)?.toDouble() ?? 1.2,
      suburbBaseFare: (json['suburbBaseFare'] as num).toDouble(),
      suburbPerKmRate: (json['suburbPerKmRate'] as num).toDouble(),
      suburbPerMinRate: (json['suburbPerMinRate'] as num).toDouble(),
      suburbMinimumFare: (json['suburbMinimumFare'] as num).toDouble(),
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nameAr': nameAr,
      'insideBaseFare': insideBaseFare,
      'insidePerKmRate': insidePerKmRate,
      'insidePerMinRate': insidePerMinRate,
      'insideMinimumFare': insideMinimumFare,
      'insideSurgeMultiplier': insideSurgeMultiplier,
      'outsideBaseFare': outsideBaseFare,
      'outsidePerKmRate': outsidePerKmRate,
      'outsidePerMinRate': outsidePerMinRate,
      'outsideMinimumFare': outsideMinimumFare,
      'outsideSurgeMultiplier': outsideSurgeMultiplier,
      'suburbBaseFare': suburbBaseFare,
      'suburbPerKmRate': suburbPerKmRate,
      'suburbPerMinRate': suburbPerMinRate,
      'suburbMinimumFare': suburbMinimumFare,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
