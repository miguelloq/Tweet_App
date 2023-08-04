import 'dart:convert';

class UserRequestModel {
  final String bannerPhoto;
  final String identifier;
  final String iconPhoto;
  final String uidAuth;

  UserRequestModel(
      {required this.bannerPhoto,
      required this.identifier,
      required this.iconPhoto,
      required this.uidAuth});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bannerPhoto': bannerPhoto,
      'identifier': identifier,
      'photo': iconPhoto,
      'uidAuth': uidAuth,
    };
  }

  factory UserRequestModel.empty() {
    return UserRequestModel(
        bannerPhoto: '', identifier: '', iconPhoto: '', uidAuth: '');
  }

  factory UserRequestModel.fromMap(Map<String, dynamic> map) {
    return UserRequestModel(
      bannerPhoto: map['bannerPhoto'] as String,
      identifier: map['identifier'] as String,
      iconPhoto: map['iconPhoto'] as String,
      uidAuth: map['uidAuth'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserRequestModel.fromJson(String source) =>
      UserRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserRequestModel(bannerPhoto: $bannerPhoto, identifier: $identifier, iconPhoto: $iconPhoto, uidAuth: $uidAuth)';
  }

  UserRequestModel copyWith({
    String? bannerPhoto,
    String? identifier,
    String? iconPhoto,
    String? uidAuth,
  }) {
    return UserRequestModel(
      bannerPhoto: bannerPhoto ?? this.bannerPhoto,
      identifier: identifier ?? this.identifier,
      iconPhoto: iconPhoto ?? this.iconPhoto,
      uidAuth: uidAuth ?? this.uidAuth,
    );
  }
}
