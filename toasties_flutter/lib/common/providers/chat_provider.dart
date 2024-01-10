// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toasties_flutter/common/entity/chat.dart';
import 'package:toasties_flutter/common/entity/message.dart';

class ToastiesChatProvider extends ChangeNotifier {


  late Chat chat;

  // // References to the ddb collections
  // final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // final CollectionReference chatsCollection = FirebaseFirestore.instance.collection('chat');

  // list of saved chats

  // list of saved laws

  ToastiesChatProvider() {
    
    // getCurrentChatInstance(userID);
    debugPrint('------------------------------ ChatProvider initialized');
  }

  // void getCurrentChatInstance(String userID) {
  //   final tempChat = Chat();

  //   // get the chat instance from the database
  //   chatsCollection.doc(userID).get().then(
  //     (DocumentSnapshot documentSnapshot) {
  //       if (documentSnapshot.exists) {
  //         final currentChatJSON = documentSnapshot.data();

  //         final chatName = (currentChatJSON as Map<String, dynamic>)['chatName'];
  //         debugPrint("==================== $chatName");
          
          
  //         final messages = (currentChatJSON)['msgs'];


  //         for (var message in messages) {
  //           final messageInstance = Message.fromMap((message as Map<String, dynamic>));
  //           debugPrint("==================== $messageInstance");
  //           tempChat.addMessage(messageInstance);
  //         }
  //       } else {
  //         debugPrint('Document does not exist on the database');
  //       }
  //     },
  //   );

  //   chat = tempChat;
  //   notifyListeners();
    
  // }

  /// send a message to a chat --> the chatID is the userID
  void sendMessage(Message message, String chatID) {
    

    // add the message to the chat instance



    notifyListeners();
  }


}
