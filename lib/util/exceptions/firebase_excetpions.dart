class NFirebaseException implements Exception {
  final String message;

  NFirebaseException(this.message);

  @override
  String toString() {
    return 'NFirebaseException: $message';
  }
}