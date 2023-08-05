import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tweet_app/src/features/tweet/models/user_request_model.dart';

class UserTileSliverList extends StatelessWidget {
  final List<UserRequestModel> users;
  const UserTileSliverList({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        UserRequestModel currentUser = users[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: Image.network(currentUser.iconPhoto).image,
          ),
          title: Text(currentUser.identifier),
          onTap: () {
            Modular.to.pushNamed('profile/${currentUser.uidAuth}');
          },
        );
      },
    );
  }
}
