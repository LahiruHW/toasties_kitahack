import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toasties_flutter/common/entity/index.dart';
import 'package:toasties_flutter/common/providers/auth_provider.dart';
// import 'package:toasties_flutter/common/providers/chat_provider.dart';
import 'package:toasties_flutter/common/widgets/chat_input_group.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final TextEditingController _textController;
  final GlobalKey<NavigatorState> _chatNavKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _chatNavKey,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Consumer<ToastieAuthProvider>(
          builder: (context, authProvider, child) => Scaffold(
            body: Stack(
              children: [
                Positioned.fill(
                  child: ListView.builder(
                    itemCount: authProvider.currentChat!.msgs!.length,
                    itemBuilder: (context, index) {
                      return 
                      
                      authProvider.currentChat!.msgs![index].toChatBubble(style: Theme.of(context).textTheme.labelSmall);


                    },
                  ),

                  // ListView(
                  //   children:

                  //   // authProvider.chat.msgs!.map((msg) => msg.toChatBubble(style: Theme.of(context).textTheme.labelSmall)).toList()
                  //   authProvider.currentChat!.msgs!.map((msg) => msg.toChatBubble(style: Theme.of(context).textTheme.labelSmall)).toList()

                  // ),
                ),
                ChatInputGroup(
                  textController: _textController,
                  onSend: () {
                    print(_textController.text);


                    // get the text, convert to message, add to chat

                    final newMsg = Message(timeCreated: Timestamp.now(), isMsgUser: true, content: _textController.text);

                    authProvider.addToCurrentChat(newMsg);

                    _textController.clear();


                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
