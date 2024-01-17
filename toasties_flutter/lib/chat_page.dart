import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toasties_flutter/common/providers/auth_provider.dart';
import 'package:toasties_flutter/common/providers/chat_provider.dart';
import 'package:toasties_flutter/common/widgets/chat_input_group.dart';
import 'package:toasties_flutter/common/widgets/msg_bubble.dart';

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
        child: Consumer2<ToastiesChatProvider, ToastieAuthProvider>(
          builder: (context, chatProvider, authProvider, child) => Scaffold(
            body: Stack(
              children: [
                Positioned.fill(
                  child: 
                  
      
                  
                  ListView(
                    children: 
                    
                    // chatProvider.chat.msgs!.map((msg) => msg.toChatBubble(style: Theme.of(context).textTheme.labelSmall)).toList()                  
                    
                    
                    [
                      ToastieChatBubble(
                        isMsgUser: true,
                        child: Text(
                          "Hello LAILA!",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: Colors.black),
                        ),
                      ),
                      ToastieChatBubble(
                        isMsgUser: false,
                        child: Text(
                          "Hi there, my name is LAILA (lˈe͡ɪlə), your legal assistant👋. Happy to be in your service! Let me know what I can do for you. To communicate with me, you can type ⌨️, take a photo 📸, or just talk with me 🎙️.",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      ToastieChatBubble(
                        isMsgUser: true,
                        child: Text(
                          "Hey Laila! My realtor asked me for a “realtors fee” when I went for an on-site visit of a potential house I want to buy. Is this legal?",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    ],
      
      
      
      
      
                  ),
                ),
      
                ChatInputGroup(
                  textController: _textController,
                  onSend: () {
      
                    print(_textController.text);
                    
                    // chatProvider.getCurrentChatInstance(authProvider.user.uid);
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
