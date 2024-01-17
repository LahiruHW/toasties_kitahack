
import 'package:flutter/material.dart';
import 'package:toasties_flutter/common/entity/settings.dart';

// contains the state of the app
class ToastieStateProvider extends ChangeNotifier {

  late UserSettings settings;

  ToastieStateProvider(){
    // initialize the state of the app
    settings = UserSettings();
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

