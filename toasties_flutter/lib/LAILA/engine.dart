// REFER TO THESE SECTIONS FOR HOW TO USE THE GEMINI API:
// https://pub.dev/packages/flutter_gemini#:~:text=list%20of%20images-,Multi%2Dturn%20conversations%20(chat),-Using%20Gemini%2C%20you

import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:toasties_flutter/common/constants/env4toasties.dart';

class LAILA {

  LAILA._();
  
  static void init() {
    Gemini.init(apiKey: ToastiesEnv.apiKey, enableDebugging: true);
  }







  // final gemini = Gemini.instance;
  // gemini
  //     .text("Write a story about a magic backpack.")
  //     .then((value) => print(value?.output))
  //     /// or value?.content?.parts?.last.text
  //     .catchError((e) => print(e));

}
