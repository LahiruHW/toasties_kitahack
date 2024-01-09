import 'package:ai_chatbot/models/conversation.dart';
import 'package:ai_chatbot/views/widgets/message_widget.dart';
import 'package:flutter/material.dart';

class ChatListView extends StatefulWidget {
  final List<Conversation> conversations;
  const ChatListView({super.key, required this.conversations});

  
  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.conversations.length,
      itemBuilder: (context, index) {
        Conversation conversation = widget.conversations[index];
        return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MessageWidget(text: conversation.question),
          const SizedBox(height: 32),
          MessageWidget(text: conversation.answer, fromAi: true)
        ],
      );
      },
    );
  }
}