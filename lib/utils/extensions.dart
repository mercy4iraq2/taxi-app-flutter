class StringExtensions on String {
  bool get isValidEmail {
    const pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(this);
  }

  bool get isValidPhone {
    return length >= 10 && length <= 15 && int.tryParse(this) != null;
  }

  String get capitalized {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  String get titleCase {
    return split(' ')
        .map((word) => word.capitalized)
        .join(' ');
  }
}
