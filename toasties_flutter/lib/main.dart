import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:toasties_flutter/common/state_provider.dart';
import 'package:toasties_flutter/home.dart';
import 'package:toasties_flutter/toasties_theme.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // this is the root of the app:
  //  - MultiProvider allows for multiple providers to be used
  //  - ChangeNotifierProvider provides the state of the app
  final appRuntime = MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ToastieStateProvider(),
      ),
    ],
    child: const LegalEaseApp(),
  );

  // time delay to simulate loading time for the splash screen
  Future.delayed(
    const Duration(milliseconds: 1800),   // you can also write this as 1800.ms
  ).then(
    (value) {
      FlutterNativeSplash.remove();
      runApp(appRuntime);
    },
  );
}

class LegalEaseApp extends StatelessWidget {
  const LegalEaseApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LegalEase',
      themeMode: ThemeMode.system,
      theme: ToastiesAppTheme.lightTheme,
      darkTheme: ToastiesAppTheme.darkTheme,
      themeAnimationDuration: const Duration(milliseconds: 500),
      themeAnimationCurve: Curves.easeInOut,
      debugShowCheckedModeBanner: false,
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}


