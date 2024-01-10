
// include all the utility functions for firebase services here as static functions


import 'package:cloud_firestore/cloud_firestore.dart';

class ToastiesFirestoreServices {


    // References to the ddb collections
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference userProfileCollection = FirebaseFirestore.instance.collection('user_profile');
  final CollectionReference chatsCollection = FirebaseFirestore.instance.collection('chat');


  /// get the user's data from the database
  static Future<Map<String, dynamic>> getUserData(String userID) async {
    final CollectionReference userProfileCollection = FirebaseFirestore.instance.collection('user_profile');
    final DocumentSnapshot documentSnapshot = await userProfileCollection.doc(userID).get();
    if (documentSnapshot.exists) {
      final userData = documentSnapshot.data();
      return userData as Map<String, dynamic>;
    } else {
      throw Exception('Document does not exist on the database');
    }
  }


}

