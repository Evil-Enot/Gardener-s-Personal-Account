class AuthResponse {
  bool error;
  int code;
  String message;

  AuthResponse(
      {required this.error, required this.code, required this.message});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      error: json['error'],
      code: json['code'],
      message: json['message'],
    );
  }
}
