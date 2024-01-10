
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toasties_flutter/common/entity/message.dart';

class Chat{

  Chat({
    this.chatName = "New Consultation",
    this.msgs,
    this.timeSaved,
  });

  String? chatName;
  List<Message>? msgs;
  Timestamp? timeSaved;

  void addMessage(Message message){
    msgs ??= [];
    msgs!.add(message);
  }

  factory Chat.fromMap(Map<String, dynamic> json) {
    return Chat(
      chatName: json['chatName'],
      msgs: List<Message>.from(json['msgs']?.map((x) => Message.fromMap(x))),
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'chatName': chatName,
      'msgs': msgs?.map((x) => x.toMap()).toList(),
    };
  }  


}
