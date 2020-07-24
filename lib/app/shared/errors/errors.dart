abstract class Failure implements Exception {
  String get message;
}

class DioFailure extends Failure {
  final String message;
  final int statusCode;
  DioFailure({
    this.message,
    this.statusCode,
  });
}
