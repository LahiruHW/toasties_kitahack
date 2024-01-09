import 'package:flutter/material.dart';
import 'package:ai_chatbot/constants/colours.dart';

class ChatTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String?) onSubmitted;

  const ChatTextField({super.key, required this.controller, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: CustomColours.lightBlue,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white, width: .8)),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Flexible(
            child: TextField(
              style: const TextStyle(color: Colors.white),
              controller: controller,
              cursorColor: Colors.white,
              decoration: const InputDecoration(border: InputBorder.none),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              onPressed: () {
                onSubmitted(controller.text);
                controller.clear();
              },
              style: IconButton.styleFrom(
                  backgroundColor: CustomColours.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4))),
              icon: const Icon(Icons.send_outlined),
            ),
          )
        ],
      ),
    );
  }
}
