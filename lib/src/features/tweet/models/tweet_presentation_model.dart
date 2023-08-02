// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:tweet_app/src/features/tweet/models/tweet_request_model.dart';

class TweetPresentationModel {
  final TweetRequestModel tweet;
  final String userIdentifier;
  final String profilePictureNetworkUrl;

  TweetPresentationModel({
    required this.tweet,
    required this.userIdentifier,
    required this.profilePictureNetworkUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tweet': tweet.toMap(),
      'userIdentifier': userIdentifier,
      'profilePictureNetworkUrl': profilePictureNetworkUrl,
    };
  }

  factory TweetPresentationModel.fromMap(Map<String, dynamic> map) {
    return TweetPresentationModel(
      tweet: TweetRequestModel.fromMap(map['tweet'] as Map<String, dynamic>),
      userIdentifier: map['userIdentifier'] as String,
      profilePictureNetworkUrl: map['profilePictureNetworkUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TweetPresentationModel.fromJson(String source) =>
      TweetPresentationModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  TweetPresentationModel copyWith({
    TweetRequestModel? tweet,
    String? userIdentifier,
    String? profilePictureNetworkUrl,
  }) {
    return TweetPresentationModel(
      tweet: tweet ?? this.tweet,
      userIdentifier: userIdentifier ?? this.userIdentifier,
      profilePictureNetworkUrl:
          profilePictureNetworkUrl ?? this.profilePictureNetworkUrl,
    );
  }
}
