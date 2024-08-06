import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final editSettingsProvider = Provider<EditSettingFields>((ref) {
  return EditSettingFields(firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance,);
});

class EditSettingFields{
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  EditSettingFields({required this.firestore,required this.auth});

   editDisplayName(displayName)async {
    await firestore.collection("users").doc(auth.currentUser!.uid).update({
      'displayName': displayName,
    });
  }
  Future<void> editUserName(username)async {
    await firestore.collection("users").doc(auth.currentUser!.uid).update({
      'username':username,
    });
  }
  Future<void> editDiscription(discription)async{
    await firestore.collection("users").doc(auth.currentUser!.uid).update({
      "description":discription
    });
  }
  Future<void> updateProfilePicture(String imageUrl) async {
    await firestore.collection("users").doc(auth.currentUser!.uid).update({
      'profilePic': imageUrl,
    });
  }
}
