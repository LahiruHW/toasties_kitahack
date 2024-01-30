// include all the utility functions for firebase storage services here as static functions

// ignore_for_file: prefer_function_declarations_over_variables

import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';

class ToastiesFirebaseStorageServices {
  static final FirebaseStorage storage = FirebaseStorage.instance;

  static final userProfileFolderRef = storage.ref().child('user_profile');

  static final chatFolderRef = storage.ref().child('chat');
  static final userChatFolderRef = (userID) => chatFolderRef.child('/$userID');

  static final userCurrentChatFileRef =
      (userID) => userChatFolderRef(userID).child('/currentChat/currentChat.json');

  static final userSavedChatsFolderRef =
      (userID) => userChatFolderRef(userID).child('/saved_chats');
  static final userSavedChatFileRef = (userID, chatID) =>
      userSavedChatsFolderRef(userID).child('/$chatID.json');

  /// read current chat file of a user
  static Future<Map<String, dynamic>> readCurrentChatFile(String userID) async {
    final fileRef = userCurrentChatFileRef(userID); // get file reference
    final fileData = await fileRef.getData(); // get file data

    final stringData = utf8.decode(fileData!); // convert file data to string
    // final stringData = String.fromCharCodes(fileData!); // convert file data to string
    

    final jsonData = jsonDecode(stringData) as Map<String, dynamic>; // convert string data to json
    
    print(jsonData);

    return jsonData;
  }

  /// write to current chat file of a user
  static Future<void> writeCurrentChatFile(
      String userID, Map<String, dynamic> currentChatData) async {

    final fileRef = userCurrentChatFileRef(userID); // get file reference

    // final stringData = jsonEncode(currentChatData); // convert json to string
    final stringData = json.encode(currentChatData); // convert json to string
    
    
    final fileData = utf8.encode(stringData); // convert string to file data
    await fileRef.putData(fileData); // write file data to file reference

    // // directory convert the string to utf8
    // final x = utf8.encode(stringData); // convert string to file data


  }


}
