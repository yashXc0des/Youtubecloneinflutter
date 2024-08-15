import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtubeclonenow2/auth/repository/user_data_service.dart';
import '../model/user_model.dart';

// Provide UserDataService
final userDataServiceProvider = Provider<UserDataService>((ref) => UserDataService(
  firestore: FirebaseFirestore.instance,
  auth: FirebaseAuth.instance,
));

// Provide the current user data stream
final currentUserProvider = StreamProvider<UserModel>((ref) {
  final userDataService = ref.watch(userDataServiceProvider);
  return userDataService.userStream();
});

// Provide data for any user by ID
final anyUserDataProvider = StreamProvider.family<UserModel, String>((ref, userId) {
  final userDataService = ref.watch(userDataServiceProvider);
  return userDataService.userStreamById(userId);
});
