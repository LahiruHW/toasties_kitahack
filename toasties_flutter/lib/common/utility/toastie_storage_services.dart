// include all the utility functions for firebase storage services here as static functions

// ignore_for_file: prefer_function_declarations_over_variables

import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

// TODO:_ read particular saved chat file into memory


class ToastiesFirebaseStorageServices {
  static final FirebaseStorage storage = FirebaseStorage.instance;

  static final userProfileFolderRef = storage.ref().child('user_profile');

  static final chatFolderRef = storage.ref().child('chat');
  static final userChatFolderRef = (userID) => chatFolderRef.child('/$userID');
  static final userCurrentChatFileRef = (userID) =>
      userChatFolderRef(userID).child('/currentChat/currentChat.json');

  static final userSavedChatsFolderRef =
      (userID) => userChatFolderRef(userID).child('/saved_chats');
  static final userSavedChatFileRef = (userID, chatID) =>
      userSavedChatsFolderRef(userID).child('/$chatID.json');

  /// read current chat file of a user
  static Future<Map<String, dynamic>> readCurrentChatFile(String userID) async {
    final fileRef = userCurrentChatFileRef(userID); // get file reference
    final fileData = await fileRef.getData(); // get file data
    final stringData = utf8.decode(fileData!); // convert file data to string
    // convert string data to json
    final jsonData = jsonDecode(stringData)
        as Map<String, dynamic>; 
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


  /// create a new chat folder, along with all it's subfolders, for a new user
  static Future<void> createNewChatFolder(String userID) async {
    // get a temprary file path in storage
    final tempDir = await getTemporaryDirectory();
    final tempFilePath = tempDir.path;
    final currentChatRef = userCurrentChatFileRef(userID);

    ////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////

    // create an empty file name currentChat.json and add some default data
    final currentChatFile =
        await File('$tempFilePath/currentChat.json').create();
    final tempChatData = {
      'chatName': 'PLACEHOLDER CHAT NAME',
      'msgs': [],
      'timeSaved': '',
      'chatID': '',
    };
    final tempChatString = json.encode(tempChatData);
    await currentChatFile.writeAsString(tempChatString);
    // convert the file to bytes and upload it to firebase storage
    final bytes = currentChatFile.readAsBytesSync();
    await currentChatRef.putData(bytes);
    await currentChatFile.delete(); // delete it after uploading

    ////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////

    // create an empty file name placeholder.json and add some default data
    final savedChatFile = await File('$tempFilePath/placeholder.json').create();
    final tempSavedChatData = {
      'msg': 'THIS IS A PLACEHOLDER SAVED CHAT',
    };
    final tempSavedChatString = json.encode(tempSavedChatData);
    await savedChatFile.writeAsString(tempSavedChatString);
    // convert the file to bytes and upload it to firebase storage
    final savedChatBytes = savedChatFile.readAsBytesSync();
    final savedChatRef = userSavedChatFileRef(userID, 'placeholder');
    await savedChatRef.putData(savedChatBytes);
    await savedChatFile.delete(); // delete it after uploading
  }


}
