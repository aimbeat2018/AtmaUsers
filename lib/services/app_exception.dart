class AppException implements Exception {
  AppException([this.message = '', this.statusCode = 200]);

  final String message;
  final int statusCode;
}