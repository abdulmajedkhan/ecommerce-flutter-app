class NFirebaseAuthException implements Exception {
  final String message;
  NFirebaseAuthException(this.message);

  @override
  String toString() {
    return message;
//
  }
}