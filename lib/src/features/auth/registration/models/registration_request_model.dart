import 'dart:convert';

class RegistrationRequestModel {
  String email;
  String password;
  String confirmPassword;

  RegistrationRequestModel({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  RegistrationRequestModel copyWith({
    String? email,
    String? password,
    String? confirmPassword,
  }) {
    return RegistrationRequestModel(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }

  factory RegistrationRequestModel.fromMap(Map<String, dynamic> map) {
    return RegistrationRequestModel(
      email: map['email'] as String,
      password: map['password'] as String,
      confirmPassword: map['confirmPassword'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegistrationRequestModel.fromJson(String source) =>
      RegistrationRequestModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
