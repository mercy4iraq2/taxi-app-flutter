class AppConstants {
  // API Configuration
  static const String apiBaseUrl = 'https://api.taxiapp.com/v1';
  static const String socketUrl = 'https://socket.taxiapp.com';
  static const int requestTimeout = 30000; // milliseconds

  // Google Maps
  static const String googleMapsApiKey = 'YOUR_GOOGLE_MAPS_API_KEY';

  // Firebase
  static const String firebaseProjectId = 'taxi-app-firebase';

  // Stripe
  static const String stripePublishableKey = 'YOUR_STRIPE_PUBLISHABLE_KEY';

  // Geolocation
  static const double defaultRadius = 3000; // 3 km in meters
  static const double mapZoomLevel = 15.0;

  // Trip
  static const int tripRequestTimeout = 15; // seconds
  static const double minRideDistance = 0.5; // km
  static const double maxRideDistance = 100; // km

  // Pricing
  static const double baseFare = 2.0; // dollars
  static const double perKilometerRate = 1.5; // dollars per km
  static const double perMinuteRate = 0.3; // dollars per minute
  static const double surgePricingMultiplier = 1.5; // 50% increase during peak hours

  // Validation
  static const int minPasswordLength = 8;
  static const int phoneNumberLength = 10;
  static const int otpLength = 6;

  // UI
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 12.0;
  static const double defaultElevation = 2.0;

  // Animation Duration
  static const Duration shortAnimationDuration = Duration(milliseconds: 300);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 500);
  static const Duration longAnimationDuration = Duration(milliseconds: 1000);

  // Error Messages
  static const String networkError = 'Connection error. Please try again.';
  static const String serverError = 'Server error. Please try again later.';
  static const String unauthorizedError = 'Unauthorized. Please log in again.';
  static const String validationError = 'Please fill all required fields.';
}
