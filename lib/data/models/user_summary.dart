class UserSummary {
  const UserSummary({required this.id, required this.email, this.fullName});

  final String id;
  final String email;
  final String? fullName;

  factory UserSummary.fromJson(Map<String, dynamic> json) {
    return UserSummary(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['full_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'full_name': fullName};
  }
}
