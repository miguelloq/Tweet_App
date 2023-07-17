// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RegistrationRequestModel {
  String email;
  String password;
  String confirmPassword;
  String identifier;

  RegistrationRequestModel({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.identifier,
  });

  RegistrationRequestModel copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    String? identifier,
  }) {
    return RegistrationRequestModel(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      identifier: identifier ?? this.identifier,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'identifier': identifier,
    };
  }

  factory RegistrationRequestModel.fromMap(Map<String, dynamic> map) {
    return RegistrationRequestModel(
      email: map['email'] as String,
      password: map['password'] as String,
      confirmPassword: map['confirmPassword'] as String,
      identifier: map['identifier'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegistrationRequestModel.fromJson(String source) =>
      RegistrationRequestModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
