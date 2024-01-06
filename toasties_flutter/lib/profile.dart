import 'package:flutter/material.dart';
// import 'package:toasties_flutter/common/widgets/toasties_appbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
  });

  static const String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Profile Page',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
