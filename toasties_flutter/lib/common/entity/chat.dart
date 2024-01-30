import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toasties_flutter/common/entity/message.dart';

class Chat {
  String? chatName;
  List<Message>? msgs = [];
  Timestamp? timeSaved;
  String? chatID; // if saved before, this field will be populated

  Chat(
      {this.chatName = "New Consultation",
      this.msgs,
      this.timeSaved,
      this.chatID});

  void addMessage(Message message) {
    msgs!.add(message);
    timeSaved = message.timeCreated;
  }

  factory Chat.fromMap(Map<String, dynamic> json) {
    return Chat(
      chatName: json['chatName'],
      msgs: List<Message>.from(json['msgs']?.map((x) => Message.fromMap(x))),
      timeSaved: json['timeSaved'],
      chatID: json['chatID'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chatName': chatName,
      'msgs': msgs == null
          ? FieldValue.arrayUnion([])
          : msgs!.map((x) => x.toMap()).toList(),
      'timeSaved': timeSaved ?? Timestamp.now(),
      'chatID': chatID,
    };
  }

  /// used for firebase storage
  factory Chat.fromJson(Map<String, dynamic> json) {
    // convert string to timestamp
    final timeSaved = Timestamp.fromDate(DateTime.parse(json['timeSaved']));
    return Chat(
      chatName: json['chatName'],
      msgs: List<Message>.from(json['msgs']?.map((x) => Message.fromMap(x))),
      timeSaved: timeSaved,
      chatID: json['chatID'],
    );
  }

  /// used for firebase storage
  Map<String, dynamic> toJson() {
    // convert timestamp to string
    final timeSavedString = timeSaved!.toDate().toString();
    return {
      'chatName': chatName,
      'msgs': msgs == null
          ? FieldValue.arrayUnion([])
          : msgs!.map((x) => x.toJson()).toList(),
      'timeSaved': timeSavedString,
      'chatID': chatID,
    };
  }

  @override
  String toString() {
    return 'Chat: {chatName: $chatName, lastMesage: ${msgs!.last}, msgCount: ${msgs!.length}, timeSaved: $timeSaved, chatID: $chatID}';
  }
}
