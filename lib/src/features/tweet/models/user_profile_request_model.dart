// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserProfileRequestModel {
  final String bannerPhoto;
  final String identifier;
  final String photo;
  final String uidAuth;

  UserProfileRequestModel(
      {required this.bannerPhoto,
      required this.identifier,
      required this.photo,
      required this.uidAuth});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bannerPhoto': bannerPhoto,
      'identifier': identifier,
      'photo': photo,
      'uidAuth': uidAuth,
    };
  }

  factory UserProfileRequestModel.fromMap(Map<String, dynamic> map) {
    return UserProfileRequestModel(
      bannerPhoto: map['bannerPhoto'] as String,
      identifier: map['identifier'] as String,
      photo: map['photo'] as String,
      uidAuth: map['uidAuth'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfileRequestModel.fromJson(String source) =>
      UserProfileRequestModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
