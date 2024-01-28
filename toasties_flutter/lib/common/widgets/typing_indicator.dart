import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({
    super.key,
    required this.loading,
  });

  final bool loading;

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: const EdgeInsets.symmetric(vertical: 5),
      duration: const Duration(milliseconds: 200),
      height: widget.loading ? 30 : 0,
      child: Row(
        children: [
          Container(
            height: 5,
            width: 5,
            margin: const EdgeInsets.all(10),
            child: const CircularProgressIndicator(
              color: Colors.grey,
              strokeWidth: 2,
            ),
          ),

          // const Text(
          //   'LAILA is typing...',
          //   style: TextStyle(
          //     color: Colors.grey,
          //   ),
          // )

          AnimatedTextKit(
            isRepeatingAnimation: true,
            animatedTexts: [
              TypewriterAnimatedText(
                "LAILA is typing...",
                speed: const Duration(milliseconds: 100),
                textStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
