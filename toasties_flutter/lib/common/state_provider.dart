
import 'package:flutter/material.dart';

// contains the state of the app
class ToastieStateProvider extends ChangeNotifier {


  ToastieStateProvider();

  void incrementCounter() {
    notifyListeners();
  }



}

