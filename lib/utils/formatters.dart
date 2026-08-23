import 'intl.dart' as intl;

class DateFormatter {
  // Format date to readable format
  static String formatDate(DateTime dateTime) {
    return intl.DateFormat('dd MMM yyyy').format(dateTime);
  }

  // Format date and time
  static String formatDateTime(DateTime dateTime) {
    return intl.DateFormat('dd MMM yyyy - hh:mm a').format(dateTime);
  }

  // Format time only
  static String formatTime(DateTime dateTime) {
    return intl.DateFormat('hh:mm a').format(dateTime);
  }

  // Get relative time (e.g., "2 hours ago")
  static String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return formatDate(dateTime);
    }
  }
}
