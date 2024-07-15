class NFormatException implements Exception {
  final String message;

  NFormatException(this.message);

  @override
  String toString() {
    return 'NFormatException: $message';
  }
}