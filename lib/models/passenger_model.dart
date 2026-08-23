class Passenger {
  final String id;
  final String userId;
  final String? emergencyContact;
  final String? emergencyPhone;
  final double rating;
  final int totalTrips;
  final double totalSpent;
  final DateTime createdAt;

  Passenger({
    required this.id,
    required this.userId,
    this.emergencyContact,
    this.emergencyPhone,
    this.rating = 5.0,
    this.totalTrips = 0,
    this.totalSpent = 0.0,
    required this.createdAt,
  });

  factory Passenger.fromJson(Map<String, dynamic> json) {
    return Passenger(
      id: json['id'] as String,
      userId: json['userId'] as String,
      emergencyContact: json['emergencyContact'] as String?,
      emergencyPhone: json['emergencyPhone'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 5.0,
      totalTrips: json['totalTrips'] as int? ?? 0,
      totalSpent: (json['totalSpent'] as num?)?.toDouble() ?? 0.0,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'emergencyContact': emergencyContact,
      'emergencyPhone': emergencyPhone,
      'rating': rating,
      'totalTrips': totalTrips,
      'totalSpent': totalSpent,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
