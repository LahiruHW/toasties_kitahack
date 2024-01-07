import 'package:flutter/material.dart';

class BaseEntrace extends StatefulWidget {
  const BaseEntrace({
    super.key,
    this.bodyWidget,
  });

  final Widget? bodyWidget;

  @override
  State<BaseEntrace> createState() => _BaseEntraceState();
}

class _BaseEntraceState extends State<BaseEntrace> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            // add animating gradient background here
            widget.bodyWidget!,
          ],
        ),
      ),
    );
  }
}
