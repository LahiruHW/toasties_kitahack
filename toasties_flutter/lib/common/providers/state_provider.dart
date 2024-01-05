
import 'package:flutter/material.dart';
import 'package:toasties_flutter/common/entity/settings.dart';

// contains the state of the app
class ToastieStateProvider extends ChangeNotifier {

  late Settings settings;

  ToastieStateProvider(){
    // initialize the state of the app
    settings = Settings(
      isDarkMode: false,
    );
    debugPrint('------------------------------ ToastieStateProvider initialized');
  }

  void updateSettings({
    bool? isDarkMode,
  }) {
    settings.updateSettings(
      isDarkMode: isDarkMode,
    );
    notifyListeners();
  }

}

