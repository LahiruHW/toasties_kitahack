
import 'package:flutter/material.dart';
import 'package:toasties_flutter/common/entity/chat.dart';

class ToastiesChatProvider extends ChangeNotifier {

  // String userID;

  Chat? chat;

  /// List of saved chats
  late List<Chat> savedChats;



  // list of saved laws

  // ToastiesChatProvider({required this.userID}) {
  //   // getCurrentChatInstance(userID);
  //   debugPrint('------------------------------ ChatProvider initialized');
  // }

  ToastiesChatProvider() {
    // getCurrentChatInstance(userID);
    debugPrint('------------------------------ ChatProvider initialized');
  }




}
