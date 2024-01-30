// include all the utility functions for cloud firestore services here as static functions

// ignore_for_file: prefer_function_declarations_over_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toasties_flutter/common/entity/index.dart';
import 'package:toasties_flutter/common/utility/toastie_storage_services.dart';

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
  static Future<Map<String, dynamic>> setupUserProfile(
      String userID, String? userName) async {
    // only initialize the user profile if it doesn't exist - needed for google login
    final userProfile = await userProfileDocRef(userID).get();

    Map<String, dynamic> returnMap = {
      'userProfile': null,
      'currentChat': null,
      'savedChats': null,
    };

    if (userProfile.exists) {
      debugPrint("--------------- PROFILE ALREADY EXISTS IN FIREBASE");

      final userProfile =
          await getUserProfileData(userID).then((userProfileData) {
        final userProfile = UserLocalProfile.fromJson(userProfileData);
        debugPrint("--------------- LOCAL PROFILE: $userProfile");
        return userProfile;
      });

      final currentChat =
          await getCurrentChatData(userID).then((currentChatData) {
        final currentChat = Chat.fromMap(currentChatData);
        debugPrint("--------------- CURRENT CHAT: $currentChat");
        return currentChat;
      });

      final List<Chat> savedChats =
          await getAllSavedChatData(userID).then((savedChatsData) {
        if (savedChatsData.isEmpty) {
          debugPrint("--------------- NO SAVED CHATS");
          return [];
        } else {
          final savedChats =
              savedChatsData.map((json) => Chat.fromMap(json)).toList();
          debugPrint("--------------- SAVED CHATs: $savedChatsData");
          return savedChats;
        }
      });

      final currentChatInStorage = await ToastiesFirebaseStorageServices.readCurrentChatFile(userID);
      debugPrint("--------------- CURRENT CHAT IN FBSTORAGE: $currentChatInStorage");

      returnMap['userProfile'] = userProfile;
      returnMap['currentChat'] = currentChat;
      returnMap['savedChats'] = savedChats;

      return returnMap;
    } else {
      return initializeNewUserProfile(userID, userName);
    }
  }

  /// initialize a new user's profile data
  static Future<Map<String, dynamic>> initializeNewUserProfile(
      String userID, String? userName) async {
    final newSettings = UserSettings();
    final userProfile = UserLocalProfile(
      userName: userName,
      settings: newSettings,
    );
    final newChat = Chat();
    final savedChats = [];

    Map<String, dynamic> returnMap = {
      'userProfile': userProfile,
      'currentChat': newChat,
      'savedChats': savedChats,
    };

    // await userProfileDocRef(userID).set({
    //   'userName': userName ?? "",
    //   'settings': newSettings.toJson(),
    // });
    await userProfileDocRef(userID).set(userProfile.toJson());

    await chatsDocRef(userID).set({
      'currentChat': newChat.toMap(),
    });

    await savedChatCollection(userID).doc("default").set({
      'alert': "DO NOT READ THIS DOCUMENT",
    });

    return returnMap;
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

  /// get a Future of the user's currentChat data from firestore
  static Future<Map<String, dynamic>> getCurrentChatData(String userID) {
    return chatsDocRef(userID).get().then((docSnap) {
      var data = docSnap.data()?["currentChat"] as Map<String, dynamic>;
      if (docSnap.exists) {
        return Future<Map<String, dynamic>>.value(data);
      } else {
        return Future<Map<String, dynamic>>.value({});
      }
    });
  }

  /// get a Future of the user's currentChat data from firestore
  static Future<Chat> getCurrentChat(String userID) async {
    final json = await getCurrentChatData(userID);
    final currentChat = Chat.fromMap(json);
    return currentChat;
  }

  /// get a Future list of all the saved chats from the user's firestore
  static Future<List<Map<String, dynamic>>> getAllSavedChatData(String userID) {
    return savedChatCollection(userID).get().then((querySnap) {
      // var data = querySnap.docs.map((doc) => doc.data()).toList();

      // only get all the saved chats that are not the default one
      var data = querySnap.docs
          .where((doc) => doc.id != "default")
          .map((doc) => doc.data())
          .toList();

      if (querySnap.docs.isNotEmpty) {
        return Future<List<Map<String, dynamic>>>.value(data);
      } else {
        return Future<List<Map<String, dynamic>>>.value([]);
      }
    });
  }

  /// get a Future list of all the saved chats
  static Future<List<Chat>> getAllSavedChats(String userID) async {
    final jsonList = await getAllSavedChatData(userID);
    final savedChats = jsonList.map((json) => Chat.fromMap(json)).toList();
    return savedChats;
  }

  /// get a Future of one specific savedChat, given the chatID
  static Future<Map<String, dynamic>> getSavedChat(
      String userID, String chatID) {
    return savedChatCollection(userID).doc(chatID).get().then((docSnap) {
      var data = docSnap.data() as Map<String, dynamic>;
      if (docSnap.exists) {
        return Future<Map<String, dynamic>>.value(data);
      } else {
        return Future<Map<String, dynamic>>.value({});
      }
    });
  }

  /// restore the current chat from the saved chat
  static Future<void> restoreChat(String userID, String chatID) async {
    // get the saved chat
    final savedChat = await getSavedChat(userID, chatID);

    // update the current chat
    return chatsDocRef(userID).update({"currentChat": savedChat});
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////

  /// update the user's profile data
  static Future<void> updateUserProfileData(
      String userID, Map<String, dynamic> data) {
    return userProfileDocRef(userID).update(data);
  }

  /// update the user's currentChat data
  static Future<void> updateCurrentChatData(String userID, Chat currentChat) {
    return chatsDocRef(userID).update({
      'chatID': currentChat.chatID,
      'chatName': currentChat.chatName,
      'currentChat': currentChat.toMap(),
      'timeSaved': Timestamp.now(),
    });
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////

  // /// clear alll docs in the "chat" collection
  // static Future<void> nukeChatCollection() async {
  //   final querySnap = await chatCollection.get();

  //   for (var doc in querySnap.docs) {
  //     (doc.id != "PLACEHOLDER") ? doc.reference.delete() : null;
  //   }

  //   // Future.delayed(const Duration(seconds: 3)).then((value) {
  //   //   for (var doc in querySnap.docs) {
  //   //     doc.reference.collection("savedChats").get().then(
  //   //       (subQuerySnap) {
  //   //         for (var doc in subQuerySnap.docs) {
  //   //           doc.reference.delete();
  //   //         }
  //   //       },
  //   //     );
  //   //   }
  //   // });

  // }

  // /// clear alll docs in the "user_profile" collection
  // static Future<void> nukeUserProfileCollection() async {
  //   final querySnap = await userCollection.get();
  //   for (var doc in querySnap.docs) {
  //     (doc.id != "PLACEHOLDER") ? doc.reference.delete() : null;
  //   }
  // }

  // static Future<void> nukeAllCollections() async {
  //   await nukeChatCollection();
  //   await nukeUserProfileCollection();
  // }

  static spoofData(String userID) async {
    /// initialize a new user's profile data{
    final newChat = Chat(msgs: [
      Message(
        timeCreated: Timestamp.now(),
        isMsgUser: true,
        content: "Hello LAILA",
      ),
      Message(
        timeCreated: Timestamp.now(),
        isMsgUser: false,
        content:
            "My name is LAILA (lˈe͡ɪlə), your legal assistant👋. Happy to be in your service! Let me know what I can do for you. To communicate with me, you can type ⌨️, take a photo 📸, or just talk with me 🎙️.",
      ),
      Message(
        timeCreated: Timestamp.now(),
        isMsgUser: true,
        content: "How are you?",
      ),
    ]);

    await chatsDocRef(userID).update({
      'currentChat': newChat.toMap(),
    });
  }
}
