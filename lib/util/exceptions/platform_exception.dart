class NPlatformException implements Exception {
  final String message;

  NPlatformException(this.message);

  @override
  String toString() {
    return 'NPlatformException: $message';
  }
}