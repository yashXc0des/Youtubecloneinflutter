import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtubeclonenow2/auth/model/user_model.dart';

final userDataServiceProvider =Provider((ref)=>UserDataService(
  firestore: FirebaseFirestore.instance,
  auth:FirebaseAuth.instance,)
  );
class UserDataService {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  UserDataService({
    required this.firestore,
    required this.auth,
  });

  Future<void> addUserDataToFireStore({
    required String displayName,
    required String username,
    required String email,
    required String profilePic,
    required String description,
  }) async {
    UserModel user = UserModel(
      displayName: displayName,
      username: username,
      email: email,
      profilePic: profilePic,
      subscription: [],
      videos: 0,
      userId: auth.currentUser!.uid,
      description: description,
      type: 'user',
    );

    try {
      await firestore.collection('users').doc(auth.currentUser!.uid).set(user.toMap());
      print('User data added to Firestore successfully.');
    } catch (e) {
      print('Error adding user data to Firestore: $e');
    }
  }
  Future<UserModel> fetchCurrentUserData() async {
    final currentUserMap= await firestore.collection("users").doc(auth.currentUser!.uid).get();
    UserModel user=UserModel.fromMap(currentUserMap.data()!);
    return user;
  }
}
