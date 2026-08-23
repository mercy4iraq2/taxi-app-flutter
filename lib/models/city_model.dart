/// نموذج المدينة/المنطقة للتمييز بين الرحلات الداخلية والخارجية
class City {
  final String id;
  final String name;
  final String nameAr; // الاسم العربي
  final double latitude;
  final double longitude;
  final double radius; // نصف قطر المدينة بالمتر
  final String type; // 'city' أو 'suburb' أو 'rural'
  final bool isActive;

  City({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.latitude,
    required this.longitude,
    required this.radius,
    this.type = 'city',
    this.isActive = true,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'] as String,
      name: json['name'] as String,
      nameAr: json['nameAr'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      radius: (json['radius'] as num).toDouble(),
      type: json['type'] as String? ?? 'city',
      isActive: json['isActive'] as bool? ?? true,
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
      'type': type,
      'isActive': isActive,
    };
  }
}
