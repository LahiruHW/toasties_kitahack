import 'package:flutter/material.dart';

const statusBarHeight = 35.0;

class ToastiesAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// A custom appbar for the LegalEase app that uses the [NavigationToolbar] widget
  /// that deals with the positioning of the [leading], [middle] and [trailing] widgets
  const ToastiesAppBar({
    super.key,
    required this.appBarTitle,
    this.showBackButton = false,
    this.showTitle = true,
    this.trailing,
  });

  final String appBarTitle;
  final bool showBackButton;
  final bool showTitle;
  final Widget? trailing;

  final gradientDecoration = const BoxDecoration(
    gradient: LinearGradient(
      colors: <Color>[
        Color.fromRGBO(0, 109, 170, 1.0),
        Color.fromRGBO(0, 65, 131, 1),
      ],
    ),
  );

  final transparentDeco = const BoxDecoration(
    color: Colors.transparent,
  );

  @override
  Widget build(BuildContext context) {
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final bool canPop = parentRoute?.canPop ?? false;

    return Material(
      // color: Colors.grey.withOpacity(0.06),
      elevation: 0,
      child: Stack(
        fit: StackFit.expand,
        children: [
          SizedBox.expand(
            child: Container(
              decoration: gradientDecoration,
            ),
          ),
          Column(
            children: [
              Container(
                height: statusBarHeight,
                width: double.infinity,
                decoration: transparentDeco
              ),
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: gradientDecoration,
                    ),
                    NavigationToolbar(
                      centerMiddle: false,
                      leading: !showBackButton
                          ? null
                          : IconButton(
                              icon: const Icon(Icons.arrow_back),
                              onPressed: () => showBackButton & canPop
                                  ? Navigator.of(context).pop()
                                  : null,
                            ),
                      middle: showTitle
                          ? Text(
                              appBarTitle,
                              style:
                                  Theme.of(context).appBarTheme.titleTextStyle,
                            )
                          : null,
                      trailing: trailing,
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size(double.infinity, 70); // (width, height) of the appbar
}
