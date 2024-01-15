// include all the utility functions for firebase services here as static functions

// ignore_for_file: prefer_function_declarations_over_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toasties_flutter/common/entity/index.dart';

class ToastiesFirestoreServices {
  // References to the ddb collections
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static final userCollection = firestore.collection('user_profile');
  static final userProfileDocRef = (userId) => userCollection.doc(userId);

  static final chatCollection = firestore.collection('chat');
  static final chatsDocRef = (userId) => chatCollection.doc(userId);
  static final currentchatRef = (userId) => chatsDocRef(userId)
      .get()
      .then((docSnap) => docSnap.data()?["currentChat"]);
  static final savedChatCollection =
      (userId) => chatsDocRef(userId).collection("savedChats");

  // /////////////////////////////////////////////////////////////////////////////////////////////
  // /////////////////////////////////////////////////////////////////////////////////////////////
  // /////////////////////////////////////////////////////////////////////////////////////////////
  // /////////////////////////////////////////////////////////////////////////////////////////////

  /// initialize user profile - username can be null for a firstime google login
  static void setupUserProfile(String userID, String? userName) async {
    // only initialize the user profile if it doesn't exist - needed for google login
    final userProfile = await userProfileDocRef(userID).get();
    if (userProfile.exists) {
      debugPrint("--------------- GOOGLE PROFILE ALREADY EXISTS IN FIREBASE");
      // TODO:_UPDATE THE USER PROFILE DATA (i.e all the firebase data for the user)


      getUserProfileData(userID).then((value) {
        debugPrint("--------------- GOOGLE PROFILE DATA: $value");
      });

      getCurrentChatData(userID).then((value) {
        debugPrint("--------------- GOOGLE CURRENT CHAT DATA: $value");
      });

      getAllSavedChatData(userID).then((value) {
        debugPrint("--------------- GOOGLE SAVED CHAT DATA: $value");
      });


      return;
    } else {
      initializeNewUserProfile(userID, userName);
    }
  }

  static void initializeNewUserProfile(String userID, String? userName) async {
    /// initialize a new user's profile data{

    final newSettings = UserSettings();
    final newChat = Chat();

    await userProfileDocRef(userID).set({
      'userName': userName ?? "",
      'settings': newSettings.toJson(),
    });

    await chatsDocRef(userID).set({
      'currentChat': newChat.toJson(),
    });

    await savedChatCollection(userID).doc("default").set({
      'alert': "DO NOT READ THIS DOCUMENT",
    });
  }

  /// get a Future of the user's cloud firestore profile data
  static Future<Map<String, dynamic>> getUserProfileData(String userID) {
    // if docs with the userID as the docID exists,
    // return the data as a Map<String, dynamic>
    return userProfileDocRef(userID).get().then((docSnap) {
      var data = docSnap.data() as Map<String, dynamic>;
      if (docSnap.exists) {
        return Future<Map<String, dynamic>>.value(data);
      } else {
        return Future<Map<String, dynamic>>.value({});
      }
    });
  }

  /// get a Future of the user's currentChat data
  static Future<Map<String, dynamic>> getCurrentChatData(String userID) {
    return currentchatRef(userID).then((chatID) {
      return chatsDocRef(userID)
          .collection("savedChats")
          .doc(chatID)
          .get()
          .then((docSnap) {
        var data = docSnap.data() as Map<String, dynamic>;
        if (docSnap.exists) {
          return Future<Map<String, dynamic>>.value(data);
        } else {
          return Future<Map<String, dynamic>>.value({});
        }
      });
    });
  }

  // get a Future list of all the saved chats
  static Future<List<Map<String, dynamic>>> getAllSavedChats(String userID) {
    return savedChatCollection(userID).get().then((querySnap) {
      var data = querySnap.docs.map((doc) => doc.data()).toList();
      if (querySnap.docs.isNotEmpty) {
        return Future<List<Map<String, dynamic>>>.value(data);
      } else {
        return Future<List<Map<String, dynamic>>>.value([]);
      }
    });
  }

  /// get a Future of one specific savedChat, given the chatID
  static Future<Map<String, dynamic>> getSavedChat(String userID, String chatID) {
    return savedChatCollection(userID).doc(chatID).get().then((docSnap) {
      var data = docSnap.data() as Map<String, dynamic>;
      if (docSnap.exists) {
        return Future<Map<String, dynamic>>.value(data);
      } else {
        return Future<Map<String, dynamic>>.value({});
      }
    });
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////

  /// update the user's profile data
  static Future<void> updateUserProfileData(String userID, Map<String, dynamic> data) {
    return userDocRef(userID).update(data);
  }

  /// update the user's currentChat data --> add a new message to the chat
  static Future<void> sendCurrentChatMessage(String userID, Map<String, dynamic> data) {
    // userId --> currentChat --> msgs --> add new message
    return chatsDocRef(userID).update({
      "currentChat": {
        "msgs": FieldValue.arrayUnion([data])
      }
    });
  }

  /// take the current chat and save it in a new document in the savedChats collection
  static Future<void> saveChat(String userID, Map<String, dynamic> data) async {

    // create a new document 
    final newDocRef = await savedChatCollection(userID).add(data);


    // add the currentChat data to the new document
    
    // userId --> savedChats --> add new doc here
  
  }


}
