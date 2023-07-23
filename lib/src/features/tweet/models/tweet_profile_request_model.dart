import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class TweetProfileRequestModel {
  final String docName;
  final List<String>? images;
  final List<String> likesUidUsers;
  final int likesValue;
  final DateTime postCreationTime;
  final String text;
  final String uidPoster;

  TweetProfileRequestModel({
    required this.docName,
    required this.images,
    required this.likesUidUsers,
    required this.likesValue,
    required this.postCreationTime,
    required this.text,
    required this.uidPoster,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docName': docName,
      'images': images,
      'likesUidUsers': likesUidUsers,
      'likesValue': likesValue,
      'postCreationTime': postCreationTime.millisecondsSinceEpoch,
      'text': text,
      'uidPoster': uidPoster,
    };
  }

  factory TweetProfileRequestModel.fromMap(Map<String, dynamic> map) {
    return TweetProfileRequestModel(
      docName: map['docName'] as String,
      images: map['images'] != null
          ? List<String>.from(map['images'] as List<dynamic>)
          : null,
      likesUidUsers: List<String>.from(map['likesUidUsers'] as List<dynamic>),
      likesValue: map['likesValue'] as int,
      postCreationTime: (map['postCreationTime'] as Timestamp)
          .toDate(), // Convert to DateTime
      text: map['text'] as String,
      uidPoster: map['uidPoster'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TweetProfileRequestModel.fromJson(String source) =>
      TweetProfileRequestModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
