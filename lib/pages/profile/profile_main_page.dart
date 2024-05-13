import 'package:flutter/material.dart';
import 'package:esalesapp/repositories/user/user_repository.dart';
import 'package:esalesapp/pages/profile/profile_page.dart';

class ProfileMainPage extends StatelessWidget {
  final int userid;
  final UserRepository userRepository;

  const ProfileMainPage(
      {super.key, required this.userid, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ProfilePage(
      key: key
    )
  );
  }
}
