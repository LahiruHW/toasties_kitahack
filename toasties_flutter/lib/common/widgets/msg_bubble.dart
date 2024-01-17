import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
// import 'package:flutter_gemini/flutter_gemini.dart';
// import 'package:toasties_flutter/common/entity/message.dart';

class ToastieChatBubble extends StatelessWidget {
  const ToastieChatBubble({
    super.key,
    required this.isMsgUser,
    required this.child,
    // required this.message,
  });

  final bool isMsgUser;
  final Widget child;
  // final Message message;

  @override
  Widget build(BuildContext context) {
    return isMsgUser
    // return message.isMsgUser
        ? _buildUserChatBubble(context)
        : _buildAIChatBubble(context);
  }

  ChatBubble _buildAIChatBubble(BuildContext context) {
    return ChatBubble(
      clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(
        left: 10,
        right: 80,
        top: 10,
        bottom: 10,
      ),
      padding: const EdgeInsets.all(15),
      elevation: 4,
      shadowColor:
          Theme.of(context).colorScheme.background.computeLuminance() > 0.5
              ? Colors.black
              : Theme.of(context).colorScheme.primary,
      child: _buildChild(context),
    );
  }

  ChatBubble _buildUserChatBubble(BuildContext context) {
    return ChatBubble(
        clipper: ChatBubbleClipper5(type: BubbleType.sendBubble),
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.only(
          left: 80,
          right: 10,
          top: 10,
          bottom: 10,
        ),
        padding: const EdgeInsets.all(15),
        backGroundColor: Colors.white,
        elevation: 0,
        child: _buildChild(context));
  }

  Widget _buildChild(BuildContext context) {
    if (child is Text) {
      return child;
    }

    // if (child is Image) {
    //   return child;
    // }

    // if (child is GeminiResponseTypeView) {
    //   return child;
    // }

    return const Text("❌❌ CHILD WIDGET ERROR ❌❌");
  }
}


extension Text2 on Text{
  // create a getter for the text color
  Color get textColor => style?.color ?? Colors.black;
}
