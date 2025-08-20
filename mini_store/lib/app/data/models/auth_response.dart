class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final String fullName;
  final String id;
  final String email;

  AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.fullName,
    required this.id,
    required this.email,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      fullName: json['fullName'],
      id: json['userId'].toString(),
      email: json['email'],
    );
  }
}
