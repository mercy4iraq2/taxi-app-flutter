class Trip {
  final String id;
  final String passengerId;
  final String? driverId;
  final String pickupAddress;
  final String dropoffAddress;
  final double pickupLatitude;
  final double pickupLongitude;
  final double dropoffLatitude;
  final double dropoffLongitude;
  final double estimatedDistance;
  final double estimatedDuration; // in minutes
  final double estimatedFare;
  final double? actualFare;
  final String status; // 'requested', 'accepted', 'in_progress', 'completed', 'cancelled'
  final DateTime requestedAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final String? paymentMethod;
  final bool? riderRated;
  final bool? driverRated;

  Trip({
    required this.id,
    required this.passengerId,
    this.driverId,
    required this.pickupAddress,
    required this.dropoffAddress,
    required this.pickupLatitude,
    required this.pickupLongitude,
    required this.dropoffLatitude,
    required this.dropoffLongitude,
    required this.estimatedDistance,
    required this.estimatedDuration,
    required this.estimatedFare,
    this.actualFare,
    required this.status,
    required this.requestedAt,
    this.startedAt,
    this.completedAt,
    this.paymentMethod,
    this.riderRated = false,
    this.driverRated = false,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'] as String,
      passengerId: json['passengerId'] as String,
      driverId: json['driverId'] as String?,
      pickupAddress: json['pickupAddress'] as String,
      dropoffAddress: json['dropoffAddress'] as String,
      pickupLatitude: (json['pickupLatitude'] as num).toDouble(),
      pickupLongitude: (json['pickupLongitude'] as num).toDouble(),
      dropoffLatitude: (json['dropoffLatitude'] as num).toDouble(),
      dropoffLongitude: (json['dropoffLongitude'] as num).toDouble(),
      estimatedDistance: (json['estimatedDistance'] as num).toDouble(),
      estimatedDuration: (json['estimatedDuration'] as num).toDouble(),
      estimatedFare: (json['estimatedFare'] as num).toDouble(),
      actualFare: json['actualFare'] != null ? (json['actualFare'] as num).toDouble() : null,
      status: json['status'] as String,
      requestedAt: DateTime.parse(json['requestedAt'] as String),
      startedAt: json['startedAt'] != null ? DateTime.parse(json['startedAt'] as String) : null,
      completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt'] as String) : null,
      paymentMethod: json['paymentMethod'] as String?,
      riderRated: json['riderRated'] as bool? ?? false,
      driverRated: json['driverRated'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'passengerId': passengerId,
      'driverId': driverId,
      'pickupAddress': pickupAddress,
      'dropoffAddress': dropoffAddress,
      'pickupLatitude': pickupLatitude,
      'pickupLongitude': pickupLongitude,
      'dropoffLatitude': dropoffLatitude,
      'dropoffLongitude': dropoffLongitude,
      'estimatedDistance': estimatedDistance,
      'estimatedDuration': estimatedDuration,
      'estimatedFare': estimatedFare,
      'actualFare': actualFare,
      'status': status,
      'requestedAt': requestedAt.toIso8601String(),
      'startedAt': startedAt?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'paymentMethod': paymentMethod,
      'riderRated': riderRated,
      'driverRated': driverRated,
    };
  }
}
