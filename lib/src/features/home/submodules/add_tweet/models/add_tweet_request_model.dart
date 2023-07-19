import 'dart:convert';

class AddTweetRequestModel {
  String userUid;
  String message;

  AddTweetRequestModel({required this.userUid, required this.message});

  AddTweetRequestModel copyWith({
    String? userUid,
    String? message,
  }) {
    return AddTweetRequestModel(
      userUid: userUid ?? this.userUid,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userUid': userUid,
      'message': message,
    };
  }

  factory AddTweetRequestModel.fromMap(Map<String, dynamic> map) {
    return AddTweetRequestModel(
      userUid: map['userUid'] as String,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddTweetRequestModel.fromJson(String source) =>
      AddTweetRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
