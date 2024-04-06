class AuthException implements Exception {
  AuthException({this.code = 'unknown'});

  final String code;
}
