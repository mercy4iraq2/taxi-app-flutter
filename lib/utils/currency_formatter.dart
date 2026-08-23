import 'intl.dart' as intl;

/// أدوات تنسيق الأسعار والعملات
class CurrencyFormatter {
  // تنسيق العملة
  static String formatCurrency(double amount, {String symbol = '\$'}) {
    return '$symbol${amount.toStringAsFixed(2)}';
  }

  // تنسيق العملة بصيغة عربية
  static String formatCurrencyAr(double amount, {String symbol = 'د.ع'}) {
    return '${amount.toStringAsFixed(0)} $symbol';
  }

  // تنسيق المسافة
  static String formatDistance(double distanceInMeters) {
    if (distanceInMeters < 1000) {
      return '${distanceInMeters.toStringAsFixed(0)} m';
    } else {
      final km = distanceInMeters / 1000;
      return '${km.toStringAsFixed(1)} km';
    }
  }

  // تنسيق المسافة بالكيلومتر
  static String formatDistanceKm(double distanceKm) {
    return '${distanceKm.toStringAsFixed(1)} km';
  }

  // تنسيق المدة الزمنية
  static String formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    if (minutes > 0) {
      return '$minutes min ${seconds}s';
    } else {
      return '${seconds}s';
    }
  }

  // تنسيق المدة بالدقائق فقط
  static String formatDurationMinutes(double minutes) {
    return '${minutes.toStringAsFixed(0)} min';
  }

  // تنسيق التقييم
  static String formatRating(double rating) {
    return rating.toStringAsFixed(1);
  }

  // تنسيق النسبة المئوية
  static String formatPercentage(double percentage) {
    return '${(percentage * 100).toStringAsFixed(0)}%';
  }

  // تنسيق الرقم الكبير (مثل 1000 → 1K, 1000000 → 1M)
  static String formatLargeNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return number.toString();
    }
  }
}
