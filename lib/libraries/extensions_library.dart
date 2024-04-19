extension StringExtensions on String {
  String capitalize() => (trim().isEmpty) ? this : "${this[0].toUpperCase()}${substring(1)}";
}
