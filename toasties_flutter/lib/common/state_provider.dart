
import 'package:flutter/material.dart';

// contains the state of the app
class StateProvider extends ChangeNotifier {


  StateProvider();

  void incrementCounter() {
    notifyListeners();
  }



}

