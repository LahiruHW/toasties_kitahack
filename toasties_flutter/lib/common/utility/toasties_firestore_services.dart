// include all the utility functions for firebase services here as static functions

// ignore_for_file: prefer_function_declarations_over_variables

import 'package:cloud_firestore/cloud_firestore.dart';

class ToastiesFirestoreServices {
  // References to the ddb collections
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static final userDocRef =
      (userId) => firestore.collection('user_profile').doc(userId);

  static final chatCollection = firestore.collection('chat');
  static final chatsDocRef = (userId) => chatCollection.doc(userId);
  static final currentchatRef = (userId) => chatsDocRef(userId).get().then((docSnap) => docSnap.data()?["currentChat"]);
  static final savedChatCollection = (userId) => chatsDocRef(userId).collection("savedChats");

  ///////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////

  /// get a Future of the user's cloud firestore profile data
  static Future<Map<String, dynamic>> getUserProfileData(String userID) {
    // if docs with the userID as the docID exists,
    // return the data as a Map<String, dynamic>
    return userDocRef(userID).get().then((docSnap) {
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
