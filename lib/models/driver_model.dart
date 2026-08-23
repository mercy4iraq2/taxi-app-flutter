class Driver {
  final String id;
  final String userId;
  final String licenseNumber;
  final String licenseExpiry;
  final String vehicleNumber;
  final String vehicleModel;
  final String vehicleColor;
  final double rating;
  final int totalTrips;
  final bool isVerified;
  final bool isOnline;
  final double currentLatitude;
  final double currentLongitude;
  final double totalEarnings;
  final double todayEarnings;
  final DateTime createdAt;

  Driver({
    required this.id,
    required this.userId,
    required this.licenseNumber,
    required this.licenseExpiry,
    required this.vehicleNumber,
    required this.vehicleModel,
    required this.vehicleColor,
    this.rating = 5.0,
    this.totalTrips = 0,
    this.isVerified = false,
    this.isOnline = false,
    this.currentLatitude = 0.0,
    this.currentLongitude = 0.0,
    this.totalEarnings = 0.0,
    this.todayEarnings = 0.0,
    required this.createdAt,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['id'] as String,
      userId: json['userId'] as String,
      licenseNumber: json['licenseNumber'] as String,
      licenseExpiry: json['licenseExpiry'] as String,
      vehicleNumber: json['vehicleNumber'] as String,
      vehicleModel: json['vehicleModel'] as String,
      vehicleColor: json['vehicleColor'] as String,
      rating: (json['rating'] as num?)?.toDouble() ?? 5.0,
      totalTrips: json['totalTrips'] as int? ?? 0,
      isVerified: json['isVerified'] as bool? ?? false,
      isOnline: json['isOnline'] as bool? ?? false,
      currentLatitude: (json['currentLatitude'] as num?)?.toDouble() ?? 0.0,
      currentLongitude: (json['currentLongitude'] as num?)?.toDouble() ?? 0.0,
      totalEarnings: (json['totalEarnings'] as num?)?.toDouble() ?? 0.0,
      todayEarnings: (json['todayEarnings'] as num?)?.toDouble() ?? 0.0,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'licenseNumber': licenseNumber,
      'licenseExpiry': licenseExpiry,
      'vehicleNumber': vehicleNumber,
      'vehicleModel': vehicleModel,
      'vehicleColor': vehicleColor,
      'rating': rating,
      'totalTrips': totalTrips,
      'isVerified': isVerified,
      'isOnline': isOnline,
      'currentLatitude': currentLatitude,
      'currentLongitude': currentLongitude,
      'totalEarnings': totalEarnings,
      'todayEarnings': todayEarnings,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
