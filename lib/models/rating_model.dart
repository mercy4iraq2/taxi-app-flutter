class Rating {
  final String id;
  final String tripId;
  final String fromUserId;
  final String toUserId;
  final double rating; // 1-5 stars
  final String review;
  final DateTime createdAt;

  Rating({
    required this.id,
    required this.tripId,
    required this.fromUserId,
    required this.toUserId,
    required this.rating,
    required this.review,
    required this.createdAt,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      id: json['id'] as String,
      tripId: json['tripId'] as String,
      fromUserId: json['fromUserId'] as String,
      toUserId: json['toUserId'] as String,
      rating: (json['rating'] as num).toDouble(),
      review: json['review'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tripId': tripId,
      'fromUserId': fromUserId,
      'toUserId': toUserId,
      'rating': rating,
      'review': review,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
