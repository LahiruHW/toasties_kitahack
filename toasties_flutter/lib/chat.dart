import 'package:flutter/material.dart';
// import 'package:toasties_flutter/common/widgets/toasties_appbar.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    super.key,
  });

  static const String routeName = '/chat';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Chat Page',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
