import 'package:flutter/material.dart';
// import 'package:toasties_flutter/common/widgets/toasties_appbar.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({
    super.key,
  });

  static const String routeName = '/saved';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // appBar: ToastiesAppBar(
      //   appBarTitle: "LegalEase",
      //   showBackButton: false,
      //   showTitle: true,
      //   trailing: IconButton(
      //     icon: const Icon(Icons.menu),
      //     style: ButtonStyle(
      //       foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      //     ),
      //     onPressed: () {},
      //   ),
      // ),
      body: Center(
        child: Text(
          'Saved Page',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
