part of casauth;

enum ErrorLevel {
  warn,
  error,
  fatal,
}

class CASAuthError extends Error {
  final ErrorLevel level;
  final String message;

  CASAuthError(this.level, this.message);

  @override
  String toString() {
    return "[$level]CASAuthError: $message";
  }
}
